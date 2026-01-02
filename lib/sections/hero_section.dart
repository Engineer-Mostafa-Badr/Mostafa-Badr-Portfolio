import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

const _technologyBadges = ['Android', 'iOS', 'Web', 'Desktop'];
const _experienceText = '1+ year crafting cross-platform Flutter apps.';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final heroHeight = isMobile
        ? 480.0
        : (device == DeviceType.tablet ? 520.0 : 600.0);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: heroHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                'assets/images/logo/7c1ae715-563b-4455-9465-c93bd935db61.png',
              ),
              fit: BoxFit.cover,
              opacity: 0.60,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          width: double.infinity,
          height: isMobile ? heroHeight : 250,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 18 : 40,
            vertical: 30,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 6),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "Hi, I'm Mostafa Badr",
                          textStyle: TextStyle(
                            color: const Color(0xFFFFD700),
                            fontSize: isMobile ? 22 : 30,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.amberAccent.withOpacity(0.8),
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          speed: const Duration(milliseconds: 100),
                          cursor: '|',
                        ),
                      ],
                      repeatForever: true,
                      pause: const Duration(milliseconds: 1500),
                      isRepeatingAnimation: true,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Junior Flutter Developer',
                      style: TextStyle(
                        color: Colors.lightBlueAccent.withOpacity(.7),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Mobile app developer with 1+ year of practical experience. I build clean and maintainable Flutter applications with scalable backends.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildExperienceBlock(centerText: true),
                    const SizedBox(height: 18),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () =>
                              openUrl('https://wa.me/201004652998'),
                          icon: const Icon(Icons.wechat_sharp),
                          label: const Text('Contact'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => openUrl(
                            'https://drive.google.com/file/d/1ffQBopvb92SnGj6CL_A9Dgf04T2F9Wah/view?usp=sharing',
                          ),
                          icon: const Icon(Icons.download),
                          label: const Text('Resume'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    CircleAvatar(
                      radius: 68,
                      backgroundImage: const AssetImage(
                        'assets/images/my_photo/5564545.png',
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                "Hi, I'm Mostafa Badr",
                                textStyle: TextStyle(
                                  color: const Color(0xFFFFD700),
                                  fontSize: isMobile ? 22 : 30,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      color: Colors.amberAccent.withOpacity(
                                        0.8,
                                      ),
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 100),
                                cursor: '|',
                              ),
                            ],
                            repeatForever: true,
                            pause: const Duration(milliseconds: 1500),
                            isRepeatingAnimation: true,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Junior Flutter Developer',
                            style: TextStyle(
                              color: Colors.lightBlueAccent.withOpacity(.7),
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Mobile app developer with 1+ year of practical experience. \nI build clean and maintainable Flutter applications with scalable backends.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildExperienceBlock(centerText: false),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 12,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () =>
                                    openUrl('https://wa.me/201004652998'),
                                icon: const Icon(Icons.wechat_sharp),
                                label: const Text('Contact'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => openUrl(
                                  'https://drive.google.com/file/d/1TGi4FNqjN8cP_JAQYGIKRR2SPhyGdGEu/view',
                                ),
                                icon: const Icon(Icons.download),
                                label: const Text('Resume'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Container(
                          width: device == DeviceType.tablet ? 200 : 280,
                          height: device == DeviceType.tablet ? 200 : 280,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 12,
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/my_photo/5564545.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildExperienceBlock({required bool centerText}) {
    final badgeWidgets = _technologyBadges
        .map(
          (label) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        )
        .toList();

    final block = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _experienceText,
          style: TextStyle(
            color: Colors.grey[200],
            fontSize: centerText ? 14 : 15,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(spacing: 10, runSpacing: 6, children: badgeWidgets),
      ],
    );

    if (centerText) {
      return Align(alignment: Alignment.center, child: block);
    }

    return block;
  }
}
