import 'package:mostafa_badr_portfolio/core/constants/app_links.dart';

/// Pre-written outreach messages.
///
/// These are conversation openers, not UI labels — a visitor lands in WhatsApp
/// with the intent already explained, so the first message is never an awkward
/// "hi". They live here rather than in [Tr] because they are payload text, not
/// something the app renders.
class ContactMessages {
  const ContactMessages._();

  static const String _scheduleEn =
      'Hi Mostafa,\n\n'
      'I saw your portfolio and would like to schedule a quick call to '
      'discuss a role/project.\n\n'
      'When would work for you in the next few days?';

  static const String _scheduleAr =
      'مرحباً مصطفى،\n\n'
      'شفت بورتفوليوك و حابب نحجز call عشان نتكلم في فرصة عمل / مشروع.\n\n'
      'متى يناسبك خلال الأسبوع القادم؟';

  static const String _hireEn =
      'Hi Mostafa,\n\n'
      'I would like to talk about a role / collaboration opportunity.';

  static const String _hireAr =
      'مرحباً مصطفى،\n\n'
      'حابب أتكلم معاك عن فرصة عمل / تعاون.';

  static const String _emailSubjectEn = 'Contact from Portfolio';
  static const String _emailSubjectAr = 'تواصل من البورتفوليو';

  static const String _emailBodyEn =
      'Hi Mostafa,\n\nI would like to talk about ...';
  static const String _emailBodyAr =
      'مرحباً مصطفى،\n\nحابب أتكلم معاك عن ...';
}

/// Plain WhatsApp link with no pre-filled text.
String get whatsappLink => AppLinks.whatsapp;

/// "Schedule a Call" CTA — pre-fills a professional message so the visitor
/// lands in a conversation that already explains the intent.
String scheduleCallLink({bool arabic = false}) => AppLinks.whatsappWith(
      arabic ? ContactMessages._scheduleAr : ContactMessages._scheduleEn,
    );

/// "Hire me" CTA — pre-fills a hire-intent message.
String hireMeLink({bool arabic = false}) => AppLinks.whatsappWith(
      arabic ? ContactMessages._hireAr : ContactMessages._hireEn,
    );

/// `mailto:` link with a localized subject and opening line.
String emailLink({bool arabic = false}) => AppLinks.mailto(
      subject: arabic
          ? ContactMessages._emailSubjectAr
          : ContactMessages._emailSubjectEn,
      body: arabic ? ContactMessages._emailBodyAr : ContactMessages._emailBodyEn,
    );
