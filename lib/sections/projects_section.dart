import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/data/projects_data.dart';
import 'package:mostafa_badr_portfolio/models/project_item.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/widgets/common/tag_chip.dart';
import 'package:mostafa_badr_portfolio/widgets/project_cover.dart';
import 'package:mostafa_badr_portfolio/widgets/project_lightbox.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  ProjectCategory? _activeFilter;

  List<ProjectItem> get _visible {
    final filter = _activeFilter;
    if (filter == null) return projectsData;
    return projectsData
        .where((p) => p.categories.contains(filter))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: AppSizes.lg),
        if (visible.isEmpty)
          const _EmptyState()
        else
          _ProjectGrid(
            projects: visible,
            filterKey: _activeFilter?.name ?? 'all',
          ),
      ],
    );
  }
}

class _ProjectGrid extends StatelessWidget {
  final List<ProjectItem> projects;
  final String filterKey;

  const _ProjectGrid({required this.projects, required this.filterKey});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, constraints, device) {
        final columns = device == DeviceType.mobile ? 1 : 2;

        // Aspect ratio is derived from the real cell width rather than picked
        // per device class. A card needs a roughly fixed body height (title,
        // two lines of copy, a tag row); expressing that as a ratio keeps the
        // cover proportional at any width instead of squashing it on the
        // in-between sizes a fixed ratio never accounted for.
        final spacing = AppSizes.headerGap;
        final available = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : context.screenWidth;
        final cellWidth = (available - spacing * (columns - 1)) / columns;
        final bodyHeight = device == DeviceType.mobile ? 140.0 : 156.0;
        final coverHeight = cellWidth * 0.62;
        final ratio = cellWidth / (coverHeight + bodyHeight);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: ratio,
          ),
          itemBuilder: (context, index) {
            return ProjectCard(
              project: projects[index],
              key: ValueKey('$filterKey-${projects[index].title.en}'),
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
        );
      },
    );
  }
}

/// Shown when a filter matches nothing. A blank gap reads as a broken page;
/// this says what happened and what to do about it.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.xl,
        vertical: 44,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.filter_alt_off_outlined,
            size: 34,
            color: Colors.white.withValues(alpha: 0.35),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            Tr.k(context, 'projects.empty'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSizes.xs + 2),
          Text(
            Tr.k(context, 'projects.emptyHint'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilterRow extends StatelessWidget {
  final ProjectCategory? active;
  final ValueChanged<ProjectCategory?> onChange;

  const _CategoryFilterRow({required this.active, required this.onChange});

  @override
  Widget build(BuildContext context) {
    const categories = <ProjectCategory?>[null, ...ProjectCategory.values];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // Lets a touch drag the strip on mobile, where there is no scroll wheel
      // and the chips reliably overflow one screen.
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (final category in categories)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: AppSizes.sm),
              child: _FilterChip(
                category: category,
                isActive: active == category,
                onTap: () => onChange(category),
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final ProjectCategory? category;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.category,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cat = category;
    final label = cat == null
        ? Tr.k(context, 'projects.filter.all')
        : Tr.k(context, cat.labelKey);
    final count = cat == null
        ? projectsData.length
        : projectsData.where((p) => p.categories.contains(cat)).length;

    return AnimatedContainer(
      duration: AppDurations.quick,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        gradient: isActive
            ? const LinearGradient(colors: AppColors.brandSweep)
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
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: AppSizes.sm,
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
                const SizedBox(width: AppSizes.xs + 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.xs + 2,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.black.withValues(alpha: 0.20)
                        : Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
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
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectItem project;

  const ProjectCard({required this.project, super.key});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovering = false;
  Offset _localPointer = Offset.zero;
  Size _cardSize = Size.zero;

  void _open() {
    showDialog<void>(
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

  /// Maps cursor position to a small 3D tilt (max ~5°). Falls back to a plain
  /// lift when the pointer position is unknown or tilt is disabled.
  Matrix4 _tiltTransform(bool enabled) {
    if (!enabled ||
        !_hovering ||
        _cardSize.width == 0 ||
        _cardSize.height == 0) {
      return Matrix4.identity()
        ..translateByDouble(0.0, _hovering ? -6.0 : 0.0, 0.0, 1.0);
    }
    final dx = (_localPointer.dx / _cardSize.width) - 0.5;
    final dy = (_localPointer.dy / _cardSize.height) - 0.5;
    return Matrix4.identity()
      ..setEntry(3, 2, 0.0012) // perspective
      ..rotateX(-dy * 0.08)
      ..rotateY(dx * 0.08)
      ..translateByDouble(0.0, -6.0, 0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    // Pointer tilt is meaningless without a pointer, and the extra rebuilds
    // are wasted work on a phone.
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
        child: Semantics(
          button: true,
          label: widget.project.title.t(context),
          child: AnimatedContainer(
            duration: AppDurations.fast,
            curve: Curves.easeOut,
            transformAlignment: Alignment.center,
            transform: _tiltTransform(tiltEnabled),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
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
                    ? AppColors.cyan.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.08),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: _hovering ? 22 : 12,
                  offset: const Offset(0, 6),
                ),
                if (_hovering)
                  BoxShadow(
                    color: AppColors.cyan.withValues(alpha: 0.18),
                    blurRadius: 28,
                    spreadRadius: 1,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ProjectCover(
                              spec: widget.project.cover,
                              statusLabel: widget.project.statusLabel,
                              statusColor: widget.project.statusColor,
                              screenshotCount: widget.project.images.length,
                              hovering: _hovering,
                            ),
                          ),
                          if (widget.project.featured)
                            const PositionedDirectional(
                              top: AppSizes.md,
                              start: AppSizes.md,
                              child: _FeaturedBadge(),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: _CardBody(
                        project: widget.project,
                        hovering: _hovering,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final ProjectItem project;
  final bool hovering;
  final bool isMobile;

  const _CardBody({
    required this.project,
    required this.hovering,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 14 : AppSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title.t(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isMobile ? 15 : 17,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: AppSizes.xs + 2),
          Expanded(
            child: Text(
              project.shortDescription.t(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: isMobile ? 12 : 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.md - 2),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: AppSizes.xs + 2,
                  runSpacing: AppSizes.xs + 2,
                  // One line of tags only — a second run would push the "View"
                  // affordance out of the fixed-height card body.
                  children: [
                    for (final tech in project.techs.take(2))
                      TagChip(
                        label: tech,
                        accent: Colors.grey.shade300,
                        size: TagChipSize.tiny,
                        muted: true,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              _ViewAffordance(hovering: hovering),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewAffordance extends StatelessWidget {
  final bool hovering;
  const _ViewAffordance({required this.hovering});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDurations.quick,
      padding: EdgeInsets.symmetric(
        horizontal: hovering ? AppSizes.md : AppSizes.sm,
        vertical: AppSizes.xs + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.cyan.withValues(alpha: hovering ? 0.18 : 0.10),
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Tr.k(context, 'projects.view'),
            style: const TextStyle(
              color: AppColors.cyan,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: AppSizes.xs),
          AnimatedSlide(
            duration: AppDurations.quick,
            offset: hovering ? const Offset(0.2, 0) : Offset.zero,
            child: const Icon(
              Icons.arrow_forward_rounded,
              size: 13,
              color: AppColors.cyan,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedBadge extends StatelessWidget {
  const _FeaturedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md - 2,
        vertical: AppSizes.xs + 1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gold, AppColors.goldDeep],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.55),
            blurRadius: 14,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 13, color: Colors.black),
          const SizedBox(width: AppSizes.xs + 1),
          Text(
            Tr.k(context, 'projects.featured'),
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
