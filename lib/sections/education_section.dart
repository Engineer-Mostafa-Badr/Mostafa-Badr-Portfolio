import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final ar = isArabic(context);

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      hoverable: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF40C4FF).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.school_outlined,
              size: 32,
              color: Color(0xFF40C4FF),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ar
                      ? 'بكالوريوس — كلية الحاسبات و المعلومات'
                      : 'Bachelor — Faculty of Computers and Information',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  ar
                      ? 'جامعة طنطا، طنطا، مصر'
                      : 'Tanta University, Tanta, Egypt',
                  style: TextStyle(
                    color: const Color(0xFF40C4FF),
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 13,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      ar ? 'أكتوبر 2023 – أغسطس 2027' : 'Oct 2023 – Aug 2027',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: isMobile ? 12 : 13,
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
