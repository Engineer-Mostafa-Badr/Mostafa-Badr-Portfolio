import 'package:flutter/gestures.dart';
import 'package:mostafa_badr_portfolio/data/projects_data.dart';
import 'package:mostafa_badr_portfolio/models/project_item.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';
import 'package:mostafa_badr_portfolio/widgets/project_cover.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  ProjectCategory? _activeFilter;

  List<ProjectItem> get _visible {
    if (_activeFilter == null) return projectsData;
    return projectsData
        .where((p) => p.categories.contains(_activeFilter))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final crossAxisCount = device == DeviceType.desktop
        ? 2
        : device == DeviceType.tablet
            ? 2
            : 1;
    final aspectRatio = device == DeviceType.desktop
        ? 1.05
        : device == DeviceType.tablet
            ? 0.95
            : 0.88;

    final visible = _visible;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'projects.eyebrow'),
          title: Tr.k(context, 'projects.title'),
          subtitle: Tr.k(context, 'projects.subtitle'),
          icon: Icons.rocket_launch_outlined,
        ),
        _CategoryFilterRow(
          active: _activeFilter,
          onChange: (cat) => setState(() => _activeFilter = cat),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visible.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            return _ProjectCard(
              project: visible[index],
              index: index,
              key: ValueKey('${_activeFilter?.name ?? "all"}-$index'),
            )
                .animate()
                .fadeIn(
                  duration: 600.ms,
                  delay: Duration(milliseconds: 90 * index),
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: 0.12,
                  end: 0,
                  curve: Curves.easeOutCubic,
                  duration: 600.ms,
                )
                .scaleXY(
                  begin: 0.96,
                  end: 1.0,
                  curve: Curves.easeOutCubic,
                  duration: 600.ms,
                );
          },
        ),
      ],
    );
  }
}

class _CategoryFilterRow extends StatelessWidget {
  final ProjectCategory? active;
  final ValueChanged<ProjectCategory?> onChange;

