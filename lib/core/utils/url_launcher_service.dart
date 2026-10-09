import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/errors/app_failure.dart';
import 'package:mostafa_badr_portfolio/core/utils/app_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens external links, and tells the visitor when it could not.
///
/// The previous implementation swallowed every exception, so a blocked popup
/// or a dead `mailto:` handler looked identical to a successful click: nothing
/// happened, and the visitor was left guessing. Now every failure surfaces a
/// message explaining what to do instead.
class UrlLauncherService {
  const UrlLauncherService._();

  /// Opens [url] and reports failure through a snackbar on [context].
  ///
  /// Pass [context] wherever one is available — it is optional only so
  /// non-widget callers still have a path. Returns true when the link opened.
  static Future<bool> open(
    String url, {
    BuildContext? context,
  }) async {
    if (url.trim().isEmpty) {
      _report(context, const AppFailure(
        FailureKind.cannotOpenLink,
        debugDetail: 'empty url',
      ));
      return false;
    }

    try {
      var uri = Uri.parse(url);
      // Resolve relative paths (e.g. "cv/Mostafa-Badr-CV.pdf") against the
      // current page origin so they work on the web build. Without this,
      // url_launcher rejects them for having no scheme.
      if (!uri.hasScheme) {
        uri = Uri.base.resolve(url);
      }

      // The canLaunchUrl pre-check is deliberately skipped: on web it returns
      // false for many same-origin URLs that launchUrl opens fine. We rely on
      // launchUrl's own return value instead.
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      if (!launched && context != null && context.mounted) {
        _report(
          context,
          AppFailure(
            FailureKind.cannotOpenLink,
            debugDetail: 'launchUrl returned false for $uri',
          ),
        );
      }
      return launched;
    } catch (error, stack) {
      debugPrint('openUrl failed for "$url": $error\n$stack');
      if (context != null && context.mounted) {
        _report(
          context,
          AppFailure(
            FailureKind.cannotOpenLink,
            debugDetail: error.toString(),
          ),
        );
      }
      return false;
    }
  }

  static void _report(BuildContext? context, AppFailure failure) {
    debugPrint('$failure');
    if (context == null || !context.mounted) return;
    AppFeedback.showFailure(context, failure);
  }
}

/// Convenience wrapper matching the call style used across the sections.
///
/// Always pass [context] so a failed link produces a visible message rather
/// than a dead click.
Future<bool> openUrl(String url, {BuildContext? context}) =>
    UrlLauncherService.open(url, context: context);
