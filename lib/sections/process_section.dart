import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class _Step {
  final IconData icon;
  final Color color;
  final L18n title;
  final L18n body;

  const _Step({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });
}

const _steps = <_Step>[
  _Step(
    icon: Icons.explore_outlined,
    color: AppColors.gold,
    title: L18n('Discover', 'استكشاف'),
    body: L18n(
      'I sit with stakeholders to map flows, edge cases, and constraints — '
      'then translate them into a one-page spec with the riskiest assumptions '
      'called out first.',
      'بقعد مع أصحاب القرار عشان أرسم الـ flows و الـ edge cases و القيود — و '
      'بحوّلهم لـ spec من صفحة واحدة الأولوية فيها للافتراضات الأخطر.',
    ),
  ),
  _Step(
    icon: Icons.architecture_outlined,
    color: AppColors.cyan,
    title: L18n('Architect', 'تصميم المعمارية'),
    body: L18n(
      'Feature-first Clean Architecture. Sealed states, SafeCubit base, typed '
      'network errors, and the shared widget library. Designed so a teammate '
      'can onboard in a day.',
      'معمارية Clean Feature-First. States بصيغة sealed، و SafeCubit كـ base، '
      'و أخطاء شبكة typed، و مكتبة widgets مشتركة. مصمّمة عشان زميل جديد يلحق '
      'فيها في يوم.',
    ),
  ),
  _Step(
    icon: Icons.rocket_launch_outlined,
    color: AppColors.teal,
    title: L18n('Ship', 'الشحن'),
    body: L18n(
      'Small PRs, fast review cycles, and signed release builds (R8/ProGuard '
      'obfuscation, dart-defined env). Both stores in one script — staged '
      'rollouts by default.',
      'PRs صغيرة، دورات مراجعة سريعة، و release builds موقّعة (تشفير '
      'R8/ProGuard، متغيرات عبر dart-define). كل المتاجر بسكربت واحد — '
      'rollout تدريجي افتراضياً.',
    ),
  ),
  _Step(
    icon: Icons.insights_outlined,
    color: AppColors.purple,
    title: L18n('Observe', 'متابعة'),
    body: L18n(
      'Sentry with environmental noise filtering, auto-uploaded debug symbols '
      'per release, and a small daily triage habit — so regressions get caught '
      'before users report them.',
      'Sentry مع فلترة الـ noise البيئي، رفع تلقائي لـ debug symbols مع كل '
      'إصدار، و عادة triage يومية صغيرة — عشان الـ regressions تتمسك قبل ما '
      'اليوزر يبلّغ.',
    ),
  ),
];

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'process.eyebrow'),
          title: Tr.k(context, 'process.title'),
          subtitle: Tr.k(context, 'process.subtitle'),
          icon: Icons.timeline_outlined,
        ),
        ResponsiveBuilder(
          builder: (context, constraints, device) {
            final columns = switch (device) {
              DeviceType.desktop => 4,
              DeviceType.tablet => 2,
              DeviceType.mobile => 1,
            };
            const spacing = AppSizes.md;
            final available = constraints.hasBoundedWidth
                ? constraints.maxWidth
                : context.screenWidth;
            final cellWidth =
                (available - spacing * (columns - 1)) / columns;

            // The old mobile ratio of 2.4 left ~25px for a four-line paragraph,
            // squeezing the body to an unreadable sliver. Measuring the text
            // against the real cell width gives each card exactly the height
            // its copy needs, at any breakpoint.
            final cardHeight = _tallestCardHeight(
              context: context,
              cellWidth: cellWidth,
              isMobile: device == DeviceType.mobile,
            );

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _steps.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: cellWidth / cardHeight,
              ),
              itemBuilder: (context, index) {
                return _StepCard(
                  step: _steps[index],
                  index: index,
                  total: _steps.length,
                )
                    .animate()
                    .fadeIn(
                      duration: 500.ms,
                      delay: Duration(milliseconds: 80 * index),
                    )
                    .slideY(begin: 0.10, end: 0, curve: Curves.easeOutCubic);
              },
            );
          },
        ),
      ],
    );
  }

  /// Height of the tallest step card at [cellWidth], so every card in the grid
  /// fits its longest paragraph without clipping and without leaving a gap
  /// under the shortest one.
  static double _tallestCardHeight({
    required BuildContext context,
    required double cellWidth,
    required bool isMobile,
  }) {
    final padding = isMobile ? AppSizes.lg : AppSizes.xl;
    final bodyWidth = cellWidth - padding * 2;
    // Icon row + gaps + title, measured from the card's own layout.
    const chrome = 36.0 + AppSizes.md + 26.0 + AppSizes.sm;
    final bodyStyle = TextStyle(
      fontSize: isMobile ? 13 : 13.5,
      height: 1.55,
    );

    var tallest = 0.0;
    for (final step in _steps) {
      final painter = TextPainter(
        text: TextSpan(text: step.body.t(context), style: bodyStyle),
        textDirection: Directionality.of(context),
        maxLines: 8,
      )..layout(maxWidth: bodyWidth > 0 ? bodyWidth : 1);
      tallest = tallest > painter.height ? tallest : painter.height;
    }
    return chrome + tallest + padding * 2;
  }
}

class _StepCard extends StatelessWidget {
  final _Step step;
  final int index;
  final int total;

  const _StepCard({
    required this.step,
    required this.index,
    required this.total,
  });

  String get _counter =>
      '${(index + 1).toString().padLeft(2, '0')} / '
      '${total.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? AppSizes.lg : AppSizes.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  color: step.color.withValues(alpha: 0.12),
                  border: Border.all(
                    color: step.color.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(step.icon, size: 18, color: step.color),
              ),
              const Spacer(),
              Text(
                _counter,
                // Latin digits regardless of locale — the counter reads as a
                // progress indicator, not prose.
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: step.color.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            step.title.t(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: isMobile ? 17 : 18,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          Expanded(
            child: Text(
              step.body.t(context),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: isMobile ? 13 : 13.5,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