  const _CategoryFilterRow({required this.active, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final categories = <ProjectCategory?>[null, ...ProjectCategory.values];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isActive = active == cat;
          final label = cat == null
              ? Tr.k(context, 'projects.filter.all')
              : Tr.k(context, cat.labelKey);
          final count = cat == null
              ? projectsData.length
              : projectsData.where((p) => p.categories.contains(cat)).length;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: isActive
                    ? const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFF40C4FF)],
                      )
                    : null,
                color: isActive ? null : Colors.white.withValues(alpha: 0.04),
                border: Border.all(
                  color: isActive
                      ? Colors.transparent
                      : Colors.white.withValues(alpha: 0.10),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => onChange(cat),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color: isActive ? Colors.black : Colors.grey[200],
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.black.withValues(alpha: 0.20)
                                : Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$count',
                            style: TextStyle(
                              color: isActive ? Colors.black : Colors.grey[300],
                              fontWeight: FontWeight.w800,
                              fontSize: 10.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final int index;

  const _ProjectCard({
    required this.project,
    required this.index,
    super.key,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;
  Offset _localPointer = Offset.zero;
  Size _cardSize = Size.zero;

  void _open() {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => ProjectLightboxDialog(project: widget.project),
    );
  }

  void _onHover(PointerHoverEvent event) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;
    setState(() {
      _localPointer = event.localPosition;
      _cardSize = renderBox.size;
    });
  }

  Matrix4 _tiltTransform(bool enabled) {
    if (!enabled ||
        !_hovering ||
        _cardSize.width == 0 ||
        _cardSize.height == 0) {
      return Matrix4.identity()
        ..translateByDouble(0.0, _hovering ? -6.0 : 0.0, 0.0, 1.0);
    }
    // Map cursor offset to a small tilt (in radians). Max ~5°.
    final dx = (_localPointer.dx / _cardSize.width) - 0.5;
    final dy = (_localPointer.dy / _cardSize.height) - 0.5;
    final tiltY = dx * 0.08; // rotate around Y axis
    final tiltX = -dy * 0.08; // rotate around X axis
    return Matrix4.identity()
      ..setEntry(3, 2, 0.0012) // perspective
      ..rotateX(tiltX)
      ..rotateY(tiltY)
      ..translateByDouble(0.0, -6.0, 0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final tiltEnabled = !isMobile;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() {
        _hovering = false;
        _localPointer = Offset.zero;
      }),
      onHover: tiltEnabled ? _onHover : null,
      child: GestureDetector(
        onTap: _open,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transformAlignment: Alignment.center,
          transform: _tiltTransform(tiltEnabled),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.06),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
            border: Border.all(
              color: _hovering
                  ? const Color(0xFF40C4FF).withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: _hovering ? 22 : 12,
                offset: const Offset(0, 6),
              ),
              if (_hovering)
                BoxShadow(
                  color: const Color(0xFF40C4FF).withValues(alpha: 0.18),
                  blurRadius: 28,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              color: Colors.black.withValues(alpha: 0.30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover (with optional Featured badge overlay)
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: _CoverArt(
                            index: widget.index,
                            project: widget.project,
                            hovering: _hovering,
                          ),
                        ),
                        if (widget.project.featured)
                          const Positioned(
                            top: 12,
                            left: 12,
                            child: _FeaturedBadge(),
                          ),
                      ],
                    ),
                  ),
                  // Body
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 14 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project.title.t(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: isMobile ? 15 : 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              widget.project.shortDescription.t(context),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: isMobile ? 12 : 13,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: widget.project.techs
                                      .take(2)
                                      .map(
                                        (tech) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.05,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: Colors.white.withValues(
                                                alpha: 0.10,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            tech,
                                            style: TextStyle(
                                              color: Colors.grey[300],
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                padding: EdgeInsets.symmetric(
                                  horizontal: _hovering ? 12 : 8,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF40C4FF).withValues(
                                    alpha: _hovering ? 0.18 : 0.10,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      Tr.k(context, 'projects.view'),
                                      style: const TextStyle(
                                        color: Color(0xFF40C4FF),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    AnimatedSlide(
                                      duration: const Duration(milliseconds: 220),
                                      offset: _hovering
                                          ? const Offset(0.2, 0)
                                          : Offset.zero,
                                      child: const Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 13,
                                        color: Color(0xFF40C4FF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedBadge extends StatelessWidget {
  const _FeaturedBadge();

  @override
  Widget build(BuildContext context) {
    final ar = isArabic(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD700), Color(0xFFFFB800)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withValues(alpha: 0.55),
            blurRadius: 14,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 13, color: Colors.black),
          const SizedBox(width: 5),
          Text(
            ar ? 'مميّز' : 'FEATURED',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverArt extends StatelessWidget {
  final int index;
  final ProjectItem project;
  final bool hovering;

  const _CoverArt({
    required this.index,
    required this.project,
    required this.hovering,
  });

  @override
  Widget build(BuildContext context) {
    return ProjectCover(
      spec: project.cover,
      statusLabel: project.statusLabel,
      statusColor: project.statusColor,
      screenshotCount: project.images.length,
      hovering: hovering,
    );
  }
}

class ProjectLightboxDialog extends StatefulWidget {
  final ProjectItem project;

  const ProjectLightboxDialog({required this.project, super.key});

  @override
  State<ProjectLightboxDialog> createState() => _ProjectLightboxDialogState();
}

class _ProjectLightboxDialogState extends State<ProjectLightboxDialog> {
  late final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  ({IconData icon, String label}) _primaryActionInfo(
    BuildContext context,
    String url,
  ) {
    if (url.contains('play.google.com')) {
      return (
        icon: Icons.shop_outlined,
        label: Tr.k(context, 'projects.playStore'),
      );
    }
    if (url.contains('apps.apple.com')) {
      return (icon: Icons.apple, label: Tr.k(context, 'projects.appStore'));
    }
    return (
      icon: Icons.download_rounded,
      label: Tr.k(context, 'projects.downloadApk'),
    );
  }

  ({IconData icon, String label}) _secondaryActionInfo(
    BuildContext context,
    String url,
  ) {
    if (url.contains('apps.apple.com')) {
      return (icon: Icons.apple, label: Tr.k(context, 'projects.appStore'));
    }
    if (url.contains('play.google.com')) {
      return (
        icon: Icons.shop_outlined,
        label: Tr.k(context, 'projects.playStore'),
      );
    }
    return (icon: Icons.code, label: Tr.k(context, 'projects.viewRepo'));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final dialogMaxWidth = device == DeviceType.desktop
        ? 1100.0
        : device == DeviceType.tablet
            ? 760.0
            : double.infinity;
    final dialogHorizontalMargin = isMobile ? 12.0 : 32.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: dialogHorizontalMargin,
        vertical: isMobile ? 24 : 40,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: dialogMaxWidth),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0E152B), Color(0xFF1A1130)],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 30, spreadRadius: 4),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: isMobile
                ? _mobileLayout(context)
                : _desktopLayout(context),
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 220.ms)
          .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 5, child: _galleryPanel(context, desktop: true)),
          Expanded(flex: 4, child: _detailsPanel(context)),
        ],
      ),
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _galleryPanel(context, desktop: false),
          _detailsPanel(context),
        ],
      ),
    );
  }

  Widget _galleryPanel(BuildContext context, {required bool desktop}) {
    final height = desktop ? 520.0 : 340.0;
    return Container(
      color: Colors.black.withValues(alpha: 0.4),
      child: Column(
        children: [
          SizedBox(
            height: height,
            child: Stack(
              children: [
                CarouselSlider(
                  carouselController: _carouselController,
                  items: widget.project.images.map((img) {
                    return Container(
                      width: double.infinity,
                      color: Colors.black.withValues(alpha: 0.3),
                      child: Image.asset(
                        img,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stack) => const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 56,
                            color: Colors.white24,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: height,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: widget.project.images.length > 1,
                    onPageChanged: (i, _) =>
                        setState(() => _currentIndex = i),
                  ),
                ),
                if (widget.project.images.length > 1) ...[
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _navButton(
                        Icons.chevron_left,
                        () => _carouselController.previousPage(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _navButton(
                        Icons.chevron_right,
                        () => _carouselController.nextPage(),
                      ),
                    ),
                  ),
                ],
                Positioned(
                  top: 12,
                  right: 12,
                  child: _navButton(
                    Icons.close,
                    () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
          if (widget.project.images.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.project.images.asMap().entries.map((entry) {
                  final active = _currentIndex == entry.key;
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: active ? 22 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: active
                            ? const Color(0xFFFFD700)
                            : Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _detailsPanel(BuildContext context) {
    final project = widget.project;
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final ar = isArabic(context);
    final statusText = project.statusLabel.t(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status pill (live / in review / completed)
            if (statusText.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: project.statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: project.statusColor.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: project.statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      statusText,
                      style: TextStyle(
                        color: project.statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 14),
            // Title
            ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                colors: [Colors.white, Color(0xFFB3E5FC)],
              ).createShader(rect),
              child: Text(
                project.title.t(context),
                style: TextStyle(
                  fontSize: isMobile ? 22 : 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.25,
                ),
              ),
            ),
            const SizedBox(height: 22),
            // ──────── CHALLENGE ────────
            _CaseStudyBlock(
              icon: Icons.lightbulb_outline_rounded,
              accent: const Color(0xFFFFD700),
              label: ar ? 'التحدّي' : 'The Challenge',
              child: Text(
                project.shortDescription.t(context),
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: isMobile ? 13 : 14.5,
                  height: 1.65,
                ),
              ),
            ),
            // ──────── SOLUTION / KEY IMPACT ────────
            if (project.impactHighlights.isNotEmpty) ...[
              const SizedBox(height: 18),
              _CaseStudyBlock(
                icon: Icons.check_circle_outline_rounded,
                accent: const Color(0xFF34D399),
                label: ar ? 'الحل و الأثر' : 'Solution & Impact',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: project.impactHighlights.map(
                    (impact) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF34D399),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF34D399)
                                      .withValues(alpha: 0.5),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 11),
                          Expanded(
                            child: Text(
                              impact.t(context),
                              style: TextStyle(
                                color: Colors.grey[200],
                                fontSize: isMobile ? 12.5 : 14,
                                height: 1.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ],
            // ──────── TECH STACK ────────
            const SizedBox(height: 18),
            _CaseStudyBlock(
              icon: Icons.terminal_rounded,
              accent: const Color(0xFF40C4FF),
              label: ar ? 'التقنيات' : 'Tech Stack',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.techs.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF40C4FF).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF40C4FF).withValues(alpha: 0.35),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        color: Color(0xFF40C4FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            Builder(
              builder: (context) {
                final primary = _primaryActionInfo(context, project.apkUrl);
                final secondary =
                    _secondaryActionInfo(context, project.repoUrl);
                return Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => openUrl(project.apkUrl),
                      icon: Icon(primary.icon, size: 16),
                      label: Text(primary.label),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => openUrl(project.repoUrl),
                      icon: Icon(secondary.icon, size: 16),
                      label: Text(secondary.label),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// One section inside the project lightbox — Challenge / Solution / Stack.
/// Visually consistent: small icon + uppercase label header, then content.
class _CaseStudyBlock extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final String label;
  final Widget child;

  const _CaseStudyBlock({
    required this.icon,
    required this.accent,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, size: 14, color: accent),
              ),
              const SizedBox(width: 9),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: accent,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          child,
        ],
      ),
    );
  }
}
