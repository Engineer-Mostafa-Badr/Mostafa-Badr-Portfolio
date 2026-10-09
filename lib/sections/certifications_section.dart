import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_assets.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/models/course_item.dart';
import 'package:mostafa_badr_portfolio/sections/courses_section.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

const _diploma = CourseItem(
  title: L18n(
    'Flutter Diploma — Route Academy',
    'دبلومة Flutter — Route Academy',
  ),
  description: L18n(
    'Route Academy — Flutter Diploma at Nasr City, Cairo. May 2024 – Sep 2024.',
    'Route Academy — دبلومة Flutter في مدينة نصر، القاهرة. مايو 2024 – سبتمبر '
    '2024.',
  ),
  image: CertificateAssets.routeAcademyDiploma,
  certificateUrl:
      'https://drive.google.com/file/d/1J7MAiIBzGmyq46L5FRzsGgD0MIAsuBJH/view',
);

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'certs.eyebrow'),
          title: Tr.k(context, 'certs.title'),
          subtitle: Tr.k(context, 'certs.subtitle'),
          icon: Icons.verified_outlined,
        ),
        ResponsiveBuilder(
          builder: (context, constraints, device) {
            final maxCardWidth = switch (device) {
              DeviceType.desktop => 560.0,
              DeviceType.tablet => 460.0,
              DeviceType.mobile => double.infinity,
            };
            final available = constraints.hasBoundedWidth
                ? constraints.maxWidth
                : context.screenWidth;
            final cardWidth =
                maxCardWidth == double.infinity ? available : maxCardWidth;

            // Same body-height reasoning as the courses grid: the copy needs a
            // fixed vertical budget, so the ratio follows from the width the
            // card actually gets.
            const bodyHeight = 118.0;
            final coverHeight = cardWidth * 0.58;

            return Align(
              alignment: AlignmentDirectional.centerStart,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxCardWidth),
                child: AspectRatio(
                  aspectRatio: cardWidth / (coverHeight + bodyHeight),
                  child: CourseShowcase(
                    course: _diploma,
                    isCertificate: true,
                    cellWidth: cardWidth,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
