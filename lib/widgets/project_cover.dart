import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/models/project_item.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';

class ProjectCover extends StatelessWidget {
  final ProjectCoverSpec spec;
  final L18n statusLabel;
  final Color statusColor;
  final int screenshotCount;
  final bool hovering;

  const ProjectCover({
    required this.spec,
    required this.statusLabel,
    required this.statusColor,
    required this.screenshotCount,
    this.hovering = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final generated = _GeneratedCover(
            spec: spec,
            statusLabel: statusLabel,
            statusColor: statusColor,
            screenshotCount: screenshotCount,
            hovering: hovering,
            constraints: constraints,
          );

          if (spec.coverImage != null) {
            return _ImageCover(
              imagePath: spec.coverImage!,
              hovering: hovering,
              statusLabel: statusLabel,
              statusColor: statusColor,
              screenshotCount: screenshotCount,
              fallback: generated,
            );
          }
          return generated;
        },
      ),
    );
  }
}

// --------------------- Image cover ---------------------

class _ImageCover extends StatelessWidget {
  final String imagePath;
  final bool hovering;
  final L18n statusLabel;
  final Color statusColor;
  final int screenshotCount;
  final Widget fallback;

  const _ImageCover({
    required this.imagePath,
    required this.hovering,
    required this.statusLabel,
    required this.statusColor,
    required this.screenshotCount,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedScale(
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          scale: hovering ? 1.08 : 1.0,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (context, error, stack) => fallback,
          ),
        ),
        // Bottom legibility gradient
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 90,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    // ignore: deprecated_member_use
                    Colors.black.withOpacity(0.70),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Footer overlay
        Positioned(
          left: 14,
          right: 14,
          bottom: 12,
          child: _FooterRow(
            statusLabel: statusLabel,
            statusColor: statusColor,
            screenshotCount: screenshotCount,
          ),
        ),
      ],
    );
  }
}

// --------------------- Generated cover ---------------------

class _GeneratedCover extends StatelessWidget {
  final ProjectCoverSpec spec;
  final L18n statusLabel;
  final Color statusColor;
  final int screenshotCount;
  final bool hovering;
  final BoxConstraints constraints;

  const _GeneratedCover({
    required this.spec,
    required this.statusLabel,
    required this.statusColor,
    required this.screenshotCount,
    required this.hovering,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final width = constraints.maxWidth;
    final isNarrow = width < 280;

    final logoSize = isNarrow ? 44.0 : 52.0;
    final appNameSize = isNarrow ? 18.0 : 22.0;
    final subtitleSize = isNarrow ? 11.0 : 12.5;
    final featureIconSize = isNarrow ? 14.0 : 16.0;
    final featureLabelSize = isNarrow ? 9.5 : 11.0;

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: spec.gradient,
            ),
          ),
        ),
        _CornerGlow(alignment: Alignment.topRight, color: spec.accent),
        _CornerGlow(
          alignment: Alignment.bottomLeft,
          color: spec.accent,
          opacity: 0.16,
        ),
        const Positioned.fill(child: _DotPattern()),
        Positioned(
          top: -30,
          right: -30,
          child: _RingDecor(size: 140, color: spec.accent, opacity: 0.10),
        ),
        Positioned(
          bottom: -25,
          left: -25,
          child: _RingDecor(size: 110, color: spec.accent, opacity: 0.08),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? 14 : 18,
            vertical: isNarrow ? 14 : 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                logoText: spec.logoText,
                logoSize: logoSize,
                accent: spec.accent,
                appName: spec.appName,
                appNameSize: appNameSize,
                subtitle: spec.subtitle,
                subtitleSize: subtitleSize,
                hovering: hovering,
              ),
              const Spacer(),
              _FeatureGrid(
                features: spec.features,
                iconSize: featureIconSize,
                labelSize: featureLabelSize,
              ),
              const SizedBox(height: 10),
              _FooterRow(
                statusLabel: statusLabel,
                statusColor: statusColor,
                screenshotCount: screenshotCount,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String logoText;
  final double logoSize;
  final Color accent;
  final L18n appName;
  final double appNameSize;
  final L18n subtitle;
  final double subtitleSize;
  final bool hovering;

  const _Header({
    required this.logoText,
    required this.logoSize,
    required this.accent,
    required this.appName,
    required this.appNameSize,
    required this.subtitle,
    required this.subtitleSize,
    required this.hovering,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedScale(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          scale: hovering ? 1.05 : 1.0,
          child: _LogoMark(text: logoText, size: logoSize, accent: accent),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appName.t(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: appNameSize,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                  height: 1.1,
                  shadows: const [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.black38,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle.t(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.82),
                  fontSize: subtitleSize,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LogoMark extends StatelessWidget {
  final String text;
  final double size;
  final Color accent;

  const _LogoMark({
    required this.text,
    required this.size,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = text.length <= 2 ? size * 0.42 : size * 0.32;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            // ignore: deprecated_member_use
            Colors.white.withOpacity(0.88),
          ],
        ),
        border: Border.all(
          // ignore: deprecated_member_use
          color: accent.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: accent.withOpacity(0.45),
            blurRadius: 18,
            spreadRadius: 0,
          ),
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: ShaderMask(
        shaderCallback: (rect) => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HSLColor.fromColor(accent)
                .withLightness(
                  (HSLColor.fromColor(accent).lightness - 0.15).clamp(0.0, 1.0),
                )
                .toColor(),
            accent,
          ],
        ).createShader(rect),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  final List<ProjectFeature> features;
  final double iconSize;
  final double labelSize;

  const _FeatureGrid({
    required this.features,
    required this.iconSize,
    required this.labelSize,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: features.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.12),
            border: Border.all(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.22),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(feature.icon, color: Colors.white, size: iconSize),
              const SizedBox(width: 5),
              Text(
                feature.label.t(context),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: labelSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _FooterRow extends StatelessWidget {
  final L18n statusLabel;
  final Color statusColor;
  final int screenshotCount;

  const _FooterRow({
    required this.statusLabel,
    required this.statusColor,
    required this.screenshotCount,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedStatus = statusLabel.t(context);
    return Row(
      children: [
        if (resolvedStatus.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withValues(alpha: 0.45),
              border: Border.all(
                color: statusColor.withValues(alpha: 0.7),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withValues(alpha: 0.6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  resolvedStatus,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        const Spacer(),
        if (screenshotCount > 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.45),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.photo_library_outlined,
                  size: 11,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  '$screenshotCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CornerGlow extends StatelessWidget {
  final Alignment alignment;
  final Color color;
  final double opacity;

  const _CornerGlow({
    required this.alignment,
    required this.color,
    this.opacity = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              // ignore: deprecated_member_use
              color.withOpacity(opacity),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class _RingDecor extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const _RingDecor({
    required this.size,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          // ignore: deprecated_member_use
          color: Colors.white.withOpacity(opacity),
          width: 1.2,
        ),
      ),
    );
  }
}

class _DotPattern extends StatelessWidget {
  const _DotPattern();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DotPatternPainter());
  }
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // ignore: deprecated_member_use
      ..color = Colors.white.withOpacity(0.06);
    const spacing = 20.0;
    const radius = 1.0;
    for (double y = spacing / 2; y < size.height; y += spacing) {
      for (double x = spacing / 2; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Suppress unused warning — `color` field is used directly via the constructor
// in `_GeneratedCover._RingDecor` etc.
// (kept for clarity)
