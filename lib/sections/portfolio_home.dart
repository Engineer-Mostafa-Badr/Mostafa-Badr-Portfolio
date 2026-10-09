import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/sections/about_section.dart';
import 'package:mostafa_badr_portfolio/sections/certifications_section.dart';
import 'package:mostafa_badr_portfolio/sections/contact_section.dart';
import 'package:mostafa_badr_portfolio/sections/courses_section.dart';
import 'package:mostafa_badr_portfolio/sections/education_section.dart';
import 'package:mostafa_badr_portfolio/sections/footer_section.dart';
import 'package:mostafa_badr_portfolio/sections/hero_section.dart';
import 'package:mostafa_badr_portfolio/sections/pre_footer_cta.dart';
import 'package:mostafa_badr_portfolio/sections/process_section.dart';
import 'package:mostafa_badr_portfolio/sections/projects_section.dart';
import 'package:mostafa_badr_portfolio/sections/skills_section.dart';
import 'package:mostafa_badr_portfolio/sections/tools_section.dart';
import 'package:mostafa_badr_portfolio/sections/work_experience_section.dart';
import 'package:mostafa_badr_portfolio/data/projects_data.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/scroll_notifier.dart';
import 'package:mostafa_badr_portfolio/widgets/animated_background.dart';
import 'package:mostafa_badr_portfolio/widgets/animated_section.dart';
import 'package:mostafa_badr_portfolio/widgets/command_palette.dart';
import 'package:mostafa_badr_portfolio/widgets/section_nav_dots.dart';
import 'package:mostafa_badr_portfolio/widgets/top_bar.dart';

/// Scroll offset past which the "back to top" button appears.
const _scrollToTopThreshold = 600.0;

/// Scroll offset past which the compact stats banner slides in.
const _stickyStatsThreshold = 320.0;

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  late final List<SectionTarget> _sectionTargets = [
    SectionTarget(labelKey: 'nav.home', key: _heroKey),
    SectionTarget(labelKey: 'nav.about', key: _aboutKey),
    SectionTarget(labelKey: 'nav.skills', key: _skillsKey),
    SectionTarget(labelKey: 'nav.experience', key: _experienceKey),
    SectionTarget(labelKey: 'nav.projects', key: _projectsKey),
    SectionTarget(labelKey: 'nav.contact', key: _contactKey),
  ];

  double _scrollProgress = 0;
  bool _showScrollToTop = false;
  bool _showStickyStats = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final max = position.maxScrollExtent;
    final current = position.pixels;

    AppScroll.offset.value = current;

    final progress = max <= 0 ? 0.0 : (current / max).clamp(0.0, 1.0);
    final showButton = current > _scrollToTopThreshold;
    final showSticky = current > _stickyStatsThreshold;

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

  Future<void> _scrollToTop() => _scrollController.animateTo(
        0,
        duration: AppDurations.scrollTo,
        curve: Curves.easeInOutCubic,
      );

  Future<void> _scrollToSection(String labelKey) async {
    final target = _sectionTargets.firstWhere(
      (t) => t.labelKey == labelKey,
      orElse: () => _sectionTargets.first,
    );
    final ctx = target.key.currentContext;
    if (ctx == null || !ctx.mounted) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: AppDurations.scrollTo,
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommandPaletteHost(
        onNavigate: _scrollToSection,
        onToggleTheme: AppThemeController.toggle,
        onToggleLocale: AppLocaleController.toggle,
        child: Stack(
          children: [
            const AnimatedBackground(),
            _PageScrollView(
              controller: _scrollController,
              sectionTargets: _sectionTargets,
              heroKey: _heroKey,
              aboutKey: _aboutKey,
              skillsKey: _skillsKey,
              experienceKey: _experienceKey,
              projectsKey: _projectsKey,
              contactKey: _contactKey,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _ReadingProgressBar(progress: _scrollProgress),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              top: _showStickyStats ? 6 : -60,
              left: 0,
              right: 0,
              child: _StickyStatsBanner(visible: _showStickyStats),
            ),
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
            if (_showScrollToTop)
              PositionedDirectional(
                bottom: AppSizes.xxl,
                end: AppSizes.xxl,
                child: _ScrollToTopButton(onTap: _scrollToTop),
              ),
          ],
        ),
      ),
    );
  }
}

