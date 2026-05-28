import 'dart:math' as math;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';
import 'package:mostafa_badr_portfolio/widgets/stat_counter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

const _technologyBadges = [
  L18n('Android', 'أندرويد'),
  L18n('iOS', 'iOS'),
  L18n('Web', 'ويب'),
  L18n('Desktop', 'سطح المكتب'),
];

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          _backgroundLayer(),
          _gradientOverlay(isMobile),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 48,
              vertical: isMobile ? 32 : 44,
            ),
            child: isMobile
                ? _MobileHero(device: device)
                : _DesktopHero(device: device),
          ),
        ],
      ),
    );
  }

  Widget _backgroundLayer() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/logo/7c1ae715-563b-4455-9465-c93bd935db61.png',
            ),
            fit: BoxFit.cover,
            opacity: 0.35,
          ),
        ),
      ),
    );
  }

  Widget _gradientOverlay(bool isMobile) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // ignore: deprecated_member_use
              const Color(0xFF071029).withOpacity(0.92),
              // ignore: deprecated_member_use
              const Color(0xFF0F1D3A).withOpacity(0.85),
              // ignore: deprecated_member_use
              const Color(0xFF1B0F2E).withOpacity(0.88),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  final DeviceType device;
  const _DesktopHero({required this.device});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _HeroTextBlock(device: device)),
        const SizedBox(width: 32),
        Expanded(flex: 2, child: _HeroPortrait(device: device)),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  final DeviceType device;
  const _MobileHero({required this.device});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _HeroPortrait(device: device, mobileCompact: true),
        const SizedBox(height: 22),
        _HeroTextBlock(device: device, center: true),
      ],
    );
  }
}

class _HeroTextBlock extends StatelessWidget {
  final DeviceType device;
  final bool center;

  const _HeroTextBlock({
    required this.device,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = device == DeviceType.mobile;
    final align = center
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = center ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        // Status pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green.withValues(alpha: 0.20),
                const Color(0xFF34D399).withValues(alpha: 0.10),
              ],
            ),
            border: Border.all(
              color: Colors.greenAccent.withValues(alpha: 0.55),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withValues(alpha: 0.25),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withValues(alpha: 0.30),
                      shape: BoxShape.circle,
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat())
                      .scaleXY(
                        begin: 0.6,
                        end: 1.4,
                        duration: 1400.ms,
                        curve: Curves.easeOut,
                      )
                      .fade(begin: 0.7, end: 0.0, duration: 1400.ms),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.greenAccent, blurRadius: 8),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Text(
                isArabic(context)
                    ? 'متاح لفرص جديدة'
                    : 'Available for opportunities',
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: -0.3, end: 0),
        const SizedBox(height: 16),
        SizedBox(
          height: isMobile ? 36 : 48,
          child: AnimatedTextKit(
            key: ValueKey(isArabic(context)),
            animatedTexts: [
              TypewriterAnimatedText(
                isArabic(context)
                    ? 'أهلاً، أنا مصطفى بدر'
                    : "Hi, I'm Mostafa Badr",
                textStyle: TextStyle(
                  color: const Color(0xFFFFD700),
                  fontSize: isMobile ? 26 : 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  shadows: [
                    Shadow(
                      blurRadius: 16,
                      // ignore: deprecated_member_use
                      color: Colors.amberAccent.withOpacity(0.7),
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                speed: const Duration(milliseconds: 90),
                cursor: '|',
              ),
            ],
            repeatForever: true,
            pause: const Duration(milliseconds: 1800),
            isRepeatingAnimation: true,
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (rect) => const LinearGradient(
            colors: [Color(0xFF40C4FF), Color(0xFF9C7BFF)],
          ).createShader(rect),
          child: Text(
            isArabic(context)
                ? 'مطور Flutter متوسط الخبرة'
                : 'Mid-Level Flutter Developer',
            textAlign: textAlign,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 400.ms)
            .slideX(begin: center ? 0 : -0.15, end: 0),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            isArabic(context)
                ? 'أكثر من سنتين و نصف خبرة في بناء تطبيقات Flutter cross-platform بمستوى إنتاجي — '
                    'متخصص دلوقتي في تكامل Odoo ERP، Clean Architecture، و تجارب ثنائية اللغة مع RTL كامل. '
                    'سلّمت 6 تطبيقات حية مع Sentry observability و معمارية قابلة للتوسع.'
                : '2.5+ years building production-grade cross-platform Flutter apps — '
                    'currently specialising in Odoo ERP integration, Clean Architecture, and bilingual experiences with full RTL. '
                    'Shipped 6 live apps with Sentry observability and scalable architecture.',
            textAlign: textAlign,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: isMobile ? 14 : 16,
              height: 1.55,
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 600.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: 22),
        _platformBadges(center: center),
        const SizedBox(height: 22),
        _statsRow(),
        const SizedBox(height: 24),
        _ctaButtons(center: center),
      ],
    );
  }

  Widget _platformBadges({required bool center}) {
    return Builder(builder: (context) {
    return Wrap(
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: _technologyBadges.asMap().entries.map((entry) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          child: Text(
            entry.value.t(context),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        )
            .animate()
            .fadeIn(
              duration: 500.ms,
              delay: Duration(milliseconds: 800 + entry.key * 100),
            )
            .slideY(begin: 0.4, end: 0, curve: Curves.easeOut);
      }).toList(),
    );
    });
  }

  Widget _statsRow() {
    return Builder(builder: (context) {
      final ar = isArabic(context);
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: center ? WrapAlignment.center : WrapAlignment.start,
        children: [
          StatCounter(
            targetValue: 6,
            label: ar ? 'تطبيقات منشورة' : 'LIVE APPS',
            icon: Icons.rocket_launch,
            accent: const Color(0xFF40C4FF),
          ),
          StatCounter(
            targetValue: 4,
            label: ar ? 'تطبيقات Odoo' : 'ODOO ECOSYSTEM',
            icon: Icons.hub_outlined,
            accent: const Color(0xFF22D3EE),
          ),
          StatCounter(
            targetValue: 2,
            suffix: '.5+',
            label: ar ? 'سنوات خبرة' : 'YEARS EXPERIENCE',
            icon: Icons.workspace_premium,
            accent: const Color(0xFFFFD700),
          ),
        ],
      );
    });
  }

  Widget _ctaButtons({required bool center}) {
    return Builder(builder: (context) {
      final ar = isArabic(context);
    return Wrap(
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      spacing: 12,
      runSpacing: 10,
      children: [
        ElevatedButton.icon(
          onPressed: () => openUrl('https://wa.me/201004652998'),
          icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
          label: Text(ar ? 'تواصل معي' : "Let's Talk"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFD700),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => openUrl(
            'https://drive.google.com/file/d/1CghFSaB04ZJ8WAsqT-A4pibLYGLodEYA/view?usp=sharing',
          ),
          icon: const Icon(Icons.download_rounded, size: 18),
          label: Text(ar ? 'تحميل السيرة الذاتية' : 'Download Resume'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 700.ms, delay: 900.ms)
        .slideY(begin: 0.2, end: 0);
    });
  }
}

class _HeroPortrait extends StatelessWidget {
  final DeviceType device;
  final bool mobileCompact;

  const _HeroPortrait({
    required this.device,
    this.mobileCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = mobileCompact
        ? 140.0
        : (device == DeviceType.tablet ? 200.0 : 290.0);
    final orbitRadius = size * 0.75;
    final overallSize = (orbitRadius + 36) * 2;

    return Center(
      child: SizedBox(
        width: overallSize,
        height: overallSize,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Outer orbital ring (subtle, decorative)
            Container(
              width: orbitRadius * 2,
              height: orbitRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.06),
                  width: 1,
                ),
              ),
            ),
            // Inner orbital ring
            Container(
              width: (orbitRadius - 22) * 2,
              height: (orbitRadius - 22) * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.04),
                  width: 1,
                ),
              ),
            ),
            // Sweep gradient halo
            Container(
              width: size + 30,
              height: size + 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    const Color(0xFFFFD700).withValues(alpha: 0.7),
                    const Color(0xFF40C4FF).withValues(alpha: 0.6),
                    const Color(0xFF9C7BFF).withValues(alpha: 0.6),
                    const Color(0xFFFFD700).withValues(alpha: 0.7),
                  ],
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .rotate(duration: 12.seconds),
            // Dark mask behind the photo
            Container(
              width: size + 20,
              height: size + 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0B1430),
              ),
            ),
            // Orbiting tech logos — clockwise
            _OrbitingLogos(radius: orbitRadius, clockwise: true),
            // Counter-orbiting tech logos
            _OrbitingLogos(
              radius: orbitRadius - 22,
              clockwise: false,
              icons: _innerOrbitIcons,
            ),
            // Photo
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF40C4FF).withValues(alpha: 0.35),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/images/my_photo/5564545.png'),
                  fit: BoxFit.cover,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms)
                .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1)),
          ],
        ),
      ),
    );
  }
}

