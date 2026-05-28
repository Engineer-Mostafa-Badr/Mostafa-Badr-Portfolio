import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/models/course_item.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class CoursesSection extends StatelessWidget {
  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final crossAxisCount = device == DeviceType.desktop
        ? 4
        : device == DeviceType.tablet
            ? 3
            : 1;
    final aspectRatio = device == DeviceType.desktop
        ? 1.15
        : device == DeviceType.tablet
            ? 1.05
            : 1.7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'courses.eyebrow'),
          title: Tr.k(context, 'courses.title'),
          subtitle: Tr.k(context, 'courses.subtitle'),
          icon: Icons.menu_book_outlined,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _courses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            return CourseShowcase(course: _courses[index], index: index)
                .animate()
                .fadeIn(
                  duration: 500.ms,
                  delay: Duration(milliseconds: 60 * index),
                )
                .slideY(
                  begin: 0.10,
                  end: 0,
                  curve: Curves.easeOutCubic,
                );
          },
        ),
      ],
    );
  }
}

const List<CourseItem> _courses = [
  CourseItem(
    title: L18n(
      'Flutter & Dart With Clean Architecture [Arabic][2024]',
      'Flutter و Dart مع Clean Architecture [عربي][2024]',
    ),
    description: L18n(
      'Comprehensive course on Flutter & Dart focusing on Clean Architecture principles.',
      'كورس شامل عن Flutter و Dart مع التركيز على مبادئ Clean Architecture.',
    ),
    image:
        'assets/images/certificates/UC-80363353-13c9-4b82-ab7f-1f67da6cae14.jpg',
    certificateUrl:
        'https://www.udemy.com/course/flutter-dart-with-clean-architecture-arabic2024/',
  ),
  CourseItem(
    title: L18n(
      'The Complete Flutter Development Guide',
      'الدليل الكامل لتطوير Flutter',
    ),
    description: L18n(
      'Step-by-step course covering Flutter basics to advanced topics with real-world projects.',
      'كورس خطوة بخطوة يغطي أساسيات Flutter وصولاً للمواضيع المتقدمة مع مشاريع واقعية.',
    ),
    image:
        'assets/images/certificates/UC-bf5a00eb-7377-4ced-9f19-e9e8b84b7373.jpg',
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
    image:
        'assets/images/certificates/UC-b40e0452-2e45-4ea5-8c02-8ee6eb0d4be5.jpg',
    certificateUrl:
        'https://www.udemy.com/course/solid-design-principles-in-arabic/',
  ),
  CourseItem(
    title: L18n(
      'E-commerce App & Admin Website Using Flutter & Supabase',
      'تطبيق تجارة إلكترونية + موقع إدارة باستخدام Flutter و Supabase',
    ),
    description: L18n(
      'Build a complete e-commerce app and admin website using Flutter and Supabase.',
      'بناء تطبيق تجارة إلكترونية كامل و موقع إدارة باستخدام Flutter و Supabase.',
    ),
    image:
        'assets/images/certificates/UC-ab120903-41b3-4f64-81c1-913711fbce18.jpg',
    certificateUrl:
        'https://www.udemy.com/course/e-commerce-app-admin-website-using-flutter-supabase/',
  ),
  CourseItem(
    title: L18n(
      'Flutter Advanced Applications [More than 20 apps]',
      'تطبيقات Flutter متقدمة [أكثر من 20 تطبيق]',
    ),
    description: L18n(
      'Build more than 20 advanced Flutter applications covering various domains.',
      'بناء أكثر من 20 تطبيق Flutter متقدم في مجالات متنوعة.',
    ),
    image:
        'assets/images/certificates/UC-310e8a5d-2690-4f74-9cdc-90313d329737.jpg',
    certificateUrl:
        'https://www.udemy.com/course/flutter-advanced-applications-more-than-20-apps/',
  ),
];

class CourseShowcase extends StatefulWidget {
  final CourseItem course;
  final bool isCertificate;
  final int index;

  const CourseShowcase({
    required this.course,
    this.isCertificate = false,
    this.index = 0,
    super.key,
  });

  @override
  State<CourseShowcase> createState() => _CourseShowcaseState();
}

