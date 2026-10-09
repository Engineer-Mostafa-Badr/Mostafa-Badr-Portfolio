/// Every outbound URL and contact identity in one place.
///
/// Widgets never spell out a URL inline — if the phone number, email, or a
/// social handle changes it changes here once.
class AppLinks {
  const AppLinks._();

  // ── Identity ───────────────────────────────────────────────────────────
  static const String siteUrl = 'https://mostafabadr.com';
  static const String email = 'mostafamostafabadrbadr@gmail.com';
  static const String whatsappNumber = '201004652998';
  static const String githubUser = 'Engineer-Mostafa-Badr';

  // ── Social ─────────────────────────────────────────────────────────────
  static const String linkedIn =
      'https://www.linkedin.com/in/engineer-mostafa-badr/';
  static const String github = 'https://github.com/$githubUser';
  static const String repository = '$github/Mostafa-Badr-Portfolio';
  static const String facebook =
      'https://web.facebook.com/Engineer.Mostafa.Badr/';
  static const String instagram =
      'https://www.instagram.com/engineer_mostafa_badr/';
  static const String tiktok = 'https://www.tiktok.com/@engineer_mostafa_badr';
  static const String youtube =
      'https://www.youtube.com/@Engineer_Mostafa_Badr';
  static const String x = 'https://x.com/EngMostafa_Badr';

  // ── Attribution targets ────────────────────────────────────────────────
  static const String flutterHome = 'https://flutter.dev';
  static const String cloudflareHome = 'https://cloudflare.com';
  static const String pageSpeedReport =
      'https://pagespeed.web.dev/analysis?url=https%3A%2F%2Fmostafabadr.com%2F';

  // ── Contact form backend ───────────────────────────────────────────────
  /// Formspree endpoint that receives inline contact-form submissions.
  static const String contactFormEndpoint = 'https://formspree.io/f/xnjrrlqw';

  // ── Builders ───────────────────────────────────────────────────────────

  /// Plain WhatsApp chat with no pre-filled text.
  static String get whatsapp => 'https://wa.me/$whatsappNumber';

  /// WhatsApp deep link carrying a pre-written [message].
  static String whatsappWith(String message) =>
      'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(message)}';

  /// `mailto:` link with an optional pre-filled subject and body.
  static String mailto({String? subject, String? body}) {
    final params = <String, String>{
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
    };
    if (params.isEmpty) return 'mailto:$email';
    final query = params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return 'mailto:$email?$query';
  }
}

/// Which store or host a project link points at. Used to pick the right icon
/// and label for a project's action buttons without re-parsing URLs in the UI.
enum ProjectLinkKind { playStore, appStore, website, repository, apkDownload }

extension ProjectLinkKindX on ProjectLinkKind {
  /// Classifies a URL. Order matters: the store checks are the most specific.
  static ProjectLinkKind fromUrl(String url) {
    if (url.contains('play.google.com')) return ProjectLinkKind.playStore;
    if (url.contains('apps.apple.com')) return ProjectLinkKind.appStore;
    if (url.contains('github.com')) return ProjectLinkKind.repository;
    if (url.contains('drive.google.com')) return ProjectLinkKind.apkDownload;
    return ProjectLinkKind.website;
  }

  /// Translation key for this link's button label.
  String get labelKey {
    switch (this) {
      case ProjectLinkKind.playStore:
        return 'projects.playStore';
      case ProjectLinkKind.appStore:
        return 'projects.appStore';
      case ProjectLinkKind.website:
        return 'projects.website';
      case ProjectLinkKind.repository:
        return 'projects.viewRepo';
      case ProjectLinkKind.apkDownload:
        return 'projects.downloadApk';
    }
  }
}
