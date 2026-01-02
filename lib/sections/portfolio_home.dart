import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/sections/about_section.dart';
import 'package:mostafa_badr_portfolio/sections/contact_section.dart';
import 'package:mostafa_badr_portfolio/sections/courses_section.dart';
import 'package:mostafa_badr_portfolio/sections/certifications_section.dart';
import 'package:mostafa_badr_portfolio/sections/education_section.dart';
import 'package:mostafa_badr_portfolio/sections/footer_section.dart';
import 'package:mostafa_badr_portfolio/sections/hero_section.dart';
import 'package:mostafa_badr_portfolio/sections/projects_section.dart';
import 'package:mostafa_badr_portfolio/sections/skills_section.dart';
import 'package:mostafa_badr_portfolio/sections/work_experience_section.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/widgets/animated_background.dart';
import 'package:mostafa_badr_portfolio/widgets/animated_section.dart';
import 'package:mostafa_badr_portfolio/widgets/top_bar.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroSectionKey = GlobalKey();
  final GlobalKey _projectsSectionKey = GlobalKey();
  final GlobalKey _contactSectionKey = GlobalKey();

  List<SectionTarget> get _sectionTargets => [
        SectionTarget(label: 'Home', key: _heroSectionKey),
        SectionTarget(label: 'Projects', key: _projectsSectionKey),
        SectionTarget(label: 'Contact', key: _contactSectionKey),
      ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final horizontalPadding = device == DeviceType.desktop
        ? 300.0
        : device == DeviceType.tablet
            ? 80.0
            : 16.0;

    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    AnimatedSection(
                      child: TopBar(sectionTargets: _sectionTargets),
                    ),
                    const SizedBox(height: 20),
                    AnimatedSection(
                      key: _heroSectionKey,
                      child: const HeroSection(),
                    ),
                    const SizedBox(height: 28),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 20),
                    const AnimatedSection(child: AboutSection()),
                    const SizedBox(height: 36),
                    const AnimatedSection(child: EducationSection()),
                    const SizedBox(height: 36),
                    const AnimatedSection(child: WorkExperienceSection()),
                    const SizedBox(height: 36),
                    const AnimatedSection(child: CoursesSection()),
                    const SizedBox(height: 36),
                    const AnimatedSection(child: CertificationsSection()),
                    const SizedBox(height: 36),
                    AnimatedSection(
                      key: _projectsSectionKey,
                      child: const ProjectsSection(),
                    ),
                    const SizedBox(height: 28),
                    const AnimatedSection(child: SkillsSection()),
                    const SizedBox(height: 36),
                    AnimatedSection(
                      key: _contactSectionKey,
                      child: const ContactSection(),
                    ),
                    const SizedBox(height: 36),
                    const AnimatedSection(child: FooterSection()),
                    const SizedBox(height: 28),
                    Center(
                      child: Text(
                        '© ${DateTime.now().year} Mostafa Badr',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
