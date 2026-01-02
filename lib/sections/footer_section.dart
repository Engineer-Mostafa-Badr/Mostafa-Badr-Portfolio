import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final iconSize = device == DeviceType.mobile ? 20.0 : 22.0;

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.linkedin,
              color: Colors.blue,
              size: iconSize,
            ),
            onPressed: () =>
                openUrl('https://www.linkedin.com/in/engineer-mostafa-badr/'),
            tooltip: 'LinkedIn',
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.facebook,
              color: Colors.blueAccent,
              size: iconSize,
            ),
            onPressed: () =>
                openUrl('https://web.facebook.com/Engineer.Mostafa.Badr/'),
            tooltip: 'Facebook',
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.instagram,
              color: Colors.pinkAccent,
              size: iconSize,
            ),
            onPressed: () =>
                openUrl('https://www.instagram.com/engineer_mostafa_badr/'),
            tooltip: 'Instagram',
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.tiktok,
              color: Colors.black,
              size: iconSize,
            ),
            onPressed: () =>
                openUrl('https://www.tiktok.com/@engineer_mostafa_badr'),
            tooltip: 'TikTok',
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.youtube,
              color: Colors.red,
              size: iconSize,
            ),
            onPressed: () =>
                openUrl('https://www.youtube.com/@Engineer_Mostafa_Badr'),
            tooltip: 'YouTube',
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.xTwitter,
              color: Colors.black,
              size: iconSize,
            ),
            onPressed: () => openUrl('https://x.com/EngMostafa_Badr'),
            tooltip: 'X',
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidEnvelope,
              color: Colors.orange,
              size: iconSize,
            ),
            tooltip: 'Email',
            onPressed: () {
              final email = 'mostafamostafabadrbadr@gmail.com';
              final subject = Uri.encodeComponent('Hello Mostafa');
              final body = Uri.encodeComponent(
                'Hi Mostafa,\n\nI would like to get in touch with you regarding...',
              );
              final mailUrl = 'mailto:$email?subject=$subject&body=$body';
              openUrl(mailUrl);
            },
          ),
        ],
      ),
    );
  }
}
