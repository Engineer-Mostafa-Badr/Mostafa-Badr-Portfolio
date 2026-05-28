import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final entries = _experienceEntries;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'experience.eyebrow'),
          title: Tr.k(context, 'experience.title'),
          subtitle: Tr.k(context, 'experience.subtitle'),
          icon: Icons.work_outline,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 4),
          child: Column(
            children: List.generate(entries.length, (i) {
              return _TimelineEntry(
                entry: entries[i],
                isFirst: i == 0,
                isLast: i == entries.length - 1,
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _ExperienceEntry {
  final L18n position;
  final L18n company;
  final L18n location;
  final L18n date;
  final L18n? duration;
  final L18n description;
  final List<String> technologies;
  final List<L18n> highlights;
  final Color accent;
  final bool isCurrent;

  const _ExperienceEntry({
    required this.position,
    required this.company,
    required this.location,
    required this.date,
    required this.description,
    this.duration,
    this.highlights = const [],
    this.technologies = const [],
    this.accent = const Color(0xFF40C4FF),
    this.isCurrent = false,
  });
}

const _experienceEntries = <_ExperienceEntry>[
  _ExperienceEntry(
    position: L18n('Mid-Level Flutter Developer', 'مطور Flutter متوسط الخبرة'),
    company: L18n(
      'Digital Harbor — Golden Odoo Partner',
      'Digital Harbor — Golden Odoo Partner',
    ),
    location: L18n('Riyadh, Saudi Arabia', 'الرياض، السعودية'),
    date: L18n(
      'Apr 2026 – Present · Remote',
      'أبريل 2026 – حتى الآن · عن بُعد',
    ),
    duration: L18n('2 mos', 'شهرين'),
    accent: Color(0xFF22D3EE),
    isCurrent: true,
    description: L18n(
      'Flutter developer in the Odoo Apps team — building production-grade mobile companions to Odoo 18/19 ERP for enterprise clients. Owning mobile-side delivery across high-profile bilingual apps with Clean Architecture, Bloc/Cubit, and tight backend integration over REST + JSON-RPC.',
      'مطور Flutter في فريق Odoo Apps — بنبني تطبيقات موبايل بمستوى إنتاجي مكمّلة لأنظمة Odoo 18/19 ERP لعملاء enterprise. مسؤول عن تسليم جانب الموبايل في تطبيقات ثنائية اللغة عالية الأهمية مع Clean Architecture و Bloc/Cubit و تكامل قوي مع الباك إند عبر REST + JSON-RPC.',
    ),
    highlights: [
      L18n(
        'Shipped Al Rajhi Hajj to Apple App Store + Google Play — bilingual Hajj services platform with pilgrim + supervisor roles, integrated with Odoo ERP via REST APIs.',
        'سلّمت تطبيق الراجحي للحج على Apple App Store + Google Play — منصة حج ثنائية اللغة بدورين للحجاج و المشرفين، متكاملة مع Odoo ERP عبر REST APIs.',
      ),
      L18n(
        'Built Saqqar mobile — AI agent that operates Odoo via natural language; voice transcription (Whisper), share-intent from WhatsApp/Photos/Files, encrypted credential vault, and inline approval cards.',
        'بنيت Saqqar Mobile — وكيل AI بيشغّل Odoo بلغة طبيعية؛ إملاء صوتي (Whisper) و share-intent من واتساب/الصور/الملفات و vault مشفّر للبيانات الحساسة و بطاقات موافقة inline.',
      ),
      L18n(
        'Delivered Customer Visits — field-sales GPS tracker with battery-aware live foreground location, offline queue with auto-sync, and a manager dashboard backed by Odoo 19.',
        'سلّمت Customer Visits — تتبّع GPS للمبيعات الميدانية مع موقع لايف يحترم البطارية و offline queue بمزامنة تلقائية و dashboard للمدير مدعومة بـ Odoo 19.',
      ),
      L18n(
        'Architected HR multi-tenant Companion — one binary on the store, each company points it at their own Odoo 18 server on first launch; Clean Architecture, SafeCubit base class, hybrid Bearer + session-cookie auth.',
        'صمّمت تطبيق HR متعدد المؤسسات — نسخة واحدة على المتجر، كل شركة بتوجّهه على سيرفر Odoo 18 بتاعها في أول تشغيل؛ Clean Architecture و SafeCubit base class و مصادقة هجينة Bearer + session-cookie.',
      ),
      L18n(
        'Standardized observability across the team — Sentry crash reporting with environmental noise filtering, dart-defined DSN, R8/ProGuard obfuscation, and auto-uploaded debug symbols.',
        'وحّدت الـ observability عبر الفريق — Sentry لمتابعة الأخطاء مع فلترة الـ noise البيئي، DSN عبر dart-define، obfuscation بـ R8/ProGuard، و رفع تلقائي لـ debug symbols.',
      ),
      L18n(
        'Strict bilingual delivery — Arabic-first RTL with Cairo typography, full direction flip, and zero leaked strings between locales across every shipped app.',
        'تسليم ثنائي اللغة بصرامة كاملة — عربي RTL أساسي بخط Cairo، flip كامل للاتجاه، و صفر تسرّب لنصوص بين اللغتين عبر كل تطبيق مشحون.',
      ),
    ],
    technologies: [
      'Flutter 3.35',
      'Bloc / Cubit',
      'Clean Architecture',
      'Odoo 18/19',
      'Dio + REST + JSON-RPC',
      'go_router',
      'get_it',
      'Sentry',
    ],
  ),
  _ExperienceEntry(
    position: L18n('Mobile App Developer', 'مطور تطبيقات موبايل'),
    company: L18n(
      'New Touch for Business Solutions',
      'نيو تاتش لحلول الأعمال',
    ),
    location: L18n('Riyadh, Saudi Arabia', 'الرياض، السعودية'),
    date: L18n(
      'Jun 2025 – Jan 2026 · Remote',
      'يونيو 2025 – يناير 2026 · عن بُعد',
    ),
    duration: L18n('8 mos', '8 شهور'),
    accent: Color(0xFFFFD700),
    description: L18n(
      'Contributed to a real estate mobile app (buying, selling, and renting properties) built with Flutter — focusing on multi-role onboarding, financing flows, and real-time updates.',
      'ساهمت في تطبيق عقاري (بيع و شراء و تأجير عقارات) مبني بـ Flutter — مع التركيز على onboarding متعدد الأدوار و رحلات التمويل و التحديثات الحية.',
    ),
    highlights: [
      L18n(
        'Shipped OTP & multi-role onboarding for clients, owners, and agents.',
        'سلّمت OTP و onboarding متعدد الأدوار للعملاء و الملاك و الوكلاء.',
      ),
      L18n(
        'Built financing flow with bank selection and role-based dashboards.',
        'بنيت رحلة تمويل مع اختيار البنك و dashboards حسب الدور.',
      ),
      L18n(
        'Wired push notifications and property filtering with minimal performance overhead.',
        'ربطت الإشعارات الفورية و فلترة العقارات بأقل تكلفة على الأداء.',
      ),
    ],
    technologies: ['Flutter', 'Laravel', 'Firebase'],
  ),
  _ExperienceEntry(
    position: L18n('Mobile App Developer', 'مطور تطبيقات موبايل'),
    company: L18n('Green Line Company', 'شركة جرين لاين'),
    location: L18n('Cairo, Egypt', 'القاهرة، مصر'),
    date: L18n(
      'Mar 2024 – May 2025 · Remote',
      'مارس 2024 – مايو 2025 · عن بُعد',
    ),
    duration: L18n('1 yr 2 mos', 'سنة و شهرين'),
    accent: Color(0xFF40C4FF),
    description: L18n(
      'Worked across production apps in a fast-paced team: real estate, car maintenance, and e-commerce. Focused on scalable architecture, clean UI, and reliable backend integration.',
      'اشتغلت على تطبيقات إنتاجية متعددة في فريق سريع الإيقاع: عقارات و صيانة سيارات و تجارة إلكترونية. ركّزت على معمارية قابلة للتوسع و UI نظيف و تكامل باك إند موثوق.',
    ),
    highlights: [
      L18n(
        'Delivered three customer-facing apps within tight release cycles.',
        'سلّمت ثلاثة تطبيقات للعملاء ضمن دورات إصدار ضيقة.',
      ),
      L18n(
        'Crafted reusable onboarding + OTP stacks so new flows could ship in days.',
        'بنيت مكونات onboarding و OTP قابلة لإعادة الاستخدام عشان الـ flows الجديدة تشحن في أيام.',
      ),
      L18n(
        'Improved UI/UX consistency and backend stability across Laravel + Supabase.',
        'حسّنت اتساق الـ UI/UX و استقرار الباك إند عبر Laravel + Supabase.',
      ),
    ],
    technologies: ['Flutter', 'Laravel', 'Node.js'],
  ),
];

class _TimelineEntry extends StatelessWidget {
  final _ExperienceEntry entry;
  final bool isFirst;
  final bool isLast;

  const _TimelineEntry({
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final railWidth = isMobile ? 32.0 : 56.0;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline rail (vertical line + node)
          SizedBox(
            width: railWidth,
            child: _TimelineRail(
              accent: entry.accent,
              isFirst: isFirst,
              isLast: isLast,
              isCurrent: entry.isCurrent,
            ),
          ),
          // Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : (isMobile ? 18 : 24),
              ),
              child: ExperienceCard(
                position: entry.position,
                company: entry.company,
                location: entry.location,
                date: entry.date,
                duration: entry.duration,
                description: entry.description,
                highlights: entry.highlights,
                technologies: entry.technologies,
                accent: entry.accent,
                isCurrent: entry.isCurrent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineRail extends StatelessWidget {
  final Color accent;
  final bool isFirst;
  final bool isLast;
  final bool isCurrent;

  const _TimelineRail({
    required this.accent,
    required this.isFirst,
    required this.isLast,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RailPainter(
        accent: accent,
        isFirst: isFirst,
        isLast: isLast,
      ),
      child: Center(
        child: _TimelineNode(accent: accent, pulse: isCurrent),
      ),
    );
  }
}

class _RailPainter extends CustomPainter {
  final Color accent;
  final bool isFirst;
  final bool isLast;

  _RailPainter({
    required this.accent,
    required this.isFirst,
    required this.isLast,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final paint = Paint()
      ..color = accent.withValues(alpha: 0.25)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Vertical line: skip space at the node (center y).
    final nodeRadius = 10.0;
    final centerY = size.height / 2;

    if (!isFirst) {
      canvas.drawLine(
        Offset(centerX, 0),
        Offset(centerX, centerY - nodeRadius - 2),
        paint,
      );
    }
    if (!isLast) {
      canvas.drawLine(
        Offset(centerX, centerY + nodeRadius + 2),
        Offset(centerX, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RailPainter old) =>
      old.accent != accent ||
      old.isFirst != isFirst ||
      old.isLast != isLast;
}

class _TimelineNode extends StatelessWidget {
  final Color accent;
  final bool pulse;

  const _TimelineNode({required this.accent, this.pulse = false});

  @override
  Widget build(BuildContext context) {
    final node = Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accent,
        border: Border.all(color: Colors.white.withValues(alpha: 0.18), width: 2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.55),
            blurRadius: 14,
            spreadRadius: 1,
          ),
        ],
      ),
    );

    if (!pulse) return node;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accent.withValues(alpha: 0.25),
          ),
        )
            .animate(onPlay: (c) => c.repeat())
            .scaleXY(
              begin: 0.7,
              end: 1.3,
              duration: 1500.ms,
              curve: Curves.easeInOut,
            )
            .fade(begin: 0.6, end: 0.0, duration: 1500.ms),
        node,
      ],
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final L18n position;
  final L18n company;
  final L18n location;
  final L18n date;
  final L18n? duration;
  final L18n description;
  final List<String> technologies;
  final List<L18n> highlights;
  final Color accent;
  final bool isCurrent;

  const ExperienceCard({
    required this.position,
    required this.company,
    required this.location,
    required this.date,
    required this.description,
    this.duration,
    this.highlights = const [],
    this.technologies = const [],
    this.accent = const Color(0xFF40C4FF),
    this.isCurrent = false,
    super.key,
  });

  String _initialsFromCompany(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.characters.take(2).toString().toUpperCase();
    }
    final first = parts[0].characters.firstOrNull ?? '';
    final second = parts[1].characters.firstOrNull ?? '';
    return '$first$second'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final companyName = company.t(context);
    final initials = _initialsFromCompany(companyName);

    return GlassCard(
      padding: EdgeInsets.zero,
      hoverable: true,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left accent stripe
            Container(
              width: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    accent,
                    accent.withValues(alpha: 0.35),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: avatar + position + company
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _CompanyAvatar(
                          initials: initials,
                          accent: accent,
                          size: isMobile ? 44 : 52,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      position.t(context),
                                      style: TextStyle(
                                        fontSize: isMobile ? 16 : 19,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        height: 1.2,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ),
                                  if (isCurrent) ...[
                                    const SizedBox(width: 8),
                                    _CurrentBadge(),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 5),
                              ShaderMask(
                                shaderCallback: (rect) => LinearGradient(
                                  colors: [
                                    accent,
                                    accent.withValues(alpha: 0.7),
                                  ],
                                ).createShader(rect),
                                child: Text(
                                  companyName,
                                  style: TextStyle(
                                    fontSize: isMobile ? 13 : 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Meta pills: date + duration + location
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _MetaPill(
                          icon: Icons.event_outlined,
                          label: date.t(context),
                          accent: accent,
                          emphasized: true,
                        ),
                        if (duration != null)
                          _MetaPill(
                            icon: Icons.hourglass_bottom_outlined,
                            label: duration!.t(context),
                            accent: accent,
                          ),
                        _MetaPill(
                          icon: Icons.location_on_outlined,
                          label: location.t(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Description
                    Text(
                      description.t(context),
                      style: TextStyle(
                        color: Colors.grey[300],
                        height: 1.6,
                        fontSize: isMobile ? 13 : 14.5,
                      ),
                    ),
                    if (highlights.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: accent.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Column(
                          children: highlights.asMap().entries.map((entry) {
                            final isLast =
                                entry.key == highlights.length - 1;
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: isLast ? 0 : 9,
                              ),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: accent,
                                      boxShadow: [
                                        BoxShadow(
                                          color: accent.withValues(
                                            alpha: 0.5,
                                          ),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  Expanded(
                                    child: Text(
                                      entry.value.t(context),
                                      style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: isMobile ? 12.5 : 13.5,
                                        height: 1.55,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  duration: 400.ms,
                                  delay: Duration(
                                    milliseconds: 100 * entry.key,
                                  ),
                                )
                                .slideX(begin: -0.05, end: 0);
                          }).toList(),
                        ),
                      ),
                    ],
                    if (technologies.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: accent.withValues(alpha: 0.30),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                color: accent,
                                fontSize: isMobile ? 11 : 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyAvatar extends StatelessWidget {
  final String initials;
  final Color accent;
  final double size;

  const _CompanyAvatar({
    required this.initials,
    required this.accent,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.85),
            accent.withValues(alpha: 0.55),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.30),
            blurRadius: 14,
            spreadRadius: 0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: size * 0.38,
          letterSpacing: -0.5,
          height: 1,
        ),
      ),
    );
  }
}

class _CurrentBadge extends StatelessWidget {
  // ignore: unused_element_parameter
  const _CurrentBadge({super.key});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF34D399);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: accent, blurRadius: 6),
              ],
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fade(begin: 0.4, end: 1, duration: 900.ms),
          const SizedBox(width: 5),
          Text(
            isArabic(context) ? 'حالياً' : 'CURRENT',
            style: const TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              fontSize: 9.5,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accent;
  final bool emphasized;

  const _MetaPill({
    required this.icon,
    required this.label,
    this.accent = const Color(0xFF40C4FF),
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = emphasized
        ? accent.withValues(alpha: 0.12)
        : Colors.white.withValues(alpha: 0.04);
    final border = emphasized
        ? accent.withValues(alpha: 0.30)
        : Colors.white.withValues(alpha: 0.08);
    final color = emphasized ? accent : Colors.grey.shade300;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 11.5,
                fontWeight: emphasized ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