class _OrbitIconSpec {
  final IconData icon;
  final Color color;
  const _OrbitIconSpec(this.icon, this.color);
}

const _outerOrbitIcons = <_OrbitIconSpec>[
  _OrbitIconSpec(FontAwesomeIcons.flutter, Color(0xFF42A5F5)),
  _OrbitIconSpec(FontAwesomeIcons.fire, Color(0xFFFFA000)),
  _OrbitIconSpec(FontAwesomeIcons.boxesStacked, Color(0xFF22D3EE)),
  _OrbitIconSpec(FontAwesomeIcons.database, Color(0xFF3ECF8E)),
  _OrbitIconSpec(FontAwesomeIcons.laravel, Color(0xFFFF2D20)),
];

const _innerOrbitIcons = <_OrbitIconSpec>[
  _OrbitIconSpec(FontAwesomeIcons.code, Color(0xFF0175C2)),
  _OrbitIconSpec(FontAwesomeIcons.cubes, Color(0xFF02569B)),
  _OrbitIconSpec(FontAwesomeIcons.bolt, Color(0xFFFFD700)),
];

class _OrbitingLogos extends StatefulWidget {
  final double radius;
  final bool clockwise;
  final List<_OrbitIconSpec> icons;

  const _OrbitingLogos({
    required this.radius,
    this.clockwise = true,
    this.icons = _outerOrbitIcons,
  });

  @override
  State<_OrbitingLogos> createState() => _OrbitingLogosState();
}

class _OrbitingLogosState extends State<_OrbitingLogos>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.clockwise ? 28 : 36),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value * 2 * math.pi *
            (widget.clockwise ? 1 : -1);
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: List.generate(widget.icons.length, (i) {
            final angle = t + (i * 2 * math.pi / widget.icons.length);
            final dx = math.cos(angle) * widget.radius;
            final dy = math.sin(angle) * widget.radius;
            return Transform.translate(
              offset: Offset(dx, dy),
              child: _OrbitingChip(spec: widget.icons[i]),
            );
          }),
        );
      },
    );
  }
}

class _OrbitingChip extends StatelessWidget {
  final _OrbitIconSpec spec;
  const _OrbitingChip({required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.10),
            Colors.white.withValues(alpha: 0.03),
          ],
        ),
        border: Border.all(
          color: spec.color.withValues(alpha: 0.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: spec.color.withValues(alpha: 0.30),
            blurRadius: 12,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: FaIcon(spec.icon, size: 15, color: spec.color),
    );
  }
}
