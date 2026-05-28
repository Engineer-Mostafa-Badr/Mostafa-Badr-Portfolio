import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
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
    color: Color(0xFFFFD700),
    title: L18n('Discover', 'استكشاف'),
    body: L18n(
      'I sit with stakeholders to map flows, edge cases, and constraints — then translate them into a one-page spec with the riskiest assumptions called out first.',
      'بقعد مع أصحاب القرار عشان أرسم الـ flows و الـ edge cases و القيود — و بحوّلهم لـ spec من صفحة واحدة الأولوية فيها للافتراضات الأخطر.',
    ),
  ),
  _Step(
    icon: Icons.architecture_outlined,
    color: Color(0xFF40C4FF),
    title: L18n('Architect', 'تصميم المعمارية'),
    body: L18n(
      'Feature-first Clean Architecture. Sealed states, SafeCubit base, typed network errors, and the shared widget library. Designed so a teammate can onboard in a day.',
      'معمارية Clean Feature-First. States بصيغة sealed، و SafeCubit كـ base، و أخطاء شبكة typed، و مكتبة widgets مشتركة. مصمّمة عشان زميل جديد يلحق فيها في يوم.',
    ),
  ),
  _Step(
    icon: Icons.rocket_launch_outlined,
    color: Color(0xFF22D3EE),
    title: L18n('Ship', 'الشحن'),
    body: L18n(
      'Small PRs, fast review cycles, and signed release builds (R8/ProGuard obfuscation, dart-defined env). Both stores in one script — staged rollouts by default.',
      'PRs صغيرة، دورات مراجعة سريعة، و release builds موقّعة (تشفير R8/ProGuard، متغيرات عبر dart-define). كل المتاجر بسكربت واحد — rollout تدريجي افتراضياً.',
    ),
  ),
  _Step(
    icon: Icons.insights_outlined,
    color: Color(0xFF9C7BFF),
    title: L18n('Observe', 'متابعة'),
    body: L18n(
      'Sentry with environmental noise filtering, auto-uploaded debug symbols per release, and a small daily triage habit — so regressions get caught before users report them.',
      'Sentry مع فلترة الـ noise البيئي، رفع تلقائي لـ debug symbols مع كل إصدار، و عادة triage يومية صغيرة — عشان الـ regressions تتمسك قبل ما اليوزر يبلّغ.',
    ),
  ),
];

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final isTablet = device == DeviceType.tablet;
    final ar = isArabic(context);

    final crossCount = isMobile ? 1 : (isTablet ? 2 : 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: ar ? 'طريقة عملي' : 'How I work',
          title: ar ? 'من الفكرة للإنتاج' : 'From idea to production',
          subtitle: ar
              ? 'الخطوات الأربعة اللي ببنيها لما أبدأ feature جديدة أو منتج كامل.'
              : 'The four-step rhythm I follow on every feature and every product.',
          icon: Icons.timeline_outlined,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _steps.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: isMobile ? 2.4 : (isTablet ? 1.65 : 0.92),
          ),
          itemBuilder: (context, i) {
            final step = _steps[i];
            return _StepCard(step: step, index: i, total: _steps.length)
                .animate()
                .fadeIn(
                  duration: 500.ms,
                  delay: Duration(milliseconds: 80 * i),
                )
                .slideY(begin: 0.10, end: 0, curve: Curves.easeOutCubic);
          },
        ),
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: step.color.withValues(alpha: 0.12),
                  border: Border.all(
                    color: step.color.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(step.icon, size: 18, color: step.color),
              ),
              const Spacer(),
              Text(
                '${(index + 1).toString().padLeft(2, '0')} / ${total.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: step.color.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            step.title.t(context),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: isMobile ? 17 : 18,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              step.body.t(context),
              maxLines: 6,
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
