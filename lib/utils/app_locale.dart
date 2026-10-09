import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/data/projects_data.dart';

class AppLocaleController {
  static const Locale en = Locale('en');
  static const Locale ar = Locale('ar');

  static final ValueNotifier<Locale> locale = ValueNotifier(en);

  static void toggle() {
    locale.value = locale.value.languageCode == 'ar' ? en : ar;
  }
}

bool isArabic(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'ar';

/// Bilingual string pair. Use [t] to resolve against the active locale.
///
/// Used for *content* — project descriptions, experience entries, course
/// titles — which lives next to the data it describes. Chrome strings (labels,
/// buttons, errors) go through [Tr] instead.
class L18n {
  final String en;
  final String ar;
  const L18n(this.en, this.ar);

  String t(BuildContext context) => isArabic(context) ? ar : en;
}

/// Every UI string the app can render, in both languages.
///
/// The rule this codebase follows: **no user-visible text is written inline in
/// a widget.** Not a label, not a tooltip, not an error, not an empty state.
/// If a visitor can read it, it has a key here and an entry in both maps.
///
/// In debug builds a missing or untranslated key trips an assert at startup
/// (see [debugAssertComplete]) so a gap is caught while developing rather than
/// discovered by an Arabic-speaking visitor reading English.
class Tr {
  const Tr._();

  static String k(BuildContext context, String key) {
    final map = isArabic(context) ? _ar : _en;
    final value = map[key];
    assert(
      value != null,
      'Missing translation for "$key" — add it to both maps in Tr.',
    );
    return value?.replaceAll('{live}', '$liveProjectsCount') ?? key;
  }

  /// Keys deliberately identical in both languages (brand names, symbols).
  /// Listed explicitly so the completeness check can tell "intentionally the
  /// same" apart from "someone forgot to translate this".
  static const Set<String> _sameInBothLanguages = {
    'hero.roleSuffix',
    'projects.cat.erp',
    'locale.toAr',
    'locale.toEn',
    'palette.hintNavigate',
    'palette.hintSelect',
    'palette.hintClose',
    'palette.localeHint',
    'palette.themeHint',
    'cv.subtitle',
    'about.pill.odoo',
    'about.pill.cleanArch',
    'about.pill.bilingual',
  };

  /// Verifies both maps cover the same keys and that nothing was left
  /// untranslated by accident. Called from `main()` under an assert, so it
  /// costs nothing in release builds.
  static bool debugAssertComplete() {
    final missingInAr = _en.keys.where((k) => !_ar.containsKey(k)).toList();
    final missingInEn = _ar.keys.where((k) => !_en.containsKey(k)).toList();
    assert(
      missingInAr.isEmpty,
      'Keys present in English but missing in Arabic: $missingInAr',
    );
    assert(
      missingInEn.isEmpty,
      'Keys present in Arabic but missing in English: $missingInEn',
    );

    final untranslated = _en.keys
        .where((k) => !_sameInBothLanguages.contains(k))
        .where((k) => _en[k] == _ar[k])
        .toList();
    assert(
      untranslated.isEmpty,
      'Keys with identical text in both languages — translate them or add '
      'them to Tr._sameInBothLanguages: $untranslated',
    );
    return true;
  }

  static const Map<String, String> _en = {
    // ── Common ───────────────────────────────────────────────────────────
    'common.retry': 'Retry',
    'common.close': 'Close',
    'common.menu': 'Menu',
    'common.download': 'Download',
    'common.backToTop': 'Back to top',
    'common.or': 'OR',

    // ── Errors ───────────────────────────────────────────────────────────
    // Each error is a pair: what happened, then what to do about it.
    'error.offline.title': 'You appear to be offline',
    'error.offline.action':
        'Check your internet connection and try again — or message me on '
        'WhatsApp, which works on a weak connection.',
    'error.timeout.title': 'The server took too long to answer',
    'error.timeout.action':
        'Your connection may be slow. Try again in a moment, or reach me '
        'directly on WhatsApp.',
    'error.invalidInput.title': "Some details weren't accepted",
    'error.invalidInput.action':
        'Please double-check your name, email, and message, then send again.',
    'error.rateLimited.title': 'Too many messages in a short time',
    'error.rateLimited.action':
        'Please wait a minute before sending again, or contact me on WhatsApp '
        'right away.',
    'error.endpointUnavailable.title': "The contact form isn't available",
    'error.endpointUnavailable.action':
        'This is on my side, not yours. Please reach me on WhatsApp or email '
        'instead — both go straight to me.',
    'error.serverError.title': 'The mail server had a problem',
    'error.serverError.action':
        'Nothing was lost on your end. Try again shortly, or send the same '
        'message over WhatsApp.',
    'error.unexpectedResponse.title': 'I got an unexpected response',
    'error.unexpectedResponse.action':
        "I can't confirm your message was delivered. To be safe, please resend "
        'it via WhatsApp or email.',
    'error.cannotOpenLink.title': "That link couldn't be opened",
    'error.cannotOpenLink.action':
        'Your browser may have blocked the pop-up. Allow pop-ups for this site, '
        'or copy the link and open it in a new tab.',
    'error.unknown.title': 'Something went wrong',
    'error.unknown.action':
        "The message wasn't sent. Please try again, or contact me on WhatsApp.",
    'error.imageUnavailable': 'Preview unavailable',

    // ── Nav ──────────────────────────────────────────────────────────────
    'nav.home': 'Home',
    'nav.about': 'About',
    'nav.skills': 'Skills',
    'nav.experience': 'Experience',
    'nav.projects': 'Projects',
    'nav.contact': 'Contact',
    'nav.hireMe': 'Hire me',
    'nav.jumpTo': 'Jump to',

    // ── Hero ─────────────────────────────────────────────────────────────
    'hero.eyebrow': 'Mid-Level Flutter Developer',
    'hero.roleSuffix': 'Flutter Developer',
    'hero.greeting': "Hi, I'm Mostafa Badr",
    'hero.name': 'Mostafa Badr',
    'hero.role': 'Mid-Level Flutter Developer',
    'hero.tagline':
        '2+ years building production-grade cross-platform Flutter apps — '
        'currently specialising in Odoo ERP integration, Clean Architecture, '
        'and bilingual experiences with full RTL. Shipped {live} live apps with '
        'Sentry observability and scalable architecture.',
    'hero.ctaProjects': 'View Projects',
    'hero.ctaCV': 'Download CV',
    'hero.ctaResume': 'Download Resume',
    'hero.ctaScheduleCall': 'Schedule a Call',
    'hero.ctaTalk': "Let's Talk",
    'hero.statApps': 'Live apps',
    'hero.statYears': 'Years',
    'hero.statCourses': 'Courses',
    'hero.stat.liveApps': 'LIVE APPS',
    'hero.stat.odoo': 'ODOO ECOSYSTEM',
    'hero.stat.years': 'YEARS EXPERIENCE',
    'hero.badge.android': 'Android',
    'hero.badge.ios': 'iOS',
    'hero.badge.web': 'Web',
    'hero.badge.desktop': 'Desktop',
    'hero.openToWork': "I'm open to work",
    'hero.openToWorkDetail':
        'Mid-Level Flutter · Remote from Egypt · Available now',

    // ── Sticky stats banner ──────────────────────────────────────────────
    'sticky.liveApps': 'Live',
    'sticky.liveAppsLong': 'Live apps',
    'sticky.odoo': 'Odoo',
    'sticky.years': 'Years',
    'sticky.available': 'Open',
    'sticky.availableLong': 'Available',

    // ── About ────────────────────────────────────────────────────────────
    'about.eyebrow': 'About me',
    'about.title': 'About',
    'about.subtitle':
        'Mid-Level Flutter Developer with 2+ years building production apps '
        'across multiple domains.',
    'about.icon.bg': 'Background',
    'about.icon.focus': 'Focus',
    'about.icon.education': 'Education',
    'about.icon.languages': 'Languages',
    'about.background':
        'Flutter developer focused on shipping reliable, maintainable '
        'cross-platform mobile apps. Comfortable across the full stack — '
        'owning the mobile side and integrating with REST APIs from Laravel, '
        'Node.js, Firebase, Supabase, and Odoo.',
    'about.focus':
        'Clean Architecture, SOLID, scalable state management '
        '(Bloc/Cubit/Provider/GetX), and shipping pixel-perfect responsive '
        'UIs.',
    'about.education':
        'B.Sc. — Faculty of Computers and Artificial Intelligence, Beni-Suef '
        'University.',
    'about.languages': 'Arabic (Native) · English (Professional)',
    'about.body1':
        "I'm Mostafa Badr — a Mid-Level Flutter Developer with 2+ years of "
        'hands-on experience shipping production-grade Android and iOS apps. '
        'Currently in the Odoo Apps team at Digital Harbor (Golden Odoo '
        'Partner), building enterprise mobile companions integrated with Odoo '
        '18/19 ERP. Previously shipped apps for New Touch and Green Line '
        'across real estate, e-commerce, and ride-hailing.',
    'about.body2':
        'Specialisation: Odoo ERP integration (REST + JSON-RPC), Clean '
        'Architecture, Bloc/Cubit, bilingual experiences with full RTL, and '
        'production observability via Sentry. I apply SOLID and design '
        'patterns to deliver scalable, maintainable products built for '
        'long-term teams.',
    'about.pill.odoo': '🧩 Odoo ERP Specialist',
    'about.pill.liveApps': '🚀 {live} Live Apps',
    'about.pill.cleanArch': '🧱 Clean Architecture',
    'about.pill.bilingual': '🌐 AR / EN · RTL',
    'about.pill.performance': '⚡ Performance-first',

    // ── Skills ───────────────────────────────────────────────────────────
    'skills.eyebrow': 'What I bring',
    'skills.title': 'Skills & Tools',
    'skills.subtitle':
        'The tech stack I use to ship reliable, fast, and maintainable apps.',
    'skills.group.core': 'Core',
    'skills.group.architecture': 'Architecture & DI',
    'skills.group.state': 'State Management',
    'skills.group.backend': 'Backend & APIs',
    'skills.group.mobile': 'Mobile Features',
    'skills.group.tooling': 'Tooling',

    // ── Tools ────────────────────────────────────────────────────────────
    'tools.eyebrow': 'Daily drivers',
    'tools.title': 'Tools I use',
    'tools.subtitle':
        'The stack I reach for every day — from editor to release.',

    // ── Process ──────────────────────────────────────────────────────────
    'process.eyebrow': 'How I work',
    'process.title': 'From idea to production',
    'process.subtitle':
        'The four-step rhythm I follow on every feature and every product.',

    // ── Experience ───────────────────────────────────────────────────────
    'experience.eyebrow': 'Where I worked',
    'experience.title': 'Work Experience',
    'experience.subtitle':
        'Companies and teams I shipped production Flutter apps with.',
    'experience.current': 'CURRENT',

    // ── Projects ─────────────────────────────────────────────────────────
    'projects.eyebrow': 'Selected work',
    'projects.title': 'Projects',
    'projects.subtitle':
        'Production apps and showcase projects across ride-hailing, real '
        'estate, e-commerce, social, and healthcare. Tap any project to '
        'explore.',
    'projects.view': 'View',
    'projects.featured': 'FEATURED',
    'projects.highlights': 'HIGHLIGHTS',
    'projects.techStack': 'TECH STACK',
    'projects.challenge': 'The Challenge',
    'projects.solution': 'Solution & Impact',
    'projects.filter.all': 'All',
    'projects.cat.erp': 'Odoo · ERP',
    'projects.cat.realEstate': 'Real Estate',
    'projects.cat.ecommerce': 'E-commerce',
    'projects.cat.superApp': 'Super App',
    'projects.cat.rideHailing': 'Ride-hailing',
    'projects.cat.ar': 'AR · 3D',
    'projects.playStore': 'Open in Play Store',
    'projects.appStore': 'Open in App Store',
    'projects.downloadApk': 'Download APK',
    'projects.viewRepo': 'View Repo',
    'projects.website': 'Visit Website',
    'projects.empty': 'No projects in this category yet',
    'projects.emptyHint': 'Pick another filter to see the rest of my work.',
    'projects.previousImage': 'Previous screenshot',
    'projects.nextImage': 'Next screenshot',

    // ── Certifications ───────────────────────────────────────────────────
    'certs.eyebrow': 'Recognised work',
    'certs.title': 'Certifications',
    'certs.subtitle':
        'Certificates that validate the technologies and practices I work '
        'with daily.',
    'certs.viewCertificate': 'View Certificate',

    // ── Courses ──────────────────────────────────────────────────────────
    'courses.eyebrow': 'Always learning',
    'courses.title': 'Courses',
    'courses.subtitle':
        'Self-driven training I completed to sharpen Flutter, architecture, '
        'and full-stack skills.',
    'courses.viewCourse': 'View Course',
    'courses.badge.course': 'COURSE',
    'courses.badge.cert': 'CERT',

    // ── Education ────────────────────────────────────────────────────────
    'education.eyebrow': 'Academic background',
    'education.title': 'Education',
    'education.subtitle':
        'Formal training that grounds my engineering practice.',
    'education.degree': 'Bachelor — Faculty of Computers and Information',
    'education.university': 'Tanta University, Tanta, Egypt',
    'education.dates': 'Oct 2023 – Aug 2027',

    // ── Contact ──────────────────────────────────────────────────────────
    'contact.eyebrow': "Let's connect",
    'contact.title': 'Contact',
    'contact.subtitle':
        "Open to Flutter roles, freelance projects, and collaborations. I'll "
        'get back within a day.',
    'contact.heading': "Let's build something together",
    'contact.body':
        'Have a Flutter project in mind, or want to chat about a role? '
        "I'm one message away.",
    'contact.callMe': 'Call me',
    'contact.emailMe': 'Email me',
    'contact.whatsapp': 'WhatsApp',
    'contact.linkedin': 'LinkedIn',
    'contact.github': 'GitHub',
    'contact.email': 'Email',

    // ── Contact form ─────────────────────────────────────────────────────
    'form.prompt': 'Or drop me a quick message',
    'form.name': 'Your name',
    'form.email': 'Your email',
    'form.message': 'Your message',
    'form.nameField': 'Name',
    'form.emailField': 'Email',
    'form.messageField': 'Message',
    'form.required': '{field} is required',
    'form.invalidEmail': 'That email address looks incomplete — check for a '
        'typo (e.g. name@example.com).',
    'form.send': 'Send message',
    'form.sending': 'Sending…',
    'form.successTitle': 'Got it — message received!',
    'form.successBody': "I'll get back to you in under 24 hours.",
    'form.fallbackWhatsapp': 'Send it on WhatsApp instead',

    // ── Pre-footer CTA ───────────────────────────────────────────────────
    'cta.available': 'Available now',
    'cta.headline': 'Got a Flutter project in mind?',
    'cta.body':
        'From Odoo ERP integrations to bilingual multi-tenant apps — '
        "let's hop on a quick call and ship it together.",
    'cta.trust': 'Reply within 24 hours · No commitment',

    // ── Footer ───────────────────────────────────────────────────────────
    'footer.tagline':
        'Mid-Level Flutter Developer crafting production-ready cross-platform '
        'apps.',
    'footer.copyright': 'Crafted with Flutter',
    'footer.builtWith': 'Built with Flutter',
    'footer.hostedOn': 'Hosted on Cloudflare',
    'footer.viewSource': 'View source',
    'footer.lighthouse': 'Open Lighthouse report on PageSpeed Insights',
    'footer.ownerName': 'Mostafa Badr',

    // ── CV modal ─────────────────────────────────────────────────────────
    'cv.title': 'Resume — Mostafa Badr',
    'cv.subtitle': 'Mid-Level Flutter Developer · Odoo ERP Specialist',
    'cv.openInNewTab': 'Open in a new tab',
    'cv.previewUnavailable': 'Preview needs a moment',
    'cv.previewUnavailableHint':
        "If the résumé doesn't appear, your browser may block embedded PDFs — "
        'use Download to open it directly.',

    // ── Command palette ──────────────────────────────────────────────────
    'palette.title': 'Command Palette',
    'palette.hint': 'Type a command or search…',
    'palette.noResults': 'No results',
    'palette.noResultsHint': 'Try a project name, a section, or "contact".',
    'palette.hintNavigate': 'navigate',
    'palette.hintSelect': 'select',
    'palette.hintClose': 'close',
    'palette.goTo': 'Go to {target}',
    'palette.open': 'Open {target}',
    'palette.section': 'Section',
    'palette.project': 'Project',
    'palette.toggleLocale': 'Toggle language',
    'palette.toggleTheme': 'Toggle theme',
    'palette.openWhatsapp': 'Open WhatsApp',
    'palette.sendEmail': 'Send email',
    'palette.localeHint': 'AR ⇄ EN',
    'palette.themeHint': 'Light ⇄ Dark',

    // ── Easter egg ───────────────────────────────────────────────────────
    'konami.title': 'You found the secret! 🚀',
    'konami.body':
        'If you knew the Konami code, you’re my kind of dev. Let’s talk. 😄',
    'konami.dismiss': '(tap anywhere to close)',

    // ── Toggle tooltips ──────────────────────────────────────────────────
    'theme.toLight': 'Switch to light mode',
    'theme.toDark': 'Switch to dark mode',
    'locale.toAr': 'التبديل إلى العربية',
    'locale.toEn': 'Switch to English',
  };

  static const Map<String, String> _ar = {
    // ── Common ───────────────────────────────────────────────────────────
    'common.retry': 'إعادة المحاولة',
    'common.close': 'إغلاق',
    'common.menu': 'القائمة',
    'common.download': 'تحميل',
    'common.backToTop': 'العودة للأعلى',
    'common.or': 'أو',

    // ── Errors ───────────────────────────────────────────────────────────
    'error.offline.title': 'يبدو إنك غير متصل بالإنترنت',
    'error.offline.action':
        'اطمّن على اتصالك بالإنترنت و جرّب تاني — أو كلّمني على واتساب، '
        'بيشتغل حتى لو الشبكة ضعيفة.',
    'error.timeout.title': 'السيرفر أخد وقت طويل في الرد',
    'error.timeout.action':
        'يمكن الاتصال بطيء. جرّب تاني بعد شوية، أو تواصل معايا مباشرة على '
        'واتساب.',
    'error.invalidInput.title': 'في بيانات ما اتقبلتش',
    'error.invalidInput.action':
        'راجع الاسم و الإيميل و الرسالة، و ابعت تاني.',
    'error.rateLimited.title': 'رسائل كتير في وقت قصير',
    'error.rateLimited.action':
        'استنى دقيقة قبل ما تبعت تاني، أو تواصل معايا على واتساب فوراً.',
    'error.endpointUnavailable.title': 'فورم التواصل مش متاح حالياً',
    'error.endpointUnavailable.action':
        'دي مشكلة عندي مش عندك. تواصل معايا على واتساب أو الإيميل — الاتنين '
        'بيوصلوني على طول.',
    'error.serverError.title': 'حصلت مشكلة في سيرفر الرسائل',
    'error.serverError.action':
        'مفيش حاجة ضاعت من عندك. جرّب تاني بعد شوية، أو ابعت نفس الرسالة على '
        'واتساب.',
    'error.unexpectedResponse.title': 'وصلني رد غير متوقع',
    'error.unexpectedResponse.action':
        'مش قادر أأكد إن رسالتك وصلت. للأمان، ابعتها تاني على واتساب أو '
        'الإيميل.',
    'error.cannotOpenLink.title': 'مش قادر أفتح اللينك ده',
    'error.cannotOpenLink.action':
        'المتصفح يمكن يكون منع النافذة المنبثقة. اسمح بالـ pop-ups للموقع ده، '
        'أو انسخ اللينك و افتحه في تاب جديد.',
    'error.unknown.title': 'حصلت مشكلة',
    'error.unknown.action':
        'الرسالة ما اتبعتتش. جرّب تاني، أو تواصل معايا على واتساب.',
    'error.imageUnavailable': 'الصورة مش متاحة',

    // ── Nav ──────────────────────────────────────────────────────────────
    'nav.home': 'الرئيسية',
    'nav.about': 'نبذة عني',
    'nav.skills': 'المهارات',
    'nav.experience': 'الخبرات',
    'nav.projects': 'المشاريع',
    'nav.contact': 'تواصل',
    'nav.hireMe': 'تواصل معي',
    'nav.jumpTo': 'الانتقال إلى',

    // ── Hero ─────────────────────────────────────────────────────────────
    'hero.eyebrow': 'مطور Flutter متوسط الخبرة',
    'hero.roleSuffix': 'Flutter Developer',
    'hero.greeting': 'أهلاً، أنا مصطفى بدر',
    'hero.name': 'مصطفى بدر',
    'hero.role': 'مطور Flutter متوسط الخبرة',
    'hero.tagline':
        'أكثر من سنتين خبرة في بناء تطبيقات Flutter cross-platform بمستوى '
        'إنتاجي — متخصص دلوقتي في تكامل Odoo ERP، Clean Architecture، و تجارب '
        'ثنائية اللغة مع RTL كامل. سلّمت {live} تطبيقات حية مع Sentry observability '
        'و معمارية قابلة للتوسع.',
    'hero.ctaProjects': 'عرض المشاريع',
    'hero.ctaCV': 'تحميل السيرة الذاتية',
    'hero.ctaResume': 'تحميل السيرة الذاتية',
    'hero.ctaScheduleCall': 'احجز Call',
    'hero.ctaTalk': 'تواصل معي',
    'hero.statApps': 'تطبيق منشور',
    'hero.statYears': 'سنوات',
    'hero.statCourses': 'كورس',
    'hero.stat.liveApps': 'تطبيقات منشورة',
    'hero.stat.odoo': 'تطبيقات Odoo',
    'hero.stat.years': 'سنوات خبرة',
    'hero.badge.android': 'أندرويد',
    'hero.badge.ios': 'iOS',
    'hero.badge.web': 'ويب',
    'hero.badge.desktop': 'سطح المكتب',
    'hero.openToWork': 'متاح لفرص جديدة',
    'hero.openToWorkDetail': 'Mid-Level Flutter · عن بُعد من مصر · متاح الآن',

    // ── Sticky stats banner ──────────────────────────────────────────────
    'sticky.liveApps': 'تطبيقات',
    'sticky.liveAppsLong': 'تطبيقات حية',
    'sticky.odoo': 'Odoo',
    'sticky.years': 'سنوات',
    'sticky.available': 'متاح',
    'sticky.availableLong': 'متاح للعمل',

    // ── About ────────────────────────────────────────────────────────────
    'about.eyebrow': 'تعريف بسيط',
    'about.title': 'نبذة عني',
    'about.subtitle':
        'مطور Flutter متوسط الخبرة، أكثر من سنتين في بناء تطبيقات إنتاجية في '
        'مجالات متعددة.',
    'about.icon.bg': 'الخلفية',
    'about.icon.focus': 'التخصص',
    'about.icon.education': 'التعليم',
    'about.icon.languages': 'اللغات',
    'about.background':
        'مطور Flutter بأركز على شحن تطبيقات mobile موثوقة و قابلة للصيانة على '
        'iOS و Android. مرتاح في التعامل مع الـ stack كامل — مسؤول عن جانب '
        'الموبايل و التكامل مع REST APIs من Laravel و Node.js و Firebase و '
        'Supabase و Odoo.',
    'about.focus':
        'Clean Architecture و SOLID و إدارة state قابلة للتوسع '
        '(Bloc/Cubit/Provider/GetX)، و بناء واجهات responsive pixel-perfect.',
    'about.education':
        'بكالوريوس — كلية الحاسبات و الذكاء الاصطناعي، جامعة بني سويف.',
    'about.languages': 'العربية (لغة أم) · الإنجليزية (مستوى احترافي)',
    'about.body1':
        'أنا مصطفى بدر — مطور Flutter متوسط الخبرة، عندي أكثر من سنتين خبرة '
        'عملية في شحن تطبيقات أندرويد و iOS بمستوى إنتاجي. حالياً في فريق '
        'Odoo Apps في Digital Harbor (Golden Odoo Partner) بشتغل على تطبيقات '
        'موبايل enterprise متكاملة مع Odoo 18/19 ERP. قبل كده شحنت تطبيقات لـ '
        'New Touch و Green Line في مجالات العقارات و التجارة الإلكترونية و '
        'ride-hailing.',
    'about.body2':
        'تخصصي: تكامل Odoo ERP (REST + JSON-RPC)، Clean Architecture، '
        'Bloc/Cubit، تجارب ثنائية اللغة مع RTL كامل، و observability احترافي '
        'عبر Sentry. بطبّق SOLID و Design Patterns عشان أقدم منتجات قابلة '
        'للتوسع و الصيانة لفرق طويلة المدى.',
    'about.pill.odoo': '🧩 Odoo ERP Specialist',
    'about.pill.liveApps': '🚀 {live} تطبيقات حية',
    'about.pill.cleanArch': '🧱 Clean Architecture',
    'about.pill.bilingual': '🌐 AR / EN · RTL',
    'about.pill.performance': '⚡ الأداء أولاً',

    // ── Skills ───────────────────────────────────────────────────────────
    'skills.eyebrow': 'ما أقدمه',
    'skills.title': 'المهارات و الأدوات',
    'skills.subtitle':
        'الـ tech stack اللي بستخدمه لشحن تطبيقات موثوقة و سريعة و قابلة '
        'للصيانة.',
    'skills.group.core': 'الأساسيات',
    'skills.group.architecture': 'المعمارية و الـ DI',
    'skills.group.state': 'إدارة الحالة',
    'skills.group.backend': 'الباك إند و الـ APIs',
    'skills.group.mobile': 'مزايا الموبايل',
    'skills.group.tooling': 'أدوات العمل',

    // ── Tools ────────────────────────────────────────────────────────────
    'tools.eyebrow': 'أدوات العمل اليومية',
    'tools.title': 'الأدوات اللي بستخدمها',
    'tools.subtitle':
        'الـ stack اللي بشتغل بيه يومياً — من الـ editor للـ release.',

    // ── Process ──────────────────────────────────────────────────────────
    'process.eyebrow': 'طريقة عملي',
    'process.title': 'من الفكرة للإنتاج',
    'process.subtitle':
        'الخطوات الأربعة اللي ببنيها لما أبدأ feature جديدة أو منتج كامل.',

    // ── Experience ───────────────────────────────────────────────────────
    'experience.eyebrow': 'مسيرتي العملية',
    'experience.title': 'الخبرات العملية',
    'experience.subtitle':
        'الشركات و الفرق اللي شحنت معاها تطبيقات Flutter في الإنتاج.',
    'experience.current': 'حالياً',

    // ── Projects ─────────────────────────────────────────────────────────
    'projects.eyebrow': 'أعمال مختارة',
    'projects.title': 'المشاريع',
    'projects.subtitle':
        'تطبيقات إنتاجية و مشاريع متنوعة — ride-hailing و عقارات و تجارة '
        'إلكترونية و سوشيال و رعاية صحية. اضغط على أي مشروع للتفاصيل.',
    'projects.view': 'عرض',
    'projects.featured': 'مميّز',
    'projects.highlights': 'أبرز النقاط',
    'projects.techStack': 'التقنيات',
    'projects.challenge': 'التحدّي',
    'projects.solution': 'الحل و الأثر',
    'projects.filter.all': 'الكل',
    'projects.cat.erp': 'Odoo · ERP',
    'projects.cat.realEstate': 'عقارات',
    'projects.cat.ecommerce': 'تجارة إلكترونية',
    'projects.cat.superApp': 'سوبر آب',
    'projects.cat.rideHailing': 'خدمات النقل',
    'projects.cat.ar': 'واقع معزز · 3D',
    'projects.playStore': 'فتح في Play Store',
    'projects.appStore': 'فتح في App Store',
    'projects.downloadApk': 'تحميل APK',
    'projects.viewRepo': 'عرض المستودع',
    'projects.website': 'زيارة الموقع',
    'projects.empty': 'لا توجد مشاريع في هذا التصنيف بعد',
    'projects.emptyHint': 'اختر تصنيف تاني عشان تشوف باقي أعمالي.',
    'projects.previousImage': 'الصورة السابقة',
    'projects.nextImage': 'الصورة التالية',

    // ── Certifications ───────────────────────────────────────────────────
    'certs.eyebrow': 'إنجازات معتمدة',
    'certs.title': 'الشهادات',
    'certs.subtitle':
        'شهادات بتأكّد على التقنيات و الممارسات اللي بشتغل بيها يومياً.',
    'certs.viewCertificate': 'عرض الشهادة',

    // ── Courses ──────────────────────────────────────────────────────────
    'courses.eyebrow': 'تعلم مستمر',
    'courses.title': 'الكورسات',
    'courses.subtitle':
        'تدريب ذاتي خلصته لصقل مهاراتي في Flutter و المعمارية و الـ full-stack.',
    'courses.viewCourse': 'عرض الكورس',
    'courses.badge.course': 'كورس',
    'courses.badge.cert': 'شهادة',

    // ── Education ────────────────────────────────────────────────────────
    'education.eyebrow': 'المؤهلات الأكاديمية',
    'education.title': 'التعليم',
    'education.subtitle': 'التدريب الأكاديمي اللي بيؤسس ممارستي الهندسية.',
    'education.degree': 'بكالوريوس — كلية الحاسبات و المعلومات',
    'education.university': 'جامعة طنطا، طنطا، مصر',
    'education.dates': 'أكتوبر 2023 – أغسطس 2027',

    // ── Contact ──────────────────────────────────────────────────────────
    'contact.eyebrow': 'تواصل معي',
    'contact.title': 'تواصل',
    'contact.subtitle':
        'متاح لفرص Flutter و مشاريع freelance و تعاونات. هرد عليك في خلال يوم.',
    'contact.heading': 'يلا نبني حاجة مع بعض',
    'contact.body':
        'عندك مشروع Flutter في بالك، أو عايز نتكلم عن فرصة عمل؟ أنا على بُعد '
        'رسالة.',
    'contact.callMe': 'اتصل بي',
    'contact.emailMe': 'إيميل',
    'contact.whatsapp': 'واتساب',
    'contact.linkedin': 'لينكدإن',
    'contact.github': 'جيت هاب',
    'contact.email': 'إيميل',

    // ── Contact form ─────────────────────────────────────────────────────
    'form.prompt': 'أو ابعتلي رسالة مباشرة',
    'form.name': 'اسمك',
    'form.email': 'الإيميل',
    'form.message': 'الرسالة',
    'form.nameField': 'الاسم',
    'form.emailField': 'الإيميل',
    'form.messageField': 'الرسالة',
    'form.required': '{field} مطلوب',
    'form.invalidEmail':
        'الإيميل ده مش مكتمل — راجع الكتابة (مثال: name@example.com).',
    'form.send': 'إرسال الرسالة',
    'form.sending': 'جاري الإرسال…',
    'form.successTitle': 'تمام، وصلتني رسالتك!',
    'form.successBody': 'هرد عليك في أقل من 24 ساعة.',
    'form.fallbackWhatsapp': 'ابعتها على واتساب بدل كده',

    // ── Pre-footer CTA ───────────────────────────────────────────────────
    'cta.available': 'متاح الآن لمشاريع جديدة',
    'cta.headline': 'عندك مشروع Flutter في بالك؟',
    'cta.body':
        'من تكامل Odoo ERP إلى تطبيقات multi-tenant ثنائية اللغة — يلا نتكلم '
        'و نشوف ازاي نقدر نشحنه.',
    'cta.trust': 'الرد في خلال 24 ساعة · بدون التزام',

    // ── Footer ───────────────────────────────────────────────────────────
    'footer.tagline':
        'مطور Flutter متوسط الخبرة — بصنع تطبيقات cross-platform جاهزة '
        'للإنتاج.',
    'footer.copyright': 'مصنوع بـ Flutter',
    'footer.builtWith': 'مبني بـ Flutter',
    'footer.hostedOn': 'مستضاف على Cloudflare',
    'footer.viewSource': 'الكود مفتوح',
    'footer.lighthouse': 'افتح تقرير Lighthouse على PageSpeed Insights',
    'footer.ownerName': 'مصطفى بدر',

    // ── CV modal ─────────────────────────────────────────────────────────
    'cv.title': 'السيرة الذاتية — مصطفى بدر',
    'cv.subtitle': 'Mid-Level Flutter Developer · Odoo ERP Specialist',
    'cv.openInNewTab': 'فتح في تاب جديد',
    'cv.previewUnavailable': 'المعاينة محتاجة لحظة',
    'cv.previewUnavailableHint':
        'لو السيرة الذاتية ما ظهرتش، يمكن المتصفح بيمنع عرض ملفات PDF مدمجة — '
        'استخدم زر التحميل عشان تفتحها مباشرة.',

    // ── Command palette ──────────────────────────────────────────────────
    'palette.title': 'لوحة الأوامر',
    'palette.hint': 'ابحث أو اختر إجراء…',
    'palette.noResults': 'لا توجد نتائج',
    'palette.noResultsHint': 'جرّب اسم مشروع، أو قسم، أو "تواصل".',
    'palette.hintNavigate': 'navigate',
    'palette.hintSelect': 'select',
    'palette.hintClose': 'close',
    'palette.goTo': 'الذهاب إلى {target}',
    'palette.open': 'فتح {target}',
    'palette.section': 'قسم',
    'palette.project': 'مشروع',
    'palette.toggleLocale': 'تبديل اللغة',
    'palette.toggleTheme': 'تبديل الثيم',
    'palette.openWhatsapp': 'تواصل واتساب',
    'palette.sendEmail': 'إرسال إيميل',
    'palette.localeHint': 'AR ⇄ EN',
    'palette.themeHint': 'Light ⇄ Dark',

    // ── Easter egg ───────────────────────────────────────────────────────
    'konami.title': 'لقيت السرّ! 🚀',
    'konami.body':
        'لو وصلت لـ Konami code، أنت مطور حقيقي. خلاص محتاج اعمل معاك call. 😄',
    'konami.dismiss': '(اضغط في أي مكان للإغلاق)',

    // ── Toggle tooltips ──────────────────────────────────────────────────
    'theme.toLight': 'التبديل إلى الوضع الفاتح',
    'theme.toDark': 'التبديل إلى الوضع الداكن',
    'locale.toAr': 'التبديل إلى العربية',
    'locale.toEn': 'Switch to English',
  };
}

/// Fills `{placeholder}` slots in a translated string.
///
/// Keeps interpolation out of the maps so a translator can move the slot to
/// wherever the sentence needs it — Arabic word order rarely matches English.
extension TrFormat on String {
  String withArgs(Map<String, String> args) {
    var result = this;
    args.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }
}
