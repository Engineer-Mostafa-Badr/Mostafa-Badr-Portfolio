import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_links.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/contact_links.dart';
import 'package:mostafa_badr_portfolio/widgets/common/app_button.dart';
import 'package:mostafa_badr_portfolio/widgets/common/gradient_text.dart';
import 'package:mostafa_badr_portfolio/widgets/glass_card.dart';
import 'package:mostafa_badr_portfolio/widgets/inline_contact_form.dart';
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
    final isMobile = context.isMobile;

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? AppSizes.headerGap : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText(
            Tr.k(context, 'contact.heading'),
            style: TextStyle(
              fontSize: isMobile ? 20 : 26,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppSizes.md - 2),
          Text(
            Tr.k(context, 'contact.body'),
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: isMobile ? 13 : 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSizes.headerGap),
          // Inline form — the primary path for visitors who would rather type
          // than switch apps.
          const InlineContactForm(),
          const SizedBox(height: 22),
          const _OrDivider(),
          const SizedBox(height: AppSizes.headerGap),
          const _ContactChannelButtons(),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final line = Divider(
      color: Colors.white.withValues(alpha: 0.10),
      thickness: 1,
    );

    return Row(
      children: [
        Expanded(child: line),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Text(
            Tr.k(context, 'common.or'),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(child: line),
      ],
    );
  }
}

class _ContactChannelButtons extends StatelessWidget {
  const _ContactChannelButtons();

  @override
  Widget build(BuildContext context) {
    final ar = isArabic(context);

    return Wrap(
      spacing: AppSizes.md - 2,
      runSpacing: AppSizes.md - 2,
      children: [
        AppButton(
          label: Tr.k(context, 'contact.whatsapp'),
          icon: Icons.chat_bubble_outline_rounded,
          onPressed: () =>
              openUrl(scheduleCallLink(arabic: ar), context: context),
        ),
        AppButton(
          label: Tr.k(context, 'contact.email'),
          icon: Icons.email_outlined,
          variant: AppButtonVariant.secondary,
          onPressed: () => openUrl(emailLink(arabic: ar), context: context),
        ),
        AppButton(
          label: Tr.k(context, 'contact.linkedin'),
          icon: Icons.link,
          variant: AppButtonVariant.secondary,
          onPressed: () => openUrl(AppLinks.linkedIn, context: context),
        ),
        AppButton(
          label: Tr.k(context, 'contact.github'),
          icon: Icons.code,
          variant: AppButtonVariant.secondary,
          onPressed: () => openUrl(AppLinks.github, context: context),
        ),
      ],
    );
  }
}
