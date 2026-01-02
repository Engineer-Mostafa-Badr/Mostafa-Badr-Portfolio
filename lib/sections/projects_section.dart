import 'package:mostafa_badr_portfolio/models/project_item.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Projects',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ..._projects.map(
          (project) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ProjectShowcase(project: project),
          ),
        ),
      ],
    );
  }
}

class ProjectShowcase extends StatelessWidget {
  final ProjectItem project;

  const ProjectShowcase({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final carouselHeight = device == DeviceType.desktop
        ? 360.0
        : device == DeviceType.tablet
        ? 300.0
        : 220.0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      // ignore: deprecated_member_use
      color: Colors.black.withOpacity(0.35),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: project.techs
                      .map(
                        (tech) => Chip(
                          label: Text(tech),
                          backgroundColor: Colors.black45,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (project.statusLabel.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: project.statusColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  project.statusLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              project.shortDescription,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: isMobile ? 13 : 15,
              ),
            ),
            if (project.impactHighlights.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: project.impactHighlights
                    .map(
                      (impact) => Chip(
                        label: Text(
                          impact,
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontSize: isMobile ? 11 : 12,
                          ),
                        ),
                        backgroundColor: Colors.white10,
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 14),
            if (project.images.isNotEmpty)
              CarouselSlider(
                items: project.images.map((img) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 12),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: AspectRatio(
                        aspectRatio: isMobile ? 4 / 3 : 16 / 9,
                        child: Image.asset(
                          img,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          semanticLabel: '${project.title} screenshot',
                          errorBuilder: (context, error, stack) => Container(
                            color: Colors.black26,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 48),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: carouselHeight,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: device == DeviceType.mobile ? 0.9 : 0.85,
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => openUrl(project.apkUrl),
                  icon: const Icon(Icons.download_rounded),
                  label: const Text('Download APK'),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () => openUrl(project.repoUrl),
                  icon: const Icon(Icons.code),
                  label: const Text('View Repo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final List<ProjectItem> _projects = [
  ProjectItem(
    title: 'Captain Drive – Ride-Hailing Platform',
    shortDescription:
        'Captain Drive connects customers and owners (captains) on a single platform dedicated to passenger trips.',
    images: [
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 75.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 76.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 77.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 84.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 86.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 89.png',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1-XcYMLJmfAivH3k5Ny2VG7U4hBrdpc1o/view?usp=sharing',
    repoUrl: 'https://github.com/Engineer-Mostafa-Badr/Captain-Drive',
    techs: ['Flutter', 'Laravel'],
    statusLabel: 'Live on Play Store',
    statusColor: Colors.green,
    impactHighlights: const [
      'Multi-role ride-hailing flows for captains and passengers.',
      'OTP login, payment split, and push notifications shipped.',
    ],
  ),
  ProjectItem(
    title: 'Doctor Hunt – Patient booking and follow-up',
    shortDescription:
        'Booking and follow-up for the patient through a special app for the doctor, with the ability to communicate with him via chat or conversation.',
    images: [
      'assets/images/doctor/02_Onboarding screen-01.png',
      'assets/images/doctor/05_Home screen.png',
      'assets/images/doctor/06_Doctor Live Chat screen.png',
      'assets/images/doctor/10_Poplular doctor screen.png',
      'assets/images/doctor/13_Doctor appointment screen-01.png',
      'assets/images/doctor/21_Menu screen.png',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1-XcYMLJmfAivH3k5Ny2VG7U4hBrdpc1o/view?usp=sharing',
    repoUrl: 'https://github.com/Engineer-Mostafa-Badr',
    techs: ['Flutter', 'Laravel'],
    statusLabel: 'In Testing (Beta)',
    statusColor: Colors.orange,
    impactHighlights: const [
      'Doctor booking + chat experience ready for pilot partners.',
      'Follow-up dashboards sync appointments and reminders.',
    ],
  ),
  ProjectItem(
    title: 'Alawaly – Real Estate',
    shortDescription:
        'Real estate sales & rental app with OTP, roles, admin dashboard and bank financing integration.',
    images: [
      'assets/images/alawaly/sign up2.png',
      'assets/images/alawaly/تفاصيل الوحدة.png',
      'assets/images/alawaly/المشاريع.png',
      'assets/images/alawaly/تفاصيل المشروع.png',
      'assets/images/alawaly/نتائج البحث علي الخريطة2.png',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1-XcYMLJmfAivH3k5Ny2VG7U4hBrdpc1o/view?usp=sharing',
    repoUrl: 'https://github.com/Engineer-Mostafa-Badr/Alawaly',
    techs: ['Flutter', 'Laravel'],
    statusLabel: 'Maintenance',
    statusColor: Colors.blueGrey,
    impactHighlights: const [
      'Financing flow with bank selection and role-based dashboards.',
      'Multi-language search paired with map filtering.',
    ],
  ),
  ProjectItem(
    title: 'Mubasher – Real Estate',
    shortDescription:
        'Multi-role rental & sales app with location detection, in-app chat and multi-language support.',
    images: [
      'assets/images/mubasher/Product Tour - 01.png',
      'assets/images/mubasher/Product Tour - 03.png',
      'assets/images/mubasher/catigories.png',
      'assets/images/mubasher/My banners.png',
      'assets/images/mubasher/Profile Detail2.png',
      'assets/images/mubasher/Top Locations - Location Detail.png',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1rZF_vLe1U6XXg1PYezUz-rP06aNV9SoO/view?usp=sharing',
    repoUrl: 'https://github.com/Engineer-Mostafa-Badr/Mubasher/tree/Mubasher',
    techs: ['Flutter', 'Node.js'],
    statusLabel: 'Live',
    statusColor: Colors.green,
    impactHighlights: const [
      'Location-aware rental suggestions with agent-facing chat.',
      'Multi-language experience for clients, owners, and agents.',
    ],
  ),
  ProjectItem(
    title: 'E-Commerce App',
    shortDescription:
        'E-commerce app: products, reviews, cart and real-time syncing via Supabase.',
    images: [
      'assets/images/ecommerce/IMG-20250411-WA0088.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0090.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0096.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0099.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0101.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0104.jpg',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1yba65wJUIX7U2GLL6KZBKq-VDvyL71lK/view?usp=sharing',
    repoUrl: 'https://github.com/Engineer-Mostafa-Badr/E-commerce-App',
    techs: ['Flutter', 'Supabase'],
    statusLabel: 'Internal Demo',
    statusColor: Colors.purple,
    impactHighlights: const [
      'Realtime cart & inventory powered by Supabase.',
      'Reviews, filters, and checkout ready for QA.',
    ],
  ),
  ProjectItem(
    title: 'Social — Facebook / Insta style',
    shortDescription:
        'Social app with posting, comments, profile customization and Firestore realtime sync.',
    images: [
      'assets/images/social_media/Screenshot (58).png',
      'assets/images/social_media/Screenshot (59).png',
      'assets/images/social_media/Screenshot (60).png',
      'assets/images/social_media/Screenshot (61).png',
      'assets/images/social_media/Screenshot (62).png',
      'assets/images/social_media/Screenshot (63).png',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1Qgd_nOFKXrYIPt3sp5B0O7CypF0jWFec/view?usp=sharing',
    repoUrl:
        'https://github.com/Engineer-Mostafa-Badr/Social-Media-App/tree/master',
    techs: ['Flutter', 'Firebase'],
    statusLabel: 'Prototype',
    statusColor: Colors.amber,
    impactHighlights: const [
      'Realtime feed and comments on Firestore.',
      'Profile customization with posting + story flows.',
    ],
  ),
  ProjectItem(
    title: 'Al Dokan ',
    shortDescription:
        'Social app with posting, comments, profile customization and Firestore realtime sync.',
    images: [
      'assets/images/al_dokan/Chalet page.png',
      'assets/images/al_dokan/filled search.png',
      'assets/images/al_dokan/Home page1.png',
      'assets/images/al_dokan/products listing.png',
      'assets/images/al_dokan/splash Screen1.png',
      'assets/images/al_dokan/الشاليهات.png',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1Qgd_nOFKXrYIPt3sp5B0O7CypF0jWFec/view?usp=sharing',
    repoUrl: 'https://github.com/Engineer-Mostafa-Badr',
    techs: ['Flutter', '.NET'],
    statusLabel: 'Beta',
    statusColor: Colors.blue,
    impactHighlights: const [
      'Marketplace layout for chalets and local products.',
      'Fast search with product/story-style views.',
    ],
  ),
];
