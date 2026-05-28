import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: Tr.k(context, 'contact.eyebrow'),
          title: Tr.k(context, 'contact.title'),
          subtitle: Tr.k(context, 'contact.subtitle'),
          icon: Icons.send_outlined,
        ),
        const ContactCard(),
      ],
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = deviceTypeFromWidth(width) == DeviceType.mobile;
    final ar = isArabic(context);

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 18 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              colors: [Color(0xFFFFD700), Color(0xFF40C4FF)],
            ).createShader(rect),
            child: Text(
              ar ? 'يلا نبني حاجة مع بعض' : "Let's build something together",
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 20 : 26,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            ar
                ? 'عندك مشروع Flutter في بالك، أو عايز نتكلم عن فرصة عمل؟ '
                    'أنا على بُعد رسالة.'
                : 'Have a Flutter project in mind, or want to chat about a role? '
                    "I'm one message away.",
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: isMobile ? 13 : 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => openUrl('https://wa.me/201004652998'),
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
                label: Text(Tr.k(context, 'contact.whatsapp')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
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
              ..._contactChannels.map(
                (channel) => OutlinedButton.icon(
                  onPressed: () => openUrl(channel.url),
                  icon: Icon(channel.icon, size: 16),
                  label: Text(channel.label.t(context)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactChannel {
  final L18n label;
  final String url;
  final IconData icon;

  const ContactChannel({
    required this.label,
    required this.url,
    required this.icon,
  });
}

const _contactChannels = [
  ContactChannel(
    label: L18n('Email', 'إيميل'),
    url:
        'mailto:mostafamostafabadrbadr@gmail.com?subject=Contact%20from%20Portfolio&body=Hi%20Mostafa%2C%0A%0AI%27d%20like%20to%20talk%20about%20...',
    icon: Icons.email_outlined,
  ),
  ContactChannel(
    label: L18n('LinkedIn', 'لينكدإن'),
    url: 'https://www.linkedin.com/in/engineer-mostafa-badr/',
    icon: Icons.link,
  ),
  ContactChannel(
    label: L18n('GitHub', 'جيت هاب'),
    url: 'https://github.com/Engineer-Mostafa-Badr',
    icon: Icons.code,
  ),
];
