import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final IconData? icon;

  const SectionHeader({
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final palette = AppPalette.of(context);
    final titleGradient = palette.isLight
        ? const [Color(0xFF0F172A), Color(0xFF1E40AF)]
        : const [Colors.white, Color(0xFFB3E5FC)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: isMobile ? 22 : 26,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFD700),
                    Color(0xFF40C4FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              eyebrow.toUpperCase(),
              style: TextStyle(
                color: const Color(0xFFFFD700),
                fontSize: isMobile ? 11 : 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: -0.15, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.lightBlueAccent, size: isMobile ? 24 : 28),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: ShaderMask(
                shaderCallback: (rect) => LinearGradient(
                  colors: titleGradient,
                ).createShader(rect),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isMobile ? 26 : 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.15,
                  ),
                ),
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .slideY(begin: 0.15, end: 0, curve: Curves.easeOut),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: TextStyle(
              color: palette.textMuted,
              fontSize: isMobile ? 13 : 15,
              height: 1.5,
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideY(begin: 0.15, end: 0, curve: Curves.easeOut),
        ],
        const SizedBox(height: 18),
      ],
    );
  }
}
