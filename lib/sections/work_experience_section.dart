import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:flutter/material.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Work Experience',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 12),
        ExperienceCard(
          position: 'Mobile App Developer',
          company: 'New Touch for Business Solutions Company',
          location: 'Riyadh, Saudi Arabia',
          date: 'July 2025 – Oct 2025 · Remote',
          description: '''
          Contributed to the development of a real estate mobile application (buying, selling, and renting properties) using Flutter.

          Key projects include:
        •  Implemented user authentication with mobile number login and OTP verification.
        •  Developed account creation flows for different user roles: clients, property owners, and real estate agents.
        •  Built home screen modules displaying available properties with filtering for sale/rent and payment options (cash or installments).
        •  Enabled property management features for sellers to control and update their listings.
        •  Integrated push notifications to keep clients, agents, and sellers updated with real-time changes.
        •  Added bank selection feature for financing support to facilitate property purchases.
        •  Focused on delivering a smooth user experience, scalability, and performance optimization.
          ''',
          highlights: [
            'Launched OTP & multi-role onboarding for over 50k+ tenants, owners, and agents.',
            'Designed financing flows and push notification triggers that boosted retention across user groups.',
            'Delivered scalable property filters and management tooling with minimal performance overhead.',
          ],
          technologies: ['Flutter', 'Laravel', 'Firebase'],
        ),
        SizedBox(height: 18),
        ExperienceCard(
          position: 'Mobile App Developer',
          company: 'Green Line Company',
          location: 'Cairo, Egypt',
          date: 'Aug 2024 – July 2025 · Remote',
          description: '''
          Working as a Mobile App Developer, contributing to real, production-level applications in a collaborative and fast-paced environment.

          Key projects include:
          • Real Estate App – Enabled property listing, buying, selling, and renting with OTP-based authentication, role-based accounts \n            (clients, owners, agents), property management for sellers, and real-time push notifications. Focused on performance, scalability, \n            and user experience.
          • Car Maintenance App – Built modules for real-time booking, tracking, and service management, ensuring seamless UI and reliable      \n            backend integration.
          • E-commerce Platform – Developed core shopping flows, integrated payment gateways, and optimized performance for large-scale use.
          ''',
          highlights: [
            'Delivered three customer-facing apps (real estate, car maintenance, e-commerce) within tight release cycles.',
            'Crafted reusable onboarding + OTP stacks, allowing stakeholders to launch new flows in days.',
            'Improved UI/UX consistency and backend stability across Laravel + Supabase integrations.',
          ],
          technologies: ['Flutter', 'Laravel', 'Node.js'],
        ),
      ],
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final String position;
  final String company;
  final String location;
  final String date;
  final String description;
  final List<String> technologies;
  final List<String> highlights;

  const ExperienceCard({
    required this.position,
    required this.company,
    required this.location,
    required this.date,
    required this.description,
    this.highlights = const [],
    this.technologies = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;

    return SizedBox(
      width: double.infinity,
      child: Card(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 7,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 14 : 18),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: isMobile ? 220 : 260),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  position,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  company,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$location · $date',
                  style: TextStyle(color: Colors.grey[400], fontSize: 20),
                ),
                const SizedBox(height: 12),
                Text(
                  description.trim(),
                  style: TextStyle(
                    color: Colors.grey[300],
                    height: 1.5,
                    fontSize: isMobile ? 14 : 18,
                  ),
                ),
                if (technologies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: technologies
                        .map(
                          (tech) => Chip(
                            label: Text(tech),
                            backgroundColor: Colors.white12,
                            labelStyle: TextStyle(
                              color: Colors.grey[200],
                              fontSize: isMobile ? 11 : 13,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (highlights.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Column(
                    children: highlights
                        .map(
                          (highlight) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: isMobile ? 16 : 18,
                                  color: Colors.lightBlueAccent,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    highlight,
                                    style: TextStyle(
                                      color: Colors.grey[200],
                                      fontSize: isMobile ? 13 : 16,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
