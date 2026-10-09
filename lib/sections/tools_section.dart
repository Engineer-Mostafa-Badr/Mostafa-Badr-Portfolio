import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
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
    color: AppColors.vsCode,
    label: L18n('VS Code', 'VS Code'),
    role: L18n('Editor', 'محرر الكود'),
  ),
  _Tool(
    icon: FontAwesomeIcons.android,
    color: AppColors.androidGreen,
    label: L18n('Android Studio', 'Android Studio'),
    role: L18n('IDE · Emulator', 'IDE · محاكي'),
  ),
  _Tool(
    icon: FontAwesomeIcons.figma,
    color: AppColors.figma,
    label: L18n('Figma', 'فيجما'),
    role: L18n('UI Handoff', 'استلام UI'),
  ),
  _Tool(
    icon: FontAwesomeIcons.gitAlt,
    color: AppColors.git,
    label: L18n('Git + GitHub', 'Git + GitHub'),
    role: L18n('Version Control', 'إدارة الإصدارات'),
  ),
  _Tool(
    icon: FontAwesomeIcons.paperPlane,
    color: AppColors.postman,
    label: L18n('Postman', 'بوستمان'),
    role: L18n('API Testing', 'اختبار الـ APIs'),
  ),
  _Tool(
    icon: FontAwesomeIcons.terminal,
    color: AppColors.teal,
    label: L18n('PowerShell', 'PowerShell'),
    role: L18n('Build Scripts', 'سكربتات البناء'),
  ),
  _Tool(
    icon: FontAwesomeIcons.bug,
    color: AppColors.sentry,
    label: L18n('Sentry', 'Sentry'),
    role: L18n('Crash Reporting', 'متابعة الأخطاء'),
  ),
  _Tool(
    icon: FontAwesomeIcons.googlePlay,
    color: AppColors.playStore,
    label: L18n('Play Console', 'Play Console'),
    role: L18n('Android Release', 'نشر Android'),
  ),
  _Tool(
    icon: FontAwesomeIcons.apple,
    color: Colors.white,
    label: L18n('Xcode + Transporter', 'Xcode + Transporter'),
    role: L18n('iOS Release', 'نشر iOS'),
  ),
  _Tool(
    icon: FontAwesomeIcons.notion,
    color: Colors.white,
    label: L18n('Notion', 'Notion'),
    role: L18n('Specs & Notes', 'المتطلبات و الملاحظات'),
  ),
  _Tool(
    icon: FontAwesomeIcons.slack,
    color: AppColors.slack,
    label: L18n('Slack', 'سلاك'),
    role: L18n('Team Comms', 'تواصل الفريق'),
  ),
  _Tool(
    icon: FontAwesomeIcons.fileLines,
    color: AppColors.swagger,
    label: L18n('Swagger', 'Swagger'),
    role: L18n('API Contracts', 'عقود APIs'),
  ),
];

class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'tools.eyebrow'),
          title: Tr.k(context, 'tools.title'),
          subtitle: Tr.k(context, 'tools.subtitle'),
          icon: Icons.handyman_outlined,
        ),
        GlassCard(
          padding: EdgeInsets.all(isMobile ? AppSizes.headerGap : 22),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const spacing = AppSizes.md - 2;
              // Fit as many 220px columns as the card can hold, then divide
              // the width evenly between them. A fixed 220 left a ragged gap
              // at most window sizes; this keeps the grid flush at any width
              // and still collapses to full-bleed rows on a phone.
              final available = constraints.maxWidth;
              final columns = isMobile
                  ? 1
                  : ((available + spacing) / (220 + spacing)).floor().clamp(1, 4);
              final itemWidth =
                  (available - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: List.generate(_tools.length, (index) {
                  return SizedBox(
                    width: itemWidth,
                    child: _ToolTile(tool: _tools[index]),
                  )
                      .animate()
                      .fadeIn(
                        duration: 350.ms,
                        delay: Duration(milliseconds: 40 * index),
                      )
                      .slideY(begin: 0.15, end: 0, curve: Curves.easeOut);
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ToolTile extends StatelessWidget {
  final _Tool tool;
  const _ToolTile({required this.tool});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              color: tool.color.withValues(alpha: 0.12),
              border: Border.all(color: tool.color.withValues(alpha: 0.30)),
            ),
            child: FaIcon(tool.icon, size: 14, color: tool.color),
          ),
          const SizedBox(width: AppSizes.md - 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tool.label.t(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: AppSizes.xxs),
                Text(
                  tool.role.t(context),
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
    );
  }
}
