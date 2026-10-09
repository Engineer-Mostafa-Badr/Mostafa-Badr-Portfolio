import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_assets.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/models/course_item.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/widgets/common/safe_asset_image.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

const List<CourseItem> courses = [
  CourseItem(
    title: L18n(
      'Flutter & Dart With Clean Architecture [Arabic][2024]',
      'Flutter و Dart مع Clean Architecture [عربي][2024]',
    ),
    description: L18n(
      'Comprehensive course on Flutter & Dart focusing on Clean Architecture '
      'principles.',
      'كورس شامل عن Flutter و Dart مع التركيز على مبادئ Clean Architecture.',
    ),
    image: CertificateAssets.cleanArchitecture,
    certificateUrl:
        'https://www.udemy.com/course/flutter-dart-with-clean-architecture-arabic2024/',
  ),
  CourseItem(
    title: L18n(
      'The Complete Flutter Development Guide',
      'الدليل الكامل لتطوير Flutter',
    ),
    description: L18n(
      'Step-by-step course covering Flutter basics to advanced topics with '
      'real-world projects.',
      'كورس خطوة بخطوة يغطي أساسيات Flutter وصولاً للمواضيع المتقدمة مع '
      'مشاريع واقعية.',
    ),
    image: CertificateAssets.completeFlutterGuide,
    certificateUrl: 'https://www.udemy.com/course/fluttercourse/',
  ),
  CourseItem(
    title: L18n(
      'SOLID Design Principles - in Arabic (بالعربي)',
      'مبادئ SOLID للتصميم — بالعربي',
    ),
    description: L18n(
      'In-depth course on SOLID principles and design patterns in Flutter.',
      'كورس متعمق في مبادئ SOLID و أنماط التصميم في Flutter.',
    ),
    image: CertificateAssets.solidPrinciples,
    certificateUrl:
        'https://www.udemy.com/course/solid-design-principles-in-arabic/',
  ),
  CourseItem(
    title: L18n(
      'E-commerce App & Admin Website Using Flutter & Supabase',
      'تطبيق تجارة إلكترونية + موقع إدارة باستخدام Flutter و Supabase',
    ),
    description: L18n(
      'Build a complete e-commerce app and admin website using Flutter and '
      'Supabase.',
      'بناء تطبيق تجارة إلكترونية كامل و موقع إدارة باستخدام Flutter و '
      'Supabase.',
    ),
    image: CertificateAssets.ecommerceSupabase,
    certificateUrl:
        'https://www.udemy.com/course/e-commerce-app-admin-website-using-flutter-supabase/',
  ),
  CourseItem(
    title: L18n(
      'Flutter Advanced Applications [More than 20 apps]',
      'تطبيقات Flutter متقدمة [أكثر من 20 تطبيق]',
    ),
    description: L18n(
      'Build more than 20 advanced Flutter applications covering various '
      'domains.',
      'بناء أكثر من 20 تطبيق Flutter متقدم في مجالات متنوعة.',
    ),
    image: CertificateAssets.advancedApps,
    certificateUrl:
        'https://www.udemy.com/course/flutter-advanced-applications-more-than-20-apps/',
  ),
];

class CoursesSection extends StatelessWidget {
  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'courses.eyebrow'),
          title: Tr.k(context, 'courses.title'),
          subtitle: Tr.k(context, 'courses.subtitle'),
          icon: Icons.menu_book_outlined,
        ),
        ResponsiveBuilder(
          builder: (context, constraints, device) {
            final columns = switch (device) {
              DeviceType.desktop => 4,
              DeviceType.tablet => 3,
              DeviceType.mobile => 1,
            };
            const spacing = 14.0;
            final available = constraints.hasBoundedWidth
                ? constraints.maxWidth
                : context.screenWidth;
            final cellWidth =
                (available - spacing * (columns - 1)) / columns;

            // The body needs a near-constant height regardless of column
            // width (eyebrow, two title lines, two description lines, CTA).
            // Deriving the ratio from that instead of hard-coding one per
            // breakpoint keeps the card readable at every width — the old
            // 1.7 ratio on mobile squeezed the description to a sliver.
            const bodyHeight = 118.0;
            final coverHeight = cellWidth * 0.58;
            final ratio = cellWidth / (coverHeight + bodyHeight);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: ratio,
              ),
              itemBuilder: (context, index) {
                return CourseShowcase(
                  course: courses[index],
                  cellWidth: cellWidth,
                )
                    .animate()
                    .fadeIn(
                      duration: 500.ms,
                      delay: Duration(milliseconds: 60 * index),
                    )
                    .slideY(begin: 0.10, end: 0, curve: Curves.easeOutCubic);
              },
            );
          },
        ),
      ],
    );
  }
}

class CourseShowcase extends StatefulWidget {
  final CourseItem course;
  final bool isCertificate;

  /// Width the card will occupy, forwarded to the cover so the image decodes
  /// at display size rather than at its full 300 KB resolution.
  final double? cellWidth;

  const CourseShowcase({
    required this.course,
    this.isCertificate = false,
    this.cellWidth,
    super.key,
  });

