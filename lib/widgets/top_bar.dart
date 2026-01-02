import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';

class SectionTarget {
  final String label;
  final GlobalKey key;

  const SectionTarget({required this.label, required this.key});
}

class TopBar extends StatelessWidget {
  final List<SectionTarget> sectionTargets;

  const TopBar({
    super.key,
    required this.sectionTargets,
  });

  Future<void> _scrollToSection(GlobalKey targetKey) async {
    final context = targetKey.currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final nameFontSize = device == DeviceType.desktop ? 20.0 : 18.0;

    final navigationButtons = sectionTargets
        .map(
          (target) => TextButton(
            onPressed: () => _scrollToSection(target.key),
            child: Text(target.label),
          ),
        )
        .toList();

    return Row(
      children: [
        Text(
          'Mostafa Badr',
          style: TextStyle(fontSize: nameFontSize, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        if (device != DeviceType.mobile) ...[
          Row(children: navigationButtons),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: () => openUrl('https://wa.me/201004652998'),
            icon: const Icon(Icons.wechat_sharp),
            label: const Text('Contact'),
          ),
        ] else
          ElevatedButton.icon(
            onPressed: () => openUrl('https://wa.me/201004652998'),
            icon: const Icon(Icons.wechat_sharp),
            label: const Text('Contact'),
          ),
      ],
    ).animate().fadeIn(duration: 500.ms);
  }
}
