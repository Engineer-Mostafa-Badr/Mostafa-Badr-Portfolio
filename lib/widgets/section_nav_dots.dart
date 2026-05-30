import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/widgets/top_bar.dart';

/// Apple/Stripe-style vertical section indicator pinned to the right edge.
///
/// Shows one dot per [SectionTarget]; the active dot grows and accents.
/// Tapping a dot scrolls smoothly to its section. Hidden on small screens
/// to avoid covering the content.
class SectionNavDots extends StatefulWidget {
  final List<SectionTarget> targets;
  final ScrollController scrollController;

  const SectionNavDots({
    super.key,
    required this.targets,
    required this.scrollController,
  });

  @override
  State<SectionNavDots> createState() => _SectionNavDotsState();
}

class _SectionNavDotsState extends State<SectionNavDots> {
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    // Find which section's top is closest to the upper third of the viewport.
    final viewportTop = MediaQuery.of(context).size.height * 0.32;
    int closest = 0;
    double closestDistance = double.infinity;

    for (var i = 0; i < widget.targets.length; i++) {
      final ctx = widget.targets[i].key.currentContext;
      if (ctx == null) continue;
      final renderBox = ctx.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) continue;
      final offset = renderBox.localToGlobal(Offset.zero);
      final distance = (offset.dy - viewportTop).abs();
      if (distance < closestDistance) {
        closestDistance = distance;
        closest = i;
      }
    }

    if (closest != _activeIndex && mounted) {
      setState(() => _activeIndex = closest);
    }
  }

  Future<void> _scrollTo(SectionTarget target) async {
    final ctx = target.key.currentContext;
    if (ctx == null || !ctx.mounted) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Hide on smaller screens — the mobile drawer covers nav already, and
    // the dots would crowd the content.
    if (width < 1100) return const SizedBox.shrink();

    final palette = AppPalette.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(widget.targets.length, (i) {
          final isActive = i == _activeIndex;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: isActive ? 9 : 7),
            child: Tooltip(
              message: Tr.k(context, widget.targets[i].labelKey),
              preferBelow: false,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _scrollTo(widget.targets[i]),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOut,
                    width: isActive ? 10 : 8,
                    height: isActive ? 26 : 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: isActive
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFFFD700),
                                Color(0xFF40C4FF),
                              ],
                            )
                          : null,
                      color: isActive ? null : palette.textFaint,
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: const Color(0xFF40C4FF)
                                    .withValues(alpha: 0.5),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
