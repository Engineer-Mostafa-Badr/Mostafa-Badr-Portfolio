import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/contact_links.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';

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
    final context = targetKey.currentContext;
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // Decide layout from the actual available width, not the screen width.
        // Full nav needs: name(~140) + 6 items(~500) + spacer + toggles(140)
        // + CTA(130) + paddings ≈ ~1050px when everything is uncompressed.
        // Below that, fall back to the compact (menu-drawer) layout.
        final isCompact = width < 1050;
        final isUltraCompact = width < 520;
        final nameFontSize = isCompact ? 18.0 : 20.0;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isUltraCompact ? 14 : 22,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
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
                child: ShaderMask(
                  shaderCallback: (rect) => const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFF40C4FF)],
                  ).createShader(rect),
                  child: Text(
                    isArabic(context) ? 'مصطفى بدر' : 'Mostafa Badr',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: nameFontSize,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Spacer(),
              if (!isCompact) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.sectionTargets.map((target) {
                    final hovering = _hoveredLabel == target.labelKey;
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) =>
                          setState(() => _hoveredLabel = target.labelKey),
                      onExit: (_) => setState(() => _hoveredLabel = null),
                      child: GestureDetector(
                        onTap: () => _scrollToSection(target.key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: hovering
                                ? AppPalette.accentCyan
                                    .withValues(alpha: 0.12)
                                : Colors.transparent,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                Tr.k(context, target.labelKey),
                                style: TextStyle(
                                  color: hovering
                                      ? AppPalette.accentCyan
                                      : palette.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 3),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                height: 2,
                                width: hovering ? 22 : 0,
                                decoration: BoxDecoration(
                                  color: AppPalette.accentCyan,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8),
                const _LocaleToggleButton(),
                const SizedBox(width: 6),
                const _ThemeToggleButton(),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () =>
                      openUrl(hireMeLink(arabic: isArabic(context))),
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
                  label: Text(Tr.k(context, 'nav.hireMe')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
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
              ] else ...[
                const _LocaleToggleButton(),
                const SizedBox(width: 6),
                const _ThemeToggleButton(),
                const SizedBox(width: 6),
                _MobileNavButton(targets: widget.sectionTargets),
              ],
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0);
      },
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
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: palette.pillBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: palette.pillBorder),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 240),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isLight
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              key: ValueKey(isLight),
              size: 18,
              color: isLight
                  ? AppPalette.accentPurple
                  : AppPalette.accentGold,
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
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          decoration: BoxDecoration(
            color: palette.pillBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: palette.pillBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                size: 14,
                color: AppPalette.accentCyan,
              ),
              const SizedBox(width: 6),
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
    final palette = AppPalette.of(context);
    final selected = await showModalBottomSheet<SectionTarget>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _MobileNavSheet(targets: targets, palette: palette);
      },
    );
    if (selected != null) {
      final target = selected.key.currentContext;
      if (target != null && target.mounted) {
        await Scrollable.ensureVisible(
          target,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
          alignment: 0.05,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Tooltip(
      message: isArabic(context) ? 'القائمة' : 'Menu',
      child: InkWell(
        onTap: () => _openMenu(context),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: palette.pillBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: palette.pillBorder),
          ),
          child: const Icon(
            Icons.menu_rounded,
            size: 18,
            color: AppPalette.accentCyan,
          ),
        ),
      ),
    );
  }
}

class _MobileNavSheet extends StatelessWidget {
  final List<SectionTarget> targets;
  final AppPalette palette;
  const _MobileNavSheet({required this.targets, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0E152B), Color(0xFF1A1130)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        border: Border.all(color: palette.cardBorder),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
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
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              colors: [Color(0xFFFFD700), Color(0xFF40C4FF)],
            ).createShader(rect),
            child: Text(
              isArabic(context) ? 'الانتقال إلى' : 'Jump to',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...targets.map(
            (target) => _MobileNavRow(
              target: target,
              onTap: () => Navigator.of(context).pop(target),
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              openUrl(hireMeLink(arabic: isArabic(context)));
            },
            icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
            label: Text(Tr.k(context, 'nav.hireMe')),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
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
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppPalette.accentCyan.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 16, color: AppPalette.accentCyan),
                ),
                const SizedBox(width: 12),
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
