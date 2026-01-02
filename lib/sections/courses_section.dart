import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/models/course_item.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';

class CoursesSection extends StatelessWidget {
  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Courses',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ..._courses.map(
          (course) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CourseShowcase(course: course),
          ),
        ),
      ],
    );
  }
}

final List<CourseItem> _courses = [
  CourseItem(
    title: 'Flutter & Dart With Clean Architecture [Arabic][2024]',
    description:
        'Comprehensive course on Flutter & Dart focusing on Clean Architecture principles.',
    image:
        'assets/images/certificates/UC-80363353-13c9-4b82-ab7f-1f67da6cae14.jpg',
    certificateUrl:
        'https://www.udemy.com/course/flutter-dart-with-clean-architecture-arabic2024/',
  ),
  CourseItem(
    title: 'The Complete Flutter Development Guide ',
    description:
        'Step-by-step course covering Flutter basics to advanced topics with real-world projects.',
    image:
        'assets/images/certificates/UC-bf5a00eb-7377-4ced-9f19-e9e8b84b7373.jpg',
    certificateUrl: 'https://www.udemy.com/course/fluttercourse/',
  ),
  CourseItem(
    title: 'SOLID Design Principles - in Arabic (بالعربي) ',
    description:
        'In-depth course on SOLID principles and design patterns in Flutter.',
    image:
        'assets/images/certificates/UC-b40e0452-2e45-4ea5-8c02-8ee6eb0d4be5.jpg',
    certificateUrl:
        'https://www.udemy.com/course/solid-design-principles-in-arabic/',
  ),
  CourseItem(
    title: 'E-commerce App & Admin Website Using Flutter & Supabase ',
    description:
        'Build a complete e-commerce app and admin website using Flutter and Supabase.',
    image:
        'assets/images/certificates/UC-ab120903-41b3-4f64-81c1-913711fbce18.jpg',
    certificateUrl:
        'https://www.udemy.com/course/e-commerce-app-admin-website-using-flutter-supabase/',
  ),
  CourseItem(
    title: 'Flutter advanced applications [ More than 20 apps ]',
    description:
        'Build more than 20 advanced Flutter applications covering various domains.',
    image:
        'assets/images/certificates/UC-310e8a5d-2690-4f74-9cdc-90313d329737.jpg',
    certificateUrl:
        'https://www.udemy.com/course/flutter-advanced-applications-more-than-20-apps/',
  ),
];

class CourseShowcase extends StatelessWidget {
  final CourseItem course;
  final bool isCertificate;

  const CourseShowcase({
    required this.course,
    this.isCertificate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;

    return Card(
      margin: EdgeInsets.symmetric(vertical: isMobile ? 10 : 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.black.withOpacity(0.35),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 10 : 16),
        child: isMobile
            ? Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      course.image,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        width: double.infinity,
                        height: 160,
                        color: Colors.black26,
                        child: const Icon(Icons.broken_image, size: 48),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    course.description,
                    style: TextStyle(color: Colors.grey[300]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () => openUrl(course.certificateUrl),
                    icon: const Icon(Icons.open_in_new),
                    label: Text(
                      isCertificate ? 'View Certificate' : 'View Course',
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      course.image,
                      width: 250,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        width: 250,
                        height: 200,
                        color: Colors.black26,
                        child: const Icon(Icons.broken_image, size: 48),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          course.description,
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () => openUrl(course.certificateUrl),
                          icon: const Icon(Icons.open_in_new),
                          label: Text(
                            isCertificate ? 'View Certificate' : 'View Course',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
