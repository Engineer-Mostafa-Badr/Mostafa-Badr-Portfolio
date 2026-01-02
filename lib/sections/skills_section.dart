import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Skills & Tools',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        SkillsGrid(),
      ],
    );
  }
}

final List<String> _skills = [
  'Dart',
  'Flutter',
  'SOLID Principles',
  'OOP',
  'Clean Architecture',
  'Design Patterns',
  'State Management (Bloc / Provider , Cubit)',
  'Firebase',
  'Supabase',
  'Clean Code',
  'RESTful APIs',
  'MVVM',
  'Git & GitHub',
  "Swagger",
  "Postman",
  "Shared Preferences",
  "Payment Gateway Integration",
  "Push Notifications",
  "Localization",
  "Google Maps Integration",
  "Performance Optimization",
  "Responsive Design",
  "Cross-Platform Development",
  'CI/CD',
];

class SkillsGrid extends StatelessWidget {
  const SkillsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final chipPadding = device == DeviceType.mobile ? 10.0 : 14.0;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _skills.map((skill) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: chipPadding, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white10),
          ),
          child: Text(skill, style: const TextStyle(fontWeight: FontWeight.w600)),
        );
      }).toList(),
    );
  }
}
