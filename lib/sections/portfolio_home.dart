import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/sections/about_section.dart';
import 'package:mostafa_badr_portfolio/sections/contact_section.dart';
import 'package:mostafa_badr_portfolio/sections/courses_section.dart';
import 'package:mostafa_badr_portfolio/sections/certifications_section.dart';
import 'package:mostafa_badr_portfolio/sections/education_section.dart';
import 'package:mostafa_badr_portfolio/sections/footer_section.dart';
import 'package:mostafa_badr_portfolio/sections/hero_section.dart';
import 'package:mostafa_badr_portfolio/sections/pre_footer_cta.dart';
import 'package:mostafa_badr_portfolio/sections/process_section.dart';
import 'package:mostafa_badr_portfolio/sections/projects_section.dart';
import 'package:mostafa_badr_portfolio/sections/skills_section.dart';
import 'package:mostafa_badr_portfolio/sections/tools_section.dart';
import 'package:mostafa_badr_portfolio/sections/work_experience_section.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/scroll_notifier.dart';
import 'package:mostafa_badr_portfolio/widgets/animated_background.dart';
import 'package:mostafa_badr_portfolio/widgets/animated_section.dart';
import 'package:mostafa_badr_portfolio/widgets/command_palette.dart';
import 'package:mostafa_badr_portfolio/widgets/section_nav_dots.dart';
import 'package:mostafa_badr_portfolio/widgets/top_bar.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroSectionKey = GlobalKey();
  final GlobalKey _aboutSectionKey = GlobalKey();
  final GlobalKey _skillsSectionKey = GlobalKey();
  final GlobalKey _experienceSectionKey = GlobalKey();
  final GlobalKey _projectsSectionKey = GlobalKey();
  final GlobalKey _contactSectionKey = GlobalKey();

  double _scrollProgress = 0.0;
  bool _showScrollToTop = false;
  bool _showStickyStats = false;

  List<SectionTarget> get _sectionTargets => [
        SectionTarget(labelKey: 'nav.home', key: _heroSectionKey),
        SectionTarget(labelKey: 'nav.about', key: _aboutSectionKey),
        SectionTarget(labelKey: 'nav.skills', key: _skillsSectionKey),
        SectionTarget(labelKey: 'nav.experience', key: _experienceSectionKey),
        SectionTarget(labelKey: 'nav.projects', key: _projectsSectionKey),
        SectionTarget(labelKey: 'nav.contact', key: _contactSectionKey),
      ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    AppScroll.offset.value = current;
    final progress = max <= 0 ? 0.0 : (current / max).clamp(0.0, 1.0);
    final showButton = current > 600;
    final showSticky = current > 320;
    if (progress != _scrollProgress ||
        showButton != _showScrollToTop ||
        showSticky != _showStickyStats) {
      setState(() {
        _scrollProgress = progress;
        _showScrollToTop = showButton;
        _showStickyStats = showSticky;
      });
    }
  }

  Future<void> _scrollToTop() async {
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _scrollToSection(String labelKey) async {
    final target = _sectionTargets.firstWhere(
      (t) => t.labelKey == labelKey,
      orElse: () => _sectionTargets.first,
    );
    final ctx = target.key.currentContext;
    if (ctx != null && ctx.mounted) {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final horizontalPadding = device == DeviceType.desktop
        ? 220.0
        : device == DeviceType.tablet
            ? 60.0
            : 16.0;

    return Scaffold(
      body: CommandPaletteHost(
        onNavigate: _scrollToSection,
        onToggleTheme: AppThemeController.toggle,
        onToggleLocale: AppLocaleController.toggle,
        child: Stack(
        children: [
          const AnimatedBackground(),
          ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(scrollbars: false),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              interactive: true,
              thickness: 10,
              radius: const Radius.circular(8),
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
                      TopBar(sectionTargets: _sectionTargets),
                      const SizedBox(height: 24),
                      AnimatedSection(
                        key: _heroSectionKey,
                        child: const HeroSection(),
                      ),
                      const SizedBox(height: 56),
                      AnimatedSection(
                        key: _aboutSectionKey,
                        child: const AboutSection(),
                      ),
                      const SizedBox(height: 56),
                      AnimatedSection(
                        key: _skillsSectionKey,
                        child: const SkillsSection(),
                      ),
                      const SizedBox(height: 56),
                      const AnimatedSection(child: ToolsSection()),
                      const SizedBox(height: 56),
                      const AnimatedSection(child: ProcessSection()),
                      const SizedBox(height: 56),
                      AnimatedSection(
                        key: _experienceSectionKey,
                        child: const WorkExperienceSection(),
                      ),
                      const SizedBox(height: 56),
                      AnimatedSection(
                        key: _projectsSectionKey,
                        child: const ProjectsSection(),
                      ),
                      const SizedBox(height: 56),
                      const AnimatedSection(child: CertificationsSection()),
                      const SizedBox(height: 56),
                      const AnimatedSection(child: CoursesSection()),
                      const SizedBox(height: 56),
                      const AnimatedSection(child: EducationSection()),
                      const SizedBox(height: 56),
                      AnimatedSection(
                        key: _contactSectionKey,
                        child: const ContactSection(),
                      ),
                      const SizedBox(height: 56),
                      const AnimatedSection(child: PreFooterCta()),
                      const SizedBox(height: 40),
                      const AnimatedSection(child: FooterSection()),
                      const SizedBox(height: 28),
                      Center(
                        child: Text(
                          '© ${DateTime.now().year} ${isArabic(context) ? 'مصطفى بدر' : 'Mostafa Badr'} — ${Tr.k(context, 'footer.copyright')}',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Reading progress bar — pinned to top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _ReadingProgressBar(progress: _scrollProgress),
          ),
          // Sticky stats banner (appears past the hero)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            top: _showStickyStats ? 6 : -60,
            left: 0,
            right: 0,
            child: _StickyStatsBanner(visible: _showStickyStats),
          ),
          // Right-edge section indicator dots (desktop only)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: SectionNavDots(
                targets: _sectionTargets,
                scrollController: _scrollController,
              ),
            ),
          ),
          // Scroll-to-top floating button
          if (_showScrollToTop)
            Positioned(
              bottom: 24,
              right: 24,
              child: _ScrollToTopButton(onTap: _scrollToTop),
            ),
        ],
        ),
      ),
    );
  }
}

