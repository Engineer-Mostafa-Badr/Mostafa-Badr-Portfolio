import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/models/course_item.dart';
import 'package:mostafa_badr_portfolio/sections/courses_section.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final certification = CourseItem(
      title: 'Flutter Diploma — Route Academy',
      description:
          'Route Academy — Flutter Diploma at Nasr City, Cairo.\nMay 2024 – Sep 2024',
      image: 'assets/images/certificates/1735110803287.jpg',
      certificateUrl: 'https://www.routeacademy.com/your_certificate_link',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Certifications',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        CourseShowcase(course: certification, isCertificate: true),
      ],
    );
  }
}
