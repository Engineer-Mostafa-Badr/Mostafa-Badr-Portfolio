import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  if (url.isEmpty) return;
  try {
    var uri = Uri.parse(url);
    // Resolve relative paths (e.g. "cv/Mostafa-Badr-CV.pdf") against the
    // current page origin so they work on the web build. Without this,
    // url_launcher rejects them because they have no scheme.
    if (!uri.hasScheme) {
      uri = Uri.base.resolve(url);
    }
    // Skip the canLaunchUrl check — on the web it returns false for many
    // same-origin URLs even though launchUrl itself would succeed.
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );
  } catch (_) {
    // Swallow errors so the UI stays responsive.
  }
}
