import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_links.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/models/project_item.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/widgets/common/app_button.dart';
import 'package:mostafa_badr_portfolio/widgets/common/bullet_list.dart';
import 'package:mostafa_badr_portfolio/widgets/common/gradient_text.dart';
import 'package:mostafa_badr_portfolio/widgets/common/safe_asset_image.dart';
import 'package:mostafa_badr_portfolio/widgets/common/status_pill.dart';
import 'package:mostafa_badr_portfolio/widgets/common/tag_chip.dart';

/// Full case-study view for one project: screenshot gallery on one side,
/// challenge / impact / stack and the store links on the other.
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

  @override
  Widget build(BuildContext context) {
    final device = context.deviceType;
    final isMobile = device == DeviceType.mobile;
    final dialogMaxWidth = context.responsive(
      mobile: double.infinity,
      tablet: AppSizes.dialogMaxWidthTablet,
      desktop: AppSizes.dialogMaxWidthDesktop,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSizes.md : AppSizes.xxxl,
        vertical: isMobile ? AppSizes.xxl : 40,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: dialogMaxWidth),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.modalSurface,
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
            child: isMobile
                ? _MobileLayout(
                    gallery: _buildGallery(context, desktop: false),
                    details: _buildDetails(context),
                  )
                : _DesktopLayout(
                    gallery: _buildGallery(context, desktop: true),
                    details: _buildDetails(context),
                  ),
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 220.ms)
          .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
    );
  }

  Widget _buildGallery(BuildContext context, {required bool desktop}) {
    return _GalleryPanel(
      images: widget.project.images,
      controller: _carouselController,
      currentIndex: _currentIndex,
      onPageChanged: (i) => setState(() => _currentIndex = i),
      onClose: () => Navigator.of(context).pop(),
      desktop: desktop,
    );
  }

  Widget _buildDetails(BuildContext context) =>
      _DetailsPanel(project: widget.project);
}

/// Side-by-side on desktop and tablet.
///
/// The previous version wrapped this row in an `IntrinsicHeight`, which sizes
/// to the *unscrolled* height of the details column. A project with six impact
/// bullets therefore forced the dialog taller than the window and overflowed.
/// Capping the height and letting each pane scroll independently fixes it at
/// every window size.
class _DesktopLayout extends StatelessWidget {
  final Widget gallery;
  final Widget details;

  const _DesktopLayout({required this.gallery, required this.details});

  @override
  Widget build(BuildContext context) {
    final maxHeight = context.heightFraction(0.86, min: 360, max: 900);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 5, child: gallery),
          Expanded(flex: 4, child: details),
        ],
      ),
    );
  }
}

/// Stacked and scrolled as one column on phones.
class _MobileLayout extends StatelessWidget {
  final Widget gallery;
  final Widget details;

  const _MobileLayout({required this.gallery, required this.details});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [gallery, details],
      ),
    );
  }
}

class _GalleryPanel extends StatelessWidget {
  final List<String> images;
  final CarouselSliderController controller;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onClose;
  final bool desktop;

