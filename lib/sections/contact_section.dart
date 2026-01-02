import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Contact',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 12),
        ContactCard(),
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

    return Card(
      color: Colors.black.withOpacity(0.45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 14 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Let\'s build something together',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Available for freelance & full-time roles. Reach out and let\'s talk about your project.',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Let\'s build something together',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'Available for freelance & full-time roles. Reach out and let\'s talk about your project.',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ],
                  ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => openUrl('https://wa.me/201004652998'),
                icon: const Icon(Icons.wechat_sharp),
                label: const Text('Get in Touch'),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              children: _contactChannels
                  .map(
                    (channel) => ActionChip(
                      avatar: Icon(
                        channel.icon,
                        size: 18,
                        color: Colors.white70,
                      ),
                      label: Text(channel.label),
                      backgroundColor: Colors.grey[850],
                      onPressed: () => openUrl(channel.url),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}

class ContactChannel {
  final String label;
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
    label: 'Email',
    url:
        'mailto:mostafamostafabadrbadr@gmail.com?subject=Contact%20from%20Portfolio&body=Hi%20Mostafa%2C%0A%0AI%27d%20like%20to%20talk%20about%20...',
    icon: Icons.email,
  ),
  ContactChannel(
    label: 'LinkedIn',
    url: 'https://www.linkedin.com/in/engineer-mostafa-badr/',
    icon: Icons.link,
  ),
  ContactChannel(
    label: 'GitHub',
    url: 'https://github.com/Engineer-Mostafa-Badr',
    icon: Icons.code,
  ),
];
