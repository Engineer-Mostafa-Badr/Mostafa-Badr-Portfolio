import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool hoverable;
  final double elevation;

  const GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius = 18,
    this.hoverable = false,
    this.elevation = 8,
    super.key,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final lift = widget.hoverable && _hovering ? -4.0 : 0.0;
    final glowOpacity = widget.hoverable && _hovering ? 0.18 : 0.0;

    return MouseRegion(
      cursor: widget.hoverable
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: widget.hoverable ? (_) => setState(() => _hovering = true) : null,
      onExit: widget.hoverable ? (_) => setState(() => _hovering = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, lift, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: palette.cardGradient,
          ),
          border: Border.all(
            color: _hovering ? palette.cardBorderStrong : palette.cardBorder,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: palette.shadow,
              blurRadius: widget.elevation + (_hovering ? 6 : 0),
              offset: Offset(0, widget.elevation / 2),
            ),
            if (glowOpacity > 0)
              BoxShadow(
                color:
                    AppPalette.accentCyan.withValues(alpha: glowOpacity),
                blurRadius: 24,
                spreadRadius: 1,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            color: palette.cardSurface,
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
