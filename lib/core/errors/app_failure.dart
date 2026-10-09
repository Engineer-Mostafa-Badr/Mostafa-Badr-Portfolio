import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';

/// Why an operation failed, in terms a visitor can act on.
///
/// Visitors never see a status code or a stack trace. Every failure the app can
/// produce is mapped onto one of these cases, and each case owns two things:
/// what went wrong ([titleKey]) and what the visitor can do about it
/// ([actionKey]). That second half is the point — "something went wrong" is not
/// a message, "try WhatsApp instead" is.
enum FailureKind {
  /// No connection, DNS failure, or the request never left the device.
  offline,

  /// The request left but nothing came back in time.
  timeout,

  /// The server rejected the payload — bad email, missing field (4xx/422).
  invalidInput,

  /// Too many submissions in a short window (429).
  rateLimited,

  /// The endpoint is misconfigured, disabled, or forbidden (401/403/404).
  endpointUnavailable,

  /// The server broke (5xx).
  serverError,

  /// A 2xx response whose body was not what we expected.
  unexpectedResponse,

  /// The browser or OS refused to open an external link.
  cannotOpenLink,

  /// Anything not otherwise classified.
  unknown,
}

/// A user-facing failure: a headline, a recovery hint, and an optional
/// technical detail kept for the console only.
@immutable
class AppFailure {
  final FailureKind kind;

  /// Server-supplied explanation, when it gave one worth showing (Formspree
  /// returns human-readable validation errors, for example).
  final String? serverMessage;

  /// Never shown to the visitor — logged to help debugging.
  final String? debugDetail;

  const AppFailure(this.kind, {this.serverMessage, this.debugDetail});

  String get titleKey => 'error.${kind.name}.title';
  String get actionKey => 'error.${kind.name}.action';

  /// Headline: what happened.
  String title(BuildContext context) => Tr.k(context, titleKey);

  /// Recovery line: what to do next. Prefers the server's own wording when it
  /// sent something specific about the visitor's input.
  String action(BuildContext context) {
    if (kind == FailureKind.invalidInput &&
        serverMessage != null &&
        serverMessage!.trim().isNotEmpty) {
      return serverMessage!.trim();
    }
    return Tr.k(context, actionKey);
  }

  /// Single-line form for snackbars, where there is no room for two lines.
  String message(BuildContext context) => '${title(context)} — ${action(context)}';

  @override
  String toString() =>
      'AppFailure(${kind.name}${debugDetail != null ? ', $debugDetail' : ''})';
}

/// Translates raw exceptions and HTTP responses into an [AppFailure].
///
/// Every network call in the app funnels through here, so a new endpoint
/// automatically inherits the same vocabulary of failures instead of inventing
/// its own error strings.
class FailureMapper {
  const FailureMapper._();

  /// Classifies a thrown [error] from an HTTP call or platform channel.
  static AppFailure fromException(Object error) {
    if (error is TimeoutException) {
      return AppFailure(
        FailureKind.timeout,
        debugDetail: error.toString(),
      );
    }
    // `http` reports every transport-level problem as ClientException on both
    // web (blocked/failed fetch) and native (no route to host). Either way the
    // actionable reading for a visitor is "you appear to be offline".
    if (error is http.ClientException) {
      return AppFailure(
        FailureKind.offline,
        debugDetail: error.message,
      );
    }
    if (error is FormatException) {
      return AppFailure(
        FailureKind.unexpectedResponse,
        debugDetail: error.message,
      );
    }

    final text = error.toString().toLowerCase();
    if (text.contains('xmlhttprequest') ||
        text.contains('failed to fetch') ||
        text.contains('socketexception') ||
        text.contains('connection')) {
      return AppFailure(
        FailureKind.offline,
        debugDetail: error.toString(),
      );
    }

    return AppFailure(FailureKind.unknown, debugDetail: error.toString());
  }

  /// Classifies a non-2xx HTTP response. [body] is parsed for a human-readable
  /// server message when the status suggests the visitor's input was at fault.
  static AppFailure fromStatus(int statusCode, {String? body}) {
    final serverMessage = _extractServerMessage(body);

    if (statusCode == 422 || statusCode == 400) {
      return AppFailure(
        FailureKind.invalidInput,
        serverMessage: serverMessage,
        debugDetail: 'HTTP $statusCode',
      );
    }
    if (statusCode == 429) {
      return AppFailure(
        FailureKind.rateLimited,
        debugDetail: 'HTTP $statusCode',
      );
    }
    if (statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 404 ||
        statusCode == 410) {
      return AppFailure(
        FailureKind.endpointUnavailable,
        debugDetail: 'HTTP $statusCode',
      );
    }
    if (statusCode >= 500) {
      return AppFailure(
        FailureKind.serverError,
        debugDetail: 'HTTP $statusCode',
      );
    }
    return AppFailure(
      FailureKind.unexpectedResponse,
      serverMessage: serverMessage,
      debugDetail: 'HTTP $statusCode',
    );
  }

  /// Digs a readable sentence out of a JSON error body.
  ///
  /// Handles the shapes real backends actually return: a bare `message`/
  /// `error` string, or Formspree's `errors: [{field, message}]` list. Anything
  /// unrecognised yields null so the caller falls back to a translated string
  /// rather than showing the visitor raw JSON.
  static String? _extractServerMessage(String? body) {
    if (body == null || body.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is! Map<String, dynamic>) return null;

      final errors = decoded['errors'];
      if (errors is List && errors.isNotEmpty) {
        final messages = errors
            .whereType<Map>()
            .map((e) => e['message']?.toString())
            .where((m) => m != null && m.trim().isNotEmpty)
            .cast<String>()
            .toList();
        if (messages.isNotEmpty) return messages.join(' · ');
      }

      for (final key in ['message', 'error', 'detail']) {
        final value = decoded[key];
        if (value is String && value.trim().isNotEmpty) return value.trim();
      }
    } catch (_) {
      // Body was not JSON — nothing safe to surface.
    }
    return null;
  }
}
