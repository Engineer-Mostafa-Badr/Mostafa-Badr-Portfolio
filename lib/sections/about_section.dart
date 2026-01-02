import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'About Me',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "I'm Mostafa Badr — a passionate Flutter Developer with over one year of hands-on experience building Android & iOS apps. "
          "I’ve collaborated with companies like New Touch Business Solutions and Green Line, developing real-world projects in real estate, "
          "e-commerce, and social media domains.\n\n"
          "My expertise includes building scalable mobile apps with Flutter & Dart, integrating backends such as Laravel, Node.js, Supabase, and Firebase. "
          "I follow SOLID principles, write clean code, and focus on creating smooth user experiences.",
          style: TextStyle(
            color: Colors.grey,
            height: 1.6,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
