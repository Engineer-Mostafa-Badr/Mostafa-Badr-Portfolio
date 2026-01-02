import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  if (url.isEmpty) return;
  try {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    // ignore: avoid_print
    // ignoring errors ensures the UI stays responsive
  }
}
