import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/contact_links.dart';
import 'package:mostafa_badr_portfolio/widgets/common/app_button.dart';
import 'package:mostafa_badr_portfolio/widgets/common/gradient_text.dart';

class SectionTarget {
  final String labelKey;
  final GlobalKey key;

  const SectionTarget({required this.labelKey, required this.key});
}

class TopBar extends StatefulWidget {
  final List<SectionTarget> sectionTargets;

  const TopBar({super.key, required this.sectionTargets});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String? _hoveredLabel;

  Future<void> _scrollToSection(GlobalKey targetKey) async {
    final ctx = targetKey.currentContext;
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
    final palette = AppPalette.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Decided from the actual available width, not the window: the bar
        // sits inside the page gutter, so the window would over-report room.
        // Full nav needs name(~140) + 6 items(~500) + toggles(140) + CTA(130)
        // + padding ≈ 1050px uncompressed.
        final width = constraints.maxWidth;
        final isCompact = width < AppBreakpoints.topBarFullNav;
        final isUltraCompact = width < AppBreakpoints.topBarTightPadding;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isUltraCompact ? 14 : 22,
            vertical: AppSizes.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusXl - 2),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: palette.cardGradient,
            ),
            border: Border.all(color: palette.cardBorder),
          ),
          child: Row(
            children: [
              Flexible(
                child: GradientText(
                  Tr.k(context, 'hero.name'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isCompact ? 18 : 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              const Spacer(),
              if (!isCompact) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final target in widget.sectionTargets)
                      _NavItem(
                        labelKey: target.labelKey,
                        hovering: _hoveredLabel == target.labelKey,
                        onHoverChanged: (hovering) => setState(
                          () => _hoveredLabel =
                              hovering ? target.labelKey : null,
                        ),
                        onTap: () => _scrollToSection(target.key),
                      ),
                  ],
                ),
                const SizedBox(width: AppSizes.sm),
                const _LocaleToggleButton(),
                const SizedBox(width: AppSizes.xs + 2),
                const _ThemeToggleButton(),
                const SizedBox(width: AppSizes.md - 2),
                AppButton(
                  label: Tr.k(context, 'nav.hireMe'),
                  icon: Icons.chat_bubble_outline_rounded,
                  size: AppButtonSize.small,
                  onPressed: () => openUrl(
                    hireMeLink(arabic: isArabic(context)),
                    context: context,
                  ),
                ),
              ] else ...[
                const _LocaleToggleButton(),
                const SizedBox(width: AppSizes.xs + 2),
                const _ThemeToggleButton(),
                const SizedBox(width: AppSizes.xs + 2),
                _MobileNavButton(targets: widget.sectionTargets),
              ],
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0);
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String labelKey;
  final bool hovering;
  final ValueChanged<bool> onHoverChanged;
  final VoidCallback onTap;

  const _NavItem({
    required this.labelKey,
    required this.hovering,
    required this.onHoverChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md - 2,
            vertical: AppSizes.sm,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            color: hovering
                ? AppColors.cyan.withValues(alpha: 0.12)
                : Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Tr.k(context, labelKey),
                style: TextStyle(
                  color: hovering ? AppColors.cyan : palette.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: AppDurations.quick,
                height: 2,
                width: hovering ? 22 : 0,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final isLight = palette.isLight;

    return Tooltip(
      message: Tr.k(context, isLight ? 'theme.toDark' : 'theme.toLight'),
      child: InkWell(
        onTap: AppThemeController.toggle,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: AnimatedContainer(
          duration: AppDurations.quick,
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: palette.pillBackground,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(color: palette.pillBorder),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 240),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isLight ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              key: ValueKey(isLight),
              size: 18,
              color: isLight ? AppColors.purple : AppColors.gold,
            ),
          ),
        ),
      ),
    );
  }
}

class _LocaleToggleButton extends StatelessWidget {
  const _LocaleToggleButton();

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final isAr = isArabic(context);

    return Tooltip(
      message: Tr.k(context, isAr ? 'locale.toEn' : 'locale.toAr'),
      child: InkWell(
        onTap: AppLocaleController.toggle,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: AnimatedContainer(
          duration: AppDurations.quick,
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          decoration: BoxDecoration(
            color: palette.pillBackground,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: Border.all(color: palette.pillBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.language, size: 14, color: AppColors.cyan),
              const SizedBox(width: AppSizes.xs + 2),
              Text(
                isAr ? 'EN' : 'AR',
                style: TextStyle(
                  color: palette.textSecondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavButton extends StatelessWidget {
  final List<SectionTarget> targets;
  const _MobileNavButton({required this.targets});

  Future<void> _openMenu(BuildContext context) async {
    final selected = await showModalBottomSheet<SectionTarget>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MobileNavSheet(targets: targets),
    );
    if (selected == null) return;

    final ctx = selected.key.currentContext;
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
    final palette = AppPalette.of(context);

    return Tooltip(
      message: Tr.k(context, 'common.menu'),
      child: Semantics(
        button: true,
        label: Tr.k(context, 'common.menu'),
        child: InkWell(
          onTap: () => _openMenu(context),
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          child: Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: palette.pillBackground,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              border: Border.all(color: palette.pillBorder),
            ),
            child: const Icon(
              Icons.menu_rounded,
              size: 18,
              color: AppColors.cyan,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavSheet extends StatelessWidget {
  final List<SectionTarget> targets;
  const _MobileNavSheet({required this.targets});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.modalSurface,
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(22),
          ),
          border: Border.all(color: palette.cardBorder),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppSizes.xl,
          14,
          AppSizes.xl,
          28,
        ),
        // Scrolls if the sheet ever outgrows a short screen (landscape phone,
        // or a keyboard-shrunk viewport).
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              GradientText(
                Tr.k(context, 'nav.jumpTo'),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 14),
              for (final target in targets)
                _MobileNavRow(
                  target: target,
                  onTap: () => Navigator.of(context).pop(target),
                ),
              const SizedBox(height: 14),
              AppButton(
                label: Tr.k(context, 'nav.hireMe'),
                icon: Icons.chat_bubble_outline_rounded,
                expand: true,
                onPressed: () {
                  final navigator = Navigator.of(context);
                  final url = hireMeLink(arabic: isArabic(context));
                  navigator.pop();
                  openUrl(url, context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavRow extends StatelessWidget {
  final SectionTarget target;
  final VoidCallback onTap;

  const _MobileNavRow({required this.target, required this.onTap});

  static const Map<String, IconData> _iconForKey = {
    'nav.home': Icons.home_outlined,
    'nav.about': Icons.person_outline,
    'nav.skills': Icons.build_circle_outlined,
    'nav.experience': Icons.work_outline,
    'nav.projects': Icons.rocket_launch_outlined,
    'nav.contact': Icons.send_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final icon = _iconForKey[target.labelKey] ?? Icons.chevron_right;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Material(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: AppSizes.md,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.cyan.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: Icon(icon, size: 16, color: AppColors.cyan),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Text(
                    Tr.k(context, target.labelKey),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