  const _GalleryPanel({
    required this.images,
    required this.controller,
    required this.currentIndex,
    required this.onPageChanged,
    required this.onClose,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final hasMultiple = images.length > 1;

    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // On desktop the panel fills the dialog's capped height; on mobile it
          // gets a proportional slice of the viewport. Either way the value is
          // bounded, so the carousel can never demand more room than exists.
          final dotStripHeight = hasMultiple ? 35.0 : 0.0;
          final height = desktop && constraints.hasBoundedHeight
              ? (constraints.maxHeight - dotStripHeight).clamp(200.0, 900.0)
              : context.heightFraction(0.42, min: 220, max: 420);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height,
                child: Stack(
                  children: [
                    CarouselSlider(
                      carouselController: controller,
                      items: [
                        for (final image in images)
                          ColoredBox(
                            color: Colors.black.withValues(alpha: 0.3),
                            child: SizedBox(
                              width: double.infinity,
                              child: SafeAssetImage(
                                path: image,
                                fit: BoxFit.contain,
                                displayWidth: constraints.maxWidth,
                              ),
                            ),
                          ),
                      ],
                      options: CarouselOptions(
                        height: height,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: hasMultiple,
                        onPageChanged: (i, _) => onPageChanged(i),
                      ),
                    ),
                    if (hasMultiple) ...[
                      PositionedDirectional(
                        start: AppSizes.sm,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: _NavButton(
                            icon: Icons.chevron_left,
                            tooltip: Tr.k(context, 'projects.previousImage'),
                            onTap: controller.previousPage,
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        end: AppSizes.sm,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: _NavButton(
                            icon: Icons.chevron_right,
                            tooltip: Tr.k(context, 'projects.nextImage'),
                            onTap: controller.nextPage,
                          ),
                        ),
                      ),
                    ],
                    PositionedDirectional(
                      top: AppSizes.md,
                      end: AppSizes.md,
                      child: _NavButton(
                        icon: Icons.close,
                        tooltip: Tr.k(context, 'common.close'),
                        onTap: onClose,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasMultiple)
                _PageDots(
                  count: images.length,
                  activeIndex: currentIndex,
                  onTap: controller.animateToPage,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  final int count;
  final int activeIndex;
  final ValueChanged<int> onTap;

  const _PageDots({
    required this.count,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          final active = index == activeIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: AppDurations.quick,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 22 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: active
                    ? AppColors.gold
                    : Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(AppSizes.xs),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(AppSizes.radiusPill),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }
}

class _DetailsPanel extends StatelessWidget {
  final ProjectItem project;

  const _DetailsPanel({required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final statusText = project.statusLabel.t(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? AppSizes.xl : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (statusText.isNotEmpty)
              StatusPill(label: statusText, color: project.statusColor),
            const SizedBox(height: 14),
            GradientText.titleSheen(
              project.title.t(context),
              style: TextStyle(
                fontSize: isMobile ? 22 : 26,
                fontWeight: FontWeight.w800,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 22),
            _CaseStudyBlock(
              icon: Icons.lightbulb_outline_rounded,
              accent: AppColors.gold,
              label: Tr.k(context, 'projects.challenge'),
              child: Text(
                project.shortDescription.t(context),
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: isMobile ? 13 : 14.5,
                  height: 1.65,
                ),
              ),
            ),
            if (project.impactHighlights.isNotEmpty) ...[
              const SizedBox(height: AppSizes.headerGap),
              _CaseStudyBlock(
                icon: Icons.check_circle_outline_rounded,
                accent: AppColors.success,
                label: Tr.k(context, 'projects.solution'),
                child: BulletList(
                  items: [
                    for (final impact in project.impactHighlights)
                      impact.t(context),
                  ],
                  accent: AppColors.success,
                  fontSize: isMobile ? 12.5 : 14,
                  // The dialog's own entrance already animates this content in;
                  // a second stagger on top just delays the read.
                  animate: false,
                ),
              ),
            ],
            const SizedBox(height: AppSizes.headerGap),
            _CaseStudyBlock(
              icon: Icons.terminal_rounded,
              accent: AppColors.cyan,
              label: Tr.k(context, 'projects.techStack'),
              child: Wrap(
                spacing: AppSizes.sm,
                runSpacing: AppSizes.sm,
                children: [
                  for (final tech in project.techs)
                    TagChip(
                      label: tech,
                      accent: AppColors.cyan,
                      size: TagChipSize.medium,
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.xxl),
            _ProjectActions(project: project),
          ],
        ),
      ),
    );
  }
}

/// Store / site links for a project.
///
/// The buttons are derived from the URLs themselves via [ProjectLinkKindX], so
/// adding a link to `projects_data.dart` gets the right icon and label with no
/// UI change — and the previous hand-rolled `url.contains(...)` ladders that
/// had drifted apart between the primary and secondary slots are gone.
class _ProjectActions extends StatelessWidget {
  final ProjectItem project;

  const _ProjectActions({required this.project});

  @override
  Widget build(BuildContext context) {
    final links = <({String url, AppButtonVariant variant})>[
      (url: project.apkUrl, variant: AppButtonVariant.primary),
      (url: project.repoUrl, variant: AppButtonVariant.secondary),
      if (project.websiteUrl != null)
        (url: project.websiteUrl!, variant: AppButtonVariant.secondary),
    ];

    return Wrap(
      spacing: AppSizes.md - 2,
      runSpacing: AppSizes.sm,
      children: [
        for (final link in links)
          _ProjectLinkButton(url: link.url, variant: link.variant),
      ],
    );
  }
}

class _ProjectLinkButton extends StatelessWidget {
  final String url;
  final AppButtonVariant variant;

  const _ProjectLinkButton({required this.url, required this.variant});

  static const _icons = {
    ProjectLinkKind.playStore: Icons.shop_outlined,
    ProjectLinkKind.appStore: Icons.apple,
    ProjectLinkKind.website: Icons.language_rounded,
    ProjectLinkKind.repository: Icons.code,
    ProjectLinkKind.apkDownload: Icons.download_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final kind = ProjectLinkKindX.fromUrl(url);
    return AppButton(
      label: Tr.k(context, kind.labelKey),
      icon: _icons[kind],
      variant: variant,
      onPressed: () => openUrl(url, context: context),
    );
  }
}

/// One titled block inside the lightbox — Challenge / Solution / Stack.
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 15, color: accent),
            const SizedBox(width: AppSizes.sm - 1),
            Flexible(
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.md - 2),
        child,
      ],
    );
  }
}
