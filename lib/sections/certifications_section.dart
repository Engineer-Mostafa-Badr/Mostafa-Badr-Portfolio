import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/models/course_item.dart';
import 'package:mostafa_badr_portfolio/sections/courses_section.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final cardAspectRatio = device == DeviceType.desktop
        ? 1.35
        : device == DeviceType.tablet
            ? 1.20
            : 0.95;
    final maxCardWidth = device == DeviceType.desktop
        ? 560.0
        : device == DeviceType.tablet
            ? 460.0
            : double.infinity;

    const certification = CourseItem(
      title: L18n(
        'Flutter Diploma — Route Academy',
        'دبلومة Flutter — Route Academy',
      ),
      description: L18n(
        'Route Academy — Flutter Diploma at Nasr City, Cairo. May 2024 – Sep 2024.',
        'Route Academy — دبلومة Flutter في مدينة نصر، القاهرة. مايو 2024 – سبتمبر 2024.',
      ),
      image: 'assets/images/certificates/1735110803287.jpg',
      certificateUrl: 'https://www.routeacademy.com/your_certificate_link',
    );

    final card = AspectRatio(
      aspectRatio: cardAspectRatio,
      child: const CourseShowcase(course: certification, isCertificate: true),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'certs.eyebrow'),
          title: Tr.k(context, 'certs.title'),
          subtitle: Tr.k(context, 'certs.subtitle'),
          icon: Icons.verified_outlined,
        ),
        if (isMobile)
          card
        else
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxCardWidth),
              child: card,
            ),
          ),
      ],
    );
  }
}
