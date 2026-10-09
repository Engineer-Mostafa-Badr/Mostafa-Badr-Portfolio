import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'education.eyebrow'),
          title: Tr.k(context, 'education.title'),
          icon: Icons.school_outlined,
        ),
        const EducationCard(),
      ],
    );
  }
}

class EducationCard extends StatelessWidget {
  const EducationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? AppSizes.lg : 22),
      hoverable: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            ),
            child: const Icon(
              Icons.school_outlined,
              size: 32,
              color: AppColors.cyan,
            ),
          ),
          const SizedBox(width: AppSizes.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Tr.k(context, 'education.degree'),
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: AppSizes.xs + 2),
                Text(
                  Tr.k(context, 'education.university'),
                  style: TextStyle(
                    color: AppColors.cyan,
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 13,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: AppSizes.xs + 2),
                    // Flexible so a longer localized date string wraps rather
                    // than pushing past the card on a narrow phone.
                    Flexible(
                      child: Text(
                        Tr.k(context, 'education.dates'),
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: isMobile ? 12 : 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
