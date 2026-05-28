import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/skill_icons.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class _SkillGroup {
  final String labelKey;
  final IconData icon;
  final Color color;
  final List<L18n> skills;
  const _SkillGroup({
    required this.labelKey,
    required this.icon,
    required this.color,
    required this.skills,
  });
}

const List<_SkillGroup> _skillGroups = [
  _SkillGroup(
    labelKey: 'skills.group.core',
    icon: Icons.flutter_dash,
    color: Color(0xFF40C4FF),
    skills: [
      L18n('Flutter', 'Flutter'),
      L18n('Dart', 'Dart'),
      L18n('OOP', 'البرمجة الكائنية'),
      L18n('SOLID Principles', 'مبادئ SOLID'),
      L18n('Clean Architecture', 'المعمارية النظيفة'),
      L18n('Design Patterns', 'أنماط التصميم'),
      L18n('Clean Code', 'كود نظيف'),
      L18n('MVVM', 'MVVM'),
      L18n('Responsive Design', 'تصميم متجاوب'),
      L18n('Cross-Platform Development', 'تطوير متعدد المنصات'),
    ],
  ),
  _SkillGroup(
    labelKey: 'skills.group.architecture',
    icon: Icons.account_tree_outlined,
    color: Color(0xFF22D3EE),
    skills: [
      L18n('Feature-First Architecture', 'معمارية Feature-First'),
      L18n('Repository Pattern', 'نمط Repository'),
      L18n('go_router (Routing)', 'go_router (التنقّل)'),
      L18n('get_it (Service Locator)', 'get_it (DI)'),
      L18n('Dependency Injection', 'حقن الاعتماديات (DI)'),
    ],
  ),
  _SkillGroup(
    labelKey: 'skills.group.state',
    icon: Icons.hub_outlined,
    color: Color(0xFFFFD700),
    skills: [
      L18n('Bloc', 'Bloc'),
      L18n('Cubit', 'Cubit'),
      L18n('Provider', 'Provider'),
      L18n('GetX', 'GetX'),
    ],
  ),
  _SkillGroup(
    labelKey: 'skills.group.backend',
    icon: Icons.cloud_outlined,
    color: Color(0xFF9C7BFF),
    skills: [
      L18n('Firebase', 'Firebase'),
      L18n('Supabase', 'Supabase'),
      L18n('Odoo 18/19 (ERP Integration)', 'Odoo 18/19 (تكامل ERP)'),
      L18n('Laravel (Integration)', 'Laravel (تكامل)'),
      L18n('Node.js (Integration)', 'Node.js (تكامل)'),
      L18n('Dio (HTTP Client)', 'Dio (HTTP Client)'),
      L18n('RESTful APIs', 'RESTful APIs'),
      L18n('JSON-RPC', 'JSON-RPC'),
      L18n('Bearer + Cookie Auth', 'مصادقة Bearer + Cookie'),
      L18n('Swagger', 'Swagger'),
      L18n('Postman', 'Postman'),
    ],
  ),
  _SkillGroup(
    labelKey: 'skills.group.mobile',
    icon: Icons.smartphone_outlined,
    color: Color(0xFF69F0AE),
    skills: [
      L18n('Push Notifications', 'الإشعارات الفورية'),
      L18n('Payment Gateway Integration', 'تكامل بوابات الدفع'),
      L18n('Google Maps Integration', 'تكامل خرائط جوجل'),
      L18n('OpenStreetMap (flutter_map)', 'OpenStreetMap (flutter_map)'),
      L18n('Geolocation & GPS', 'Geolocation و GPS'),
      L18n('OTP Authentication', 'مصادقة OTP'),
      L18n('Voice Recording & Whisper', 'تسجيل صوتي و Whisper'),
      L18n('Share Intent (In/Out)', 'Share Intent (دخول/خروج)'),
      L18n('File Picker & Documents', 'File Picker و المستندات'),
      L18n('QR & NFC Scanning', 'مسح QR و NFC'),
      L18n('Hijri & Gregorian Calendars', 'تقويم هجري و ميلادي'),
      L18n('Offline Queue & Sync', 'طابور Offline و مزامنة'),
      L18n('Multi-tenant Configuration', 'إعداد متعدد المؤسسات'),
      L18n('Localization & RTL', 'التعريب و RTL'),
      L18n('Secure Storage (Keychain/Keystore)', 'تخزين آمن (Keychain/Keystore)'),
      L18n('Shared Preferences', 'Shared Preferences'),
      L18n('Performance Optimization', 'تحسين الأداء'),
    ],
  ),
  _SkillGroup(
    labelKey: 'skills.group.tooling',
    icon: Icons.build_outlined,
    color: Color(0xFFFF8A65),
    skills: [
      L18n('Git', 'Git'),
      L18n('GitHub', 'GitHub'),
      L18n('CI/CD', 'CI/CD'),
      L18n('Sentry (Crash Reporting)', 'Sentry (متابعة الأخطاء)'),
      L18n('App Icons / Splash', 'أيقونات و Splash'),
      L18n('Code Obfuscation (R8/ProGuard)', 'تشفير الكود (R8/ProGuard)'),
      L18n('Play Console / App Store Connect', 'Play Console / App Store Connect'),
      L18n('Figma (UI handoff)', 'Figma (تسليم UI)'),
    ],
  ),
];

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'skills.eyebrow'),
          title: Tr.k(context, 'skills.title'),
          subtitle: Tr.k(context, 'skills.subtitle'),
          icon: Icons.build_circle_outlined,
        ),
        Column(
          children: _skillGroups.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _SkillGroupCard(group: entry.value, index: entry.key),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SkillGroupCard extends StatefulWidget {
  final _SkillGroup group;
  final int index;

  const _SkillGroupCard({required this.group, required this.index});

  @override
  State<_SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<_SkillGroupCard> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    // First two groups expanded by default — keeps initial scroll lightweight
    // but still surfaces the most important skills.
    _expanded = widget.index < 2;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final group = widget.group;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: group.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(group.icon, color: group.color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      Tr.k(context, group.labelKey),
                      style: TextStyle(
                        color: group.color,
                        fontWeight: FontWeight.w700,
                        fontSize: isMobile ? 15 : 17,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: group.color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${group.skills.length}',
                      style: TextStyle(
                        color: group.color,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 240),
                    turns: _expanded ? 0.5 : 0,
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: group.color,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 260),
            sizeCurve: Curves.easeInOut,
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: group.skills.asMap().entries.map((entry) {
                  return _SkillChip(
                    label: entry.value.t(context),
                    skillKey: entry.value.en,
                    groupColor: group.color,
                    isMobile: isMobile,
                  )
                      .animate()
                      .fadeIn(
                        duration: 300.ms,
                        delay: Duration(milliseconds: 30 * entry.key),
                      )
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOut);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  final String skillKey;
  final Color groupColor;
  final bool isMobile;

  const _SkillChip({
    required this.label,
    required this.skillKey,
    required this.groupColor,
    required this.isMobile,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final skillIcon = iconForSkill(widget.skillKey, widget.groupColor);
    final glowColor = skillIcon.color;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: widget.isMobile ? 10 : 12,
          vertical: 7,
        ),
        transform: _hovering
            ? (Matrix4.identity()..translateByDouble(0.0, -2.0, 0.0, 1.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: _hovering
              ? glowColor.withValues(alpha: 0.16)
              : widget.groupColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovering
                ? glowColor.withValues(alpha: 0.60)
                : widget.groupColor.withValues(alpha: 0.25),
          ),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.40),
                    blurRadius: 14,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              skillIcon.icon,
              size: widget.isMobile ? 13 : 14,
              color: skillIcon.color,
            ),
            const SizedBox(width: 7),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.grey[100],
                fontWeight: FontWeight.w600,
                fontSize: widget.isMobile ? 12 : 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
