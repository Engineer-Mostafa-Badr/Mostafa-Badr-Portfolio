import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class _Tool {
  final IconData icon;
  final Color color;
  final L18n label;
  final L18n role;

  const _Tool({
    required this.icon,
    required this.color,
    required this.label,
    required this.role,
  });
}

const _tools = <_Tool>[
  _Tool(
    icon: FontAwesomeIcons.code,
    color: Color(0xFF007ACC),
    label: L18n('VS Code', 'VS Code'),
    role: L18n('Editor', 'محرر الكود'),
  ),
  _Tool(
    icon: FontAwesomeIcons.android,
    color: Color(0xFF3DDC84),
    label: L18n('Android Studio', 'Android Studio'),
    role: L18n('IDE · Emulator', 'IDE · محاكي'),
  ),
  _Tool(
    icon: FontAwesomeIcons.figma,
    color: Color(0xFFF24E1E),
    label: L18n('Figma', 'فيجما'),
    role: L18n('UI Handoff', 'استلام UI'),
  ),
  _Tool(
    icon: FontAwesomeIcons.gitAlt,
    color: Color(0xFFF05032),
    label: L18n('Git + GitHub', 'Git + GitHub'),
    role: L18n('Version Control', 'إدارة الإصدارات'),
  ),
  _Tool(
    icon: FontAwesomeIcons.paperPlane,
    color: Color(0xFFFF6C37),
    label: L18n('Postman', 'بوستمان'),
    role: L18n('API Testing', 'اختبار الـ APIs'),
  ),
  _Tool(
    icon: FontAwesomeIcons.terminal,
    color: Color(0xFF22D3EE),
    label: L18n('PowerShell', 'PowerShell'),
    role: L18n('Build Scripts', 'سكربتات البناء'),
  ),
  _Tool(
    icon: FontAwesomeIcons.bug,
    color: Color(0xFF8C5898),
    label: L18n('Sentry', 'Sentry'),
    role: L18n('Crash Reporting', 'متابعة الأخطاء'),
  ),
  _Tool(
    icon: FontAwesomeIcons.googlePlay,
    color: Color(0xFF34A853),
    label: L18n('Play Console', 'Play Console'),
    role: L18n('Android Release', 'نشر Android'),
  ),
  _Tool(
    icon: FontAwesomeIcons.apple,
    color: Color(0xFFFFFFFF),
    label: L18n('Xcode + Transporter', 'Xcode + Transporter'),
    role: L18n('iOS Release', 'نشر iOS'),
  ),
  _Tool(
    icon: FontAwesomeIcons.notion,
    color: Color(0xFFFFFFFF),
    label: L18n('Notion', 'Notion'),
    role: L18n('Specs & Notes', 'المتطلبات و الملاحظات'),
  ),
  _Tool(
    icon: FontAwesomeIcons.slack,
    color: Color(0xFF4A154B),
    label: L18n('Slack', 'سلاك'),
    role: L18n('Team Comms', 'تواصل الفريق'),
  ),
  _Tool(
    icon: FontAwesomeIcons.fileLines,
    color: Color(0xFF85EA2D),
    label: L18n('Swagger', 'Swagger'),
    role: L18n('API Contracts', 'عقود APIs'),
  ),
];

class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final ar = isArabic(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: ar ? 'أدوات العمل اليومية' : 'Daily drivers',
          title: ar ? 'الأدوات اللي بستخدمها' : 'Tools I use',
          subtitle: ar
              ? 'الـ stack اللي بشتغل بيه يومياً — من الـ editor للـ release.'
              : 'The stack I reach for every day — from editor to release.',
          icon: Icons.handyman_outlined,
        ),
        GlassCard(
          padding: EdgeInsets.all(isMobile ? 18 : 22),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _tools.asMap().entries.map((entry) {
              final t = entry.value;
              return Container(
                width: isMobile ? double.infinity : 220,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withValues(alpha: 0.03),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: t.color.withValues(alpha: 0.12),
                        border: Border.all(
                          color: t.color.withValues(alpha: 0.30),
                        ),
                      ),
                      child: FaIcon(t.icon, size: 14, color: t.color),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.label.t(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            t.role.t(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: 350.ms,
                    delay: Duration(milliseconds: 40 * entry.key),
                  )
                  .slideY(begin: 0.15, end: 0, curve: Curves.easeOut);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
