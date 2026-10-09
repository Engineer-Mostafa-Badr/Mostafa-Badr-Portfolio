import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/widgets/common/tag_chip.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

/// Highlight pills under the About copy — key/colour pairs, resolved through
/// [Tr] at build time so both languages stay in the translation file.
const _highlightPills = <({String key, Color color})>[
  (key: 'about.pill.odoo', color: AppColors.teal),
  (key: 'about.pill.liveApps', color: AppColors.gold),
  (key: 'about.pill.cleanArch', color: AppColors.cyan),
  (key: 'about.pill.bilingual', color: AppColors.purple),
  (key: 'about.pill.performance', color: AppColors.mint),
];

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final bodyStyle = TextStyle(
      color: Colors.grey[300],
      height: 1.7,
      fontSize: isMobile ? 14 : 16,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'about.eyebrow'),
          title: Tr.k(context, 'about.title'),
          subtitle: Tr.k(context, 'about.subtitle'),
          icon: Icons.person_outline,
        ),
        GlassCard(
          padding: EdgeInsets.all(isMobile ? AppSizes.headerGap : 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Tr.k(context, 'about.body1'), style: bodyStyle),
              const SizedBox(height: 14),
              Text(Tr.k(context, 'about.body2'), style: bodyStyle),
              const SizedBox(height: AppSizes.headerGap),
              Wrap(
                spacing: AppSizes.md - 2,
                runSpacing: AppSizes.md - 2,
                children: [
                  for (final pill in _highlightPills)
                    TagChip(
                      label: Tr.k(context, pill.key),
                      accent: pill.color,
                      size: TagChipSize.medium,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