class _CourseShowcaseState extends State<CourseShowcase> {
  bool _hovering = false;

  void _open() => openUrl(widget.course.certificateUrl);

  String? _platformLabel(String url) {
    if (url.contains('udemy.com')) return 'Udemy';
    if (url.contains('routeacademy')) return 'Route Academy';
    return null;
  }

  Color get _accent => widget.isCertificate
      ? const Color(0xFFFFD700)
      : const Color(0xFF40C4FF);

  @override
  Widget build(BuildContext context) {
    final lift = _hovering ? -6.0 : 0.0;
    final platform = _platformLabel(widget.course.certificateUrl);
    final eyebrowLabel = widget.isCertificate
        ? Tr.k(context, 'courses.badge.cert')
        : Tr.k(context, 'courses.badge.course');
    final eyebrowIcon = widget.isCertificate
        ? Icons.verified_outlined
        : Icons.menu_book_outlined;
    final ctaLabel = widget.isCertificate
        ? Tr.k(context, 'certs.viewCertificate')
        : Tr.k(context, 'courses.viewCourse');

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: _open,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, lift, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                // ignore: deprecated_member_use
                Colors.white.withOpacity(0.06),
                // ignore: deprecated_member_use
                Colors.white.withOpacity(0.02),
              ],
            ),
            border: Border.all(
              color: _hovering
                  // ignore: deprecated_member_use
                  ? _accent.withOpacity(0.4)
                  // ignore: deprecated_member_use
                  : Colors.white.withOpacity(0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.4),
                blurRadius: _hovering ? 22 : 12,
                offset: const Offset(0, 6),
              ),
              if (_hovering)
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: _accent.withOpacity(0.20),
                  blurRadius: 28,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover image
                  Expanded(
                    flex: 6,
                    child: _CoverImage(
                      image: widget.course.image,
                      platform: platform,
                      isCertificate: widget.isCertificate,
                      accent: _accent,
                      hovering: _hovering,
                    ),
                  ),
                  // Body
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(eyebrowIcon, size: 10, color: _accent),
                              const SizedBox(width: 4),
                              Text(
                                eyebrowLabel,
                                style: TextStyle(
                                  color: _accent,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.1,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.course.title.t(context),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Expanded(
                            child: Text(
                              widget.course.description.t(context),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 10.5,
                                height: 1.25,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          _CtaRow(
                            label: ctaLabel,
                            accent: _accent,
                            hovering: _hovering,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

  const _CoverImage({
    required this.image,
    required this.platform,
    required this.isCertificate,
    required this.accent,
    required this.hovering,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background gradient as fallback
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1B2A4E), Color(0xFF2C1B4E)],
            ),
          ),
        ),
        AnimatedScale(
          duration: const Duration(milliseconds: 380),
          scale: hovering ? 1.05 : 1.0,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => Container(
              color: Colors.black26,
              child: const Center(
                child: Icon(Icons.broken_image, size: 48),
              ),
            ),
          ),
        ),
        // Bottom gradient for legibility
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                // ignore: deprecated_member_use
                Colors.black.withOpacity(0.50),
              ],
            ),
          ),
        ),
        // Type badge — top left (COURSE / CERT)
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              // ignore: deprecated_member_use
              color: accent.withOpacity(0.95),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: accent.withOpacity(0.4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isCertificate
                      ? Icons.verified_rounded
                      : Icons.school_rounded,
                  size: 10,
                  color: Colors.black,
                ),
                const SizedBox(width: 4),
                Text(
                  isCertificate
                      ? Tr.k(context, 'courses.badge.cert')
                      : Tr.k(context, 'courses.badge.course'),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 8.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Platform badge — top right
        if (platform != null)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.65),
                border: Border.all(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Text(
                platform!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
      ],
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: EdgeInsets.symmetric(
            horizontal: hovering ? 11 : 8,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            // ignore: deprecated_member_use
            color: accent.withOpacity(hovering ? 0.20 : 0.12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: accent,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(width: 5),
              AnimatedSlide(
                duration: const Duration(milliseconds: 220),
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
      ],
    );
  }
}
