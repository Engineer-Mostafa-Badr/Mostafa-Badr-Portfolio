// Centralized contact links for the portfolio.
// Keeping the strings here means the WhatsApp/email/scheduling targets can be
// updated in one place if the phone number or messaging copy ever changes.

const String _whatsappNumber = '201004652998';

String get whatsappLink => 'https://wa.me/$_whatsappNumber';

/// "Schedule a Call" CTA — pre-fills a professional message in WhatsApp so the
/// visitor lands in a conversation that already explains the intent.
String scheduleCallLink({bool arabic = false}) {
  final message = arabic
      ? 'مرحباً مصطفى،\n\nشفت بورتفوليوك و حابب نحجز call عشان نتكلم في فرصة عمل / مشروع.\n\nمتى يناسبك خلال الأسبوع القادم؟'
      : 'Hi Mostafa,\n\nI saw your portfolio and would like to schedule a quick call to discuss a role/project.\n\nWhen would work for you in the next few days?';
  final encoded = Uri.encodeComponent(message);
  return 'https://wa.me/$_whatsappNumber?text=$encoded';
}

/// "Hire me" CTA — pre-fills a hire-intent message.
String hireMeLink({bool arabic = false}) {
  final message = arabic
      ? 'مرحباً مصطفى،\n\nحابب أتكلم معاك عن فرصة عمل / تعاون.'
      : 'Hi Mostafa,\n\nI would like to talk about a role / collaboration opportunity.';
  final encoded = Uri.encodeComponent(message);
  return 'https://wa.me/$_whatsappNumber?text=$encoded';
}