/// The page itself. Split out of [PortfolioHome.build] so a scroll tick
/// rebuilds only the chrome that depends on offset — the progress bar, the
/// banner, the FAB — and leaves this subtree alone.
class _PageScrollView extends StatelessWidget {
  final ScrollController controller;
  final List<SectionTarget> sectionTargets;
  final GlobalKey heroKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  const _PageScrollView({
    required this.controller,
    required this.sectionTargets,
    required this.heroKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(scrollbars: false),
      child: Scrollbar(
        controller: controller,
        thumbVisibility: true,
        trackVisibility: true,
        interactive: true,
        thickness: 10,
        radius: const Radius.circular(AppSizes.radiusSm),
        child: SingleChildScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.pageGutter,
            vertical: AppSizes.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.sm),
              TopBar(sectionTargets: sectionTargets),
              const SizedBox(height: AppSizes.xxl),
              AnimatedSection(key: heroKey, child: const HeroSection()),
              const _SectionGap(),
              AnimatedSection(key: aboutKey, child: const AboutSection()),
              const _SectionGap(),
              AnimatedSection(key: skillsKey, child: const SkillsSection()),
              const _SectionGap(),
              const AnimatedSection(child: ToolsSection()),
              const _SectionGap(),
              const AnimatedSection(child: ProcessSection()),
              const _SectionGap(),
              AnimatedSection(
                key: experienceKey,
                child: const WorkExperienceSection(),
              ),
              const _SectionGap(),
              AnimatedSection(
                key: projectsKey,
                child: const ProjectsSection(),
              ),
              const _SectionGap(),
              const AnimatedSection(child: CertificationsSection()),
              const _SectionGap(),
              const AnimatedSection(child: CoursesSection()),
              const _SectionGap(),
              const AnimatedSection(child: EducationSection()),
              const _SectionGap(),
              AnimatedSection(key: contactKey, child: const ContactSection()),
              const _SectionGap(),
              const AnimatedSection(child: PreFooterCta()),
              const SizedBox(height: 40),
              const AnimatedSection(child: FooterSection()),
              const SizedBox(height: 28),
              const _Copyright(),
              const SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionGap extends StatelessWidget {
  const _SectionGap();

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: AppSizes.sectionGap);
}

class _Copyright extends StatelessWidget {
  const _Copyright();

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    final owner = Tr.k(context, 'footer.ownerName');
    final suffix = Tr.k(context, 'footer.copyright');

    return Center(
      child: Text(
        '© $year $owner — $suffix',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
          letterSpacing: 0.5,
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
            ColoredBox(color: Colors.white.withValues(alpha: 0.04)),
            FractionallySizedBox(
              widthFactor: progress,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.brandSweepWide,
                  ),
                  boxShadow: [
                    BoxShadow(color: Color(0x6640C4FF), blurRadius: 8),
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

/// A compact KPI strip that follows the visitor past the hero.
class _StickyStatsBanner extends StatelessWidget {
  final bool visible;
  const _StickyStatsBanner({required this.visible});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isCompact = context.isCompact;

    // On the narrowest phones the wordy items are dropped so the strip stays
    // one line instead of overflowing its rounded container.
    final items = <({String value, String labelKey, Color color})>[
      (
        value: '$liveProjectsCount',
        labelKey: isCompact ? 'sticky.liveApps' : 'sticky.liveAppsLong',
        color: AppColors.cyan,
      ),
      (value: '$odooProjectsCount', labelKey: 'sticky.odoo', color: AppColors.teal),
      if (!isCompact)
        (value: '2+', labelKey: 'sticky.years', color: AppColors.gold),
      (
        value: '●',
        labelKey: isCompact ? 'sticky.available' : 'sticky.availableLong',
        color: AppColors.success,
      ),
    ];

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 220),
      opacity: visible ? 1 : 0,
      child: IgnorePointer(
        ignoring: !visible,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: isMobile ? 14 : AppSizes.xxl,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? AppSizes.md - 2 : 14,
              vertical: AppSizes.sm,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusPill),
              color: AppColors.surfaceDark.withValues(alpha: 0.85),
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 18,
                ),
              ],
            ),
            // Wraps to a second line rather than overflowing if a translation
            // turns out longer than the strip can hold.
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: isCompact ? AppSizes.sm : AppSizes.md,
              runSpacing: AppSizes.xs,
              children: [
                for (final item in items)
                  _StickyStat(
                    value: item.value,
                    label: Tr.k(context, item.labelKey),
                    color: item.color,
                    isMobile: isMobile,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StickyStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final bool isMobile;

  const _StickyStat({
    required this.value,
    required this.label,
    required this.color,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: AppSizes.xs + 1),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: isMobile ? 11 : 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ScrollToTopButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ScrollToTopButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: Tr.k(context, 'common.backToTop'),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: AppSizes.iconButtonSize,
            height: AppSizes.iconButtonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.brandSweep,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withValues(alpha: 0.4),
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