class _ReadingProgressBar extends StatelessWidget {
  final double progress;
  const _ReadingProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        height: 3,
        child: Stack(
          children: [
            Container(color: Colors.white.withValues(alpha: 0.04)),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFD700),
                      Color(0xFF40C4FF),
                      Color(0xFF9C7BFF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x6640C4FF),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyStatsBanner extends StatelessWidget {
  final bool visible;
  const _StickyStatsBanner({required this.visible});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final isNarrow = width < 420;
    final ar = isArabic(context);

    // On very narrow screens drop the wordy items and keep only the two
    // numeric KPIs + availability dot.
    final items = ar
        ? (isNarrow
            ? const [
                ('6', 'تطبيقات'),
                ('4', 'Odoo'),
                ('●', 'متاح'),
              ]
            : const [
                ('6', 'تطبيقات حية'),
                ('4', 'Odoo'),
                ('2+', 'سنوات'),
                ('●', 'متاح'),
              ])
        : (isNarrow
            ? const [
                ('6', 'Live'),
                ('4', 'Odoo'),
                ('●', 'Open'),
              ]
            : const [
                ('6', 'Live'),
                ('4', 'Odoo'),
                ('2+', 'Years'),
                ('●', 'Available'),
              ]);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 220),
      opacity: visible ? 1 : 0,
      child: IgnorePointer(
        ignoring: !visible,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 14 : 24),
            padding: EdgeInsets.symmetric(
              horizontal: isNarrow ? 10 : 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF0E152B).withValues(alpha: 0.85),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 18,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(items.length, (i) {
                final (value, label) = items[i];
                final isAvailable = i == items.length - 1;
                final color = isAvailable
                    ? const Color(0xFF34D399)
                    : i == 0
                        ? const Color(0xFF40C4FF)
                        : i == 1
                            ? const Color(0xFF22D3EE)
                            : const Color(0xFFFFD700);
                final gap = isNarrow ? 8.0 : 12.0;
                return Padding(
                  padding: EdgeInsets.only(
                    right: i == items.length - 1 ? 0 : gap,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          color: color,
                          fontSize: isMobile ? 13 : 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: isMobile ? 11 : 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (i != items.length - 1)
                        Padding(
                          padding: EdgeInsets.only(left: gap),
                          child: Container(
                            width: 1,
                            height: 12,
                            color: Colors.white.withValues(alpha: 0.10),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollToTopButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ScrollToTopButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isArabic(context) ? 'العودة للأعلى' : 'Back to top',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFD700), Color(0xFF40C4FF)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF40C4FF).withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_upward_rounded,
              color: Colors.black,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
