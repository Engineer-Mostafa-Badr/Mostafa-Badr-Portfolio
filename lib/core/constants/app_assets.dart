/// Single source of truth for every bundled asset path.
///
/// Nothing in `lib/` should contain a raw `'assets/...'` string — reference a
/// constant from here instead. A typo then becomes a compile error rather than
/// a blank box at runtime, and renaming a folder is a one-line change.
library;

class AppAssets {
  const AppAssets._();

  static const String _images = 'assets/images';

  // ── Brand / personal ───────────────────────────────────────────────────
  static const String heroBackdrop =
      '$_images/logo/7c1ae715-563b-4455-9465-c93bd935db61.webp';
  static const String portrait = '$_images/my_photo/portrait.webp';

  /// Résumé served from `web/cv/`. Relative on purpose: [openUrl] resolves it
  /// against the page origin so it works on any host without a hard-coded
  /// domain.
  static const String cvPdf = 'cv/Mostafa-Badr-CV.pdf';
}

/// Screenshots and cover art per project, grouped so a project's assets stay
/// together and `images:` lists in `projects_data.dart` read declaratively.
class ProjectAssets {
  const ProjectAssets._();

  static const String _images = 'assets/images';

  // ── Al Rajhi Hajj ──────────────────────────────────────────────────────
  static const String hajjCover = '$_images/haj/cover.webp';
  static const List<String> hajj = [
    '$_images/haj/1.webp',
    '$_images/haj/2.webp',
    '$_images/haj/3.webp',
    '$_images/haj/4.webp',
    '$_images/haj/5.webp',
    '$_images/haj/6.webp',
    '$_images/haj/7.webp',
    '$_images/haj/8.webp',
  ];

  // ── Alawaly ────────────────────────────────────────────────────────────
  static const String alawalyCover = '$_images/alawaly/cover.webp';
  static const List<String> alawaly = [
    '$_images/alawaly/sign up2.webp',
    '$_images/alawaly/المشاريع.webp',
    '$_images/alawaly/تفاصيل المشروع.webp',
    '$_images/alawaly/تفاصيل الوحدة.webp',
    '$_images/alawaly/نتائج البحث علي الخريطة2.webp',
  ];

  // ── 49 Super App ───────────────────────────────────────────────────────
  static const String fortyNineCover = '$_images/fortynine/cover.webp';
  static const List<String> fortyNine = [
    '$_images/fortynine/1.webp',
    '$_images/fortynine/2.webp',
    '$_images/fortynine/3.webp',
    '$_images/fortynine/4.webp',
    '$_images/fortynine/5.webp',
    '$_images/fortynine/6.webp',
    '$_images/fortynine/7.webp',
  ];

  // ── Saqqar ─────────────────────────────────────────────────────────────
  static const String saqqarCover = '$_images/saqqar/cover.webp';
  static const List<String> saqqar = [
    '$_images/saqqar/Screenshot_1783481354.webp',
    '$_images/saqqar/Screenshot_1784388612.webp',
    '$_images/saqqar/Screenshot_1784388260.webp',
    '$_images/saqqar/Screenshot_1784388623.webp',
  ];

  // ── Customer Visits ────────────────────────────────────────────────────
  static const String visitsCover = '$_images/visits/cover.webp';
  static const List<String> visits = [
    '$_images/visits/Screenshot_1786260328.webp',
    '$_images/visits/Screenshot_1786260334.webp',
    '$_images/visits/Screenshot_1786260340.webp',
    '$_images/visits/Screenshot_1786260349.webp',
    '$_images/visits/Screenshot_1786260427.webp',
  ];

  // ── HR Companion ───────────────────────────────────────────────────────
  static const String hrCover = '$_images/hr/cover.webp';
  static const List<String> hr = [
    '$_images/hr/Screenshot_1786433069.webp',
    '$_images/hr/Screenshot_1786433073.webp',
    '$_images/hr/Screenshot_1786433088.webp',
    '$_images/hr/Screenshot_1786433144.webp',
  ];

  // ── E-commerce demo ────────────────────────────────────────────────────
  static const String ecommerceCover = '$_images/ecommerce/cover.webp';
  static const List<String> ecommerce = [
    '$_images/ecommerce/IMG-20250411-WA0088.webp',
    '$_images/ecommerce/IMG-20250411-WA0090.webp',
    '$_images/ecommerce/IMG-20250411-WA0096.webp',
    '$_images/ecommerce/IMG-20250411-WA0099.webp',
    '$_images/ecommerce/IMG-20250411-WA0101.webp',
    '$_images/ecommerce/IMG-20250411-WA0104.webp',
  ];

  // ── Captain Drive ──────────────────────────────────────────────────────
  static const String captainDriveCover = '$_images/captain_drive/cover.webp';
  static const List<String> captainDrive = [
    '$_images/captain_drive/iPhone 14 & 15 Pro Max - 75.webp',
    '$_images/captain_drive/iPhone 14 & 15 Pro Max - 76.webp',
    '$_images/captain_drive/iPhone 14 & 15 Pro Max - 77.webp',
    '$_images/captain_drive/iPhone 14 & 15 Pro Max - 84.webp',
    '$_images/captain_drive/iPhone 14 & 15 Pro Max - 86.webp',
    '$_images/captain_drive/iPhone 14 & 15 Pro Max - 89.webp',
  ];
}

/// Udemy / Route Academy certificate thumbnails.
class CertificateAssets {
  const CertificateAssets._();

  static const String _dir = 'assets/images/certificates';

  static const String routeAcademyDiploma = '$_dir/1735110803287.webp';
  static const String cleanArchitecture =
      '$_dir/UC-80363353-13c9-4b82-ab7f-1f67da6cae14.webp';
  static const String completeFlutterGuide =
      '$_dir/UC-bf5a00eb-7377-4ced-9f19-e9e8b84b7373.webp';
  static const String solidPrinciples =
      '$_dir/UC-b40e0452-2e45-4ea5-8c02-8ee6eb0d4be5.webp';
  static const String ecommerceSupabase =
      '$_dir/UC-ab120903-41b3-4f64-81c1-913711fbce18.webp';
  static const String advancedApps =
      '$_dir/UC-310e8a5d-2690-4f74-9cdc-90313d329737.webp';
}
