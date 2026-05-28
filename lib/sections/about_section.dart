import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final ar = isArabic(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'about.eyebrow'),
          title: Tr.k(context, 'about.title'),
          subtitle: Tr.k(context, 'about.subtitle'),
          icon: Icons.person_outline,
        ),
        GlassCard(
          padding: EdgeInsets.all(isMobile ? 18 : 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ar
                    ? 'أنا مصطفى بدر — مطور Flutter متوسط الخبرة، عندي أكثر من سنتين و نصف خبرة عملية في شحن '
                        'تطبيقات أندرويد و iOS بمستوى إنتاجي. حالياً في فريق Odoo Apps في Digital Harbor (Golden Odoo Partner) '
                        'بشتغل على تطبيقات موبايل enterprise متكاملة مع Odoo 18/19 ERP. قبل كده شحنت تطبيقات لـ '
                        'New Touch و Green Line في مجالات العقارات و التجارة الإلكترونية و ride-hailing.'
                    : "I'm Mostafa Badr — a Mid-Level Flutter Developer with 2.5+ years of hands-on experience "
                        "shipping production-grade Android and iOS apps. Currently in the Odoo Apps team at Digital Harbor "
                        "(Golden Odoo Partner), building enterprise mobile companions integrated with Odoo 18/19 ERP. "
                        "Previously shipped apps for New Touch and Green Line across real estate, e-commerce, and ride-hailing.",
                style: TextStyle(
                  color: Colors.grey[300],
                  height: 1.7,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                ar
                    ? 'تخصصي: تكامل Odoo ERP (REST + JSON-RPC)، Clean Architecture، Bloc/Cubit، تجارب ثنائية اللغة مع '
                        'RTL كامل، و observability احترافي عبر Sentry. بطبّق SOLID و Design Patterns عشان أقدم منتجات '
                        'قابلة للتوسع و الصيانة لفرق طويلة المدى.'
                    : "Specialisation: Odoo ERP integration (REST + JSON-RPC), Clean Architecture, Bloc/Cubit, bilingual "
                        "experiences with full RTL, and production observability via Sentry. I apply SOLID and design "
                        "patterns to deliver scalable, maintainable products built for long-term teams.",
                style: TextStyle(
                  color: Colors.grey[300],
                  height: 1.7,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _Pill(
                    label: ar ? '🧩 Odoo ERP Specialist' : '🧩 Odoo ERP Specialist',
                    color: const Color(0xFF22D3EE),
                  ),
                  _Pill(
                    label: ar ? '🚀 6 تطبيقات حية' : '🚀 6 Live Apps',
                    color: const Color(0xFFFFD700),
                  ),
                  _Pill(
                    label: ar
                        ? '🧱 Clean Architecture'
                        : '🧱 Clean Architecture',
                    color: const Color(0xFF40C4FF),
                  ),
                  _Pill(
                    label: ar ? '🌐 AR / EN · RTL' : '🌐 AR / EN · RTL',
                    color: const Color(0xFF9C7BFF),
                  ),
                  _Pill(
                    label: ar ? '⚡ الأداء أولاً' : '⚡ Performance-first',
                    color: const Color(0xFF69F0AE),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