  @override
  State<CourseShowcase> createState() => _CourseShowcaseState();
}

class _CourseShowcaseState extends State<CourseShowcase> {
  bool _hovering = false;

  Color get _accent =>
      widget.isCertificate ? AppColors.gold : AppColors.cyan;

  /// Human name of the platform hosting the certificate, derived from its URL.
  String? get _platformLabel {
    final url = widget.course.certificateUrl;
    if (url.contains('udemy.com')) return 'Udemy';
    // The Route Academy hard-copy certificate is hosted on Google Drive.
    if (url.contains('routeacademy') || url.contains('drive.google.com')) {
      return 'Route Academy';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final eyebrowLabel = Tr.k(
      context,
      widget.isCertificate ? 'courses.badge.cert' : 'courses.badge.course',
    );
    final ctaLabel = Tr.k(
      context,
      widget.isCertificate ? 'certs.viewCertificate' : 'courses.viewCourse',
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.course.certificateUrl, context: context),
        child: Semantics(
          button: true,
          label: widget.course.title.t(context),
          child: AnimatedContainer(
            duration: AppDurations.quick,
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.06),
                  Colors.white.withValues(alpha: 0.02),
                ],
              ),
              border: Border.all(
                color: _hovering
                    ? _accent.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.08),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: _hovering ? 22 : 12,
                  offset: const Offset(0, 6),
                ),
                if (_hovering)
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.20),
                    blurRadius: 28,
                    spreadRadius: 1,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _CoverImage(
                        image: widget.course.image,
                        platform: _platformLabel,
                        isCertificate: widget.isCertificate,
                        accent: _accent,
                        hovering: _hovering,
                        displayWidth: widget.cellWidth,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: _CourseBody(
                        course: widget.course,
                        eyebrowLabel: eyebrowLabel,
                        eyebrowIcon: widget.isCertificate
                            ? Icons.verified_outlined
                            : Icons.menu_book_outlined,
                        ctaLabel: ctaLabel,
                        accent: _accent,
                        hovering: _hovering,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CourseBody extends StatelessWidget {
  final CourseItem course;
  final String eyebrowLabel;
  final IconData eyebrowIcon;
  final String ctaLabel;
  final Color accent;
  final bool hovering;

  const _CourseBody({
    required this.course,
    required this.eyebrowLabel,
    required this.eyebrowIcon,
    required this.ctaLabel,
    required this.accent,
    required this.hovering,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSizes.md - 2, AppSizes.sm,
          AppSizes.md - 2, AppSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(eyebrowIcon, size: 10, color: accent),
              const SizedBox(width: AppSizes.xs),
              Flexible(
                child: Text(
                  eyebrowLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: accent,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xxs),
          Text(
            course.title.t(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppSizes.xxs),
          Expanded(
            child: Text(
              course.description.t(context),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 10.5,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.xxs),
          _CtaRow(label: ctaLabel, accent: accent, hovering: hovering),
        ],
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  final String image;
  final String? platform;
  final bool isCertificate;
  final Color accent;
  final bool hovering;
  final double? displayWidth;

  const _CoverImage({
    required this.image,
    required this.platform,
    required this.isCertificate,
    required this.accent,
    required this.hovering,
    required this.displayWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.cardSheen,
            ),
          ),
        ),
        AnimatedScale(
          duration: const Duration(milliseconds: 380),
          scale: hovering ? 1.05 : 1.0,
          child: SafeAssetImage(path: image, displayWidth: displayWidth),
        ),
        // Bottom scrim so the badges stay legible on light certificates.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.50),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: AppSizes.sm,
          start: AppSizes.sm,
          child: _TypeBadge(isCertificate: isCertificate, accent: accent),
        ),
        if (platform != null)
          PositionedDirectional(
            top: AppSizes.sm,
            end: AppSizes.sm,
            child: _PlatformBadge(label: platform!),
          ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final bool isCertificate;
  final Color accent;

  const _TypeBadge({required this.isCertificate, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: AppSizes.xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
        color: accent.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(color: accent.withValues(alpha: 0.4), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCertificate ? Icons.verified_rounded : Icons.school_rounded,
            size: 10,
            color: Colors.black,
          ),
          const SizedBox(width: AppSizes.xs),
          Text(
            Tr.k(
              context,
              isCertificate ? 'courses.badge.cert' : 'courses.badge.course',
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 8.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformBadge extends StatelessWidget {
  final String label;
  const _PlatformBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: AppSizes.xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
        color: Colors.black.withValues(alpha: 0.65),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _CtaRow extends StatelessWidget {
  final String label;
  final Color accent;
  final bool hovering;

  const _CtaRow({
    required this.label,
    required this.accent,
    required this.hovering,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: AnimatedContainer(
            duration: AppDurations.quick,
            padding: EdgeInsets.symmetric(
              horizontal: hovering ? 11 : AppSizes.sm,
              vertical: AppSizes.xs + 1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: accent.withValues(alpha: hovering ? 0.20 : 0.12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: accent,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.xs + 1),
                AnimatedSlide(
                  duration: AppDurations.quick,
                  offset: hovering ? const Offset(0.25, 0) : Offset.zero,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 12,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
