import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mostafa_badr_portfolio/core/constants/app_links.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/errors/app_failure.dart';

/// Outcome of a contact-form submission: either it went through, or it carries
/// an [AppFailure] the UI can render verbatim.
@immutable
sealed class ContactResult {
  const ContactResult();
}

class ContactSuccess extends ContactResult {
  const ContactSuccess();
}

class ContactFailed extends ContactResult {
  final AppFailure failure;
  const ContactFailed(this.failure);
}

/// Submits the inline contact form to Formspree.
///
/// Every branch a real network call can take is handled explicitly:
/// a misconfigured endpoint, a timeout, a transport error, a 4xx with server
/// validation text, a 429, a 5xx, and a 2xx whose body says the submission was
/// rejected anyway. None of them reach the visitor as a stack trace.
class ContactService {
  final http.Client _client;
  final String _endpoint;
  final Duration _timeout;

  ContactService({
    http.Client? client,
    String endpoint = AppLinks.contactFormEndpoint,
    Duration timeout = AppDurations.networkTimeout,
  })  : _client = client ?? http.Client(),
        _endpoint = endpoint,
        _timeout = timeout;

  /// True when a real endpoint has been configured. A placeholder endpoint is
  /// a deployment mistake, and the visitor is told to use WhatsApp instead of
  /// silently sending into the void.
  bool get isConfigured =>
      _endpoint.isNotEmpty &&
      !_endpoint.contains('YOUR_FORM_ID') &&
      Uri.tryParse(_endpoint)?.hasScheme == true;

  Future<ContactResult> send({
    required String name,
    required String email,
    required String message,
  }) async {
    if (!isConfigured) {
      return const ContactFailed(
        AppFailure(
          FailureKind.endpointUnavailable,
          debugDetail: 'contact endpoint not configured',
        ),
      );
    }

    try {
      final response = await _client
          .post(
            Uri.parse(_endpoint),
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'name': name,
              'email': email,
              'message': message,
              '_replyto': email,
              '_subject': 'Portfolio contact from $name',
            }),
          )
          .timeout(_timeout);

      final status = response.statusCode;
      if (status < 200 || status >= 300) {
        return ContactFailed(
          FailureMapper.fromStatus(status, body: response.body),
        );
      }

      // A 2xx is necessary but not sufficient — Formspree can answer 200 with
      // {"ok": false} when the form is paused or over quota. Treat that as the
      // failure it is rather than showing a false success.
      final rejection = _rejectionFromBody(response.body);
      if (rejection != null) return ContactFailed(rejection);

      return const ContactSuccess();
    } catch (error, stack) {
      debugPrint('Contact form submission failed: $error\n$stack');
      return ContactFailed(FailureMapper.fromException(error));
    }
  }

  /// Inspects a 2xx body for an explicit rejection. Returns null when the body
  /// is empty, unparseable, or does not claim failure — an unrecognised
  /// success body is still a success.
  AppFailure? _rejectionFromBody(String body) {
    if (body.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is! Map<String, dynamic>) return null;

      final ok = decoded['ok'];
      final hasErrors =
          decoded['errors'] is List && (decoded['errors'] as List).isNotEmpty;

      if (ok == false || hasErrors) {
        return FailureMapper.fromStatus(422, body: body);
      }
    } catch (_) {
      // Unparseable 2xx body — Formspree accepted it; nothing to report.
    }
    return null;
  }

  void dispose() => _client.close();
}
