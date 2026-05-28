import 'package:flutter/material.dart';

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
class L18n {
  final String en;
  final String ar;
  const L18n(this.en, this.ar);

  String t(BuildContext context) => isArabic(context) ? ar : en;
}

/// Static UI strings (nav labels, buttons, section header eyebrows/subtitles).
/// Use [Tr.k] to access them in widgets.
class Tr {
  static String k(BuildContext context, String key) {
    final isAr = isArabic(context);
    final map = isAr ? _ar : _en;
    return map[key] ?? key;
  }

  static const Map<String, String> _en = {
    // Nav
    'nav.home': 'Home',
    'nav.about': 'About',
    'nav.skills': 'Skills',
    'nav.experience': 'Experience',
    'nav.projects': 'Projects',
    'nav.contact': 'Contact',
    'nav.hireMe': 'Hire me',

    // Hero
    'hero.eyebrow': 'Mid-Level Flutter Developer',
    'hero.roleSuffix': 'Flutter Developer',
    'hero.greeting': "Hi, I'm",
    'hero.name': 'Mostafa Badr',
    'hero.tagline':
        'I build production-grade cross-platform apps with Flutter — clean architecture, smooth UX, and real-world integrations.',
    'hero.ctaProjects': 'View Projects',
    'hero.ctaCV': 'Download CV',
    'hero.statApps': 'Live apps',
    'hero.statYears': 'Years',
    'hero.statCourses': 'Courses',

    // About
    'about.eyebrow': 'About me',
    'about.title': 'About',
    'about.subtitle':
        'Mid-Level Flutter Developer with 2+ years building production apps across multiple domains.',
    'about.icon.bg': 'Background',
    'about.icon.focus': 'Focus',
    'about.icon.education': 'Education',
    'about.icon.languages': 'Languages',
    'about.background':
        'Flutter developer focused on shipping reliable, maintainable cross-platform mobile apps. Comfortable across the full stack — owning the mobile side and integrating with REST APIs from Laravel, Node.js, Firebase, Supabase, and Odoo.',
    'about.focus':
        'Clean Architecture, SOLID, scalable state management (Bloc/Cubit/Provider/GetX), and shipping pixel-perfect responsive UIs.',
    'about.education':
        'B.Sc. — Faculty of Computers and Artificial Intelligence, Beni-Suef University.',
    'about.languages': 'Arabic (Native) · English (Professional)',

    // Skills
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

    // Experience
    'experience.eyebrow': 'Where I worked',
    'experience.title': 'Work Experience',
    'experience.subtitle':
        'Companies and teams I shipped production Flutter apps with.',

    // Projects
    'projects.eyebrow': 'Selected work',
    'projects.title': 'Projects',
    'projects.subtitle':
        'Production apps and showcase projects across ride-hailing, real estate, e-commerce, social, and healthcare. Tap any project to explore.',
    'projects.view': 'View',
    'projects.highlights': 'HIGHLIGHTS',
    'projects.techStack': 'TECH STACK',
    'projects.filter.all': 'All',
    'projects.cat.erp': 'Odoo · ERP',
    'projects.cat.realEstate': 'Real Estate',
    'projects.cat.ecommerce': 'E-commerce',
    'projects.cat.superApp': 'Super App',
    'projects.cat.rideHailing': 'Ride-hailing',
    'projects.playStore': 'Open in Play Store',
    'projects.appStore': 'Open in App Store',
    'projects.downloadApk': 'Download APK',
    'projects.viewRepo': 'View Repo',

    // Certifications
    'certs.eyebrow': 'Recognised work',
    'certs.title': 'Certifications',
    'certs.subtitle':
        'Certificates that validate the technologies and practices I work with daily.',
    'certs.viewCertificate': 'View Certificate',

    // Courses
    'courses.eyebrow': 'Always learning',
    'courses.title': 'Courses',
    'courses.subtitle':
        'Self-driven training I completed to sharpen Flutter, architecture, and full-stack skills.',
    'courses.viewCourse': 'View Course',
    'courses.badge.course': 'COURSE',
    'courses.badge.cert': 'CERT',

    // Education
    'education.eyebrow': 'Academic background',
    'education.title': 'Education',
    'education.subtitle':
        'Formal training that grounds my engineering practice.',

    // Contact
    'contact.eyebrow': "Let's connect",
    'contact.title': 'Contact',
    'contact.subtitle':
        "Open to Flutter roles, freelance projects, and collaborations. I'll get back within a day.",
    'contact.callMe': 'Call me',
    'contact.emailMe': 'Email me',
    'contact.whatsapp': 'WhatsApp',
    'contact.linkedin': 'LinkedIn',
    'contact.github': 'GitHub',

    // Footer
    'footer.tagline':
        'Mid-Level Flutter Developer crafting production-ready cross-platform apps.',
    'footer.copyright': 'Crafted with Flutter',

    // Toggle tooltips
    'theme.toLight': 'Switch to light mode',
    'theme.toDark': 'Switch to dark mode',
    'locale.toAr': 'التبديل إلى العربية',
    'locale.toEn': 'Switch to English',
  };

  static const Map<String, String> _ar = {
    // Nav
    'nav.home': 'الرئيسية',
    'nav.about': 'نبذة عني',
    'nav.skills': 'المهارات',
    'nav.experience': 'الخبرات',
    'nav.projects': 'المشاريع',
    'nav.contact': 'تواصل',
    'nav.hireMe': 'تواصل معي',

    // Hero
    'hero.eyebrow': 'مطور Flutter متوسط الخبرة',
    'hero.roleSuffix': 'Flutter Developer',
    'hero.greeting': 'أهلاً، أنا',
    'hero.name': 'مصطفى بدر',
    'hero.tagline':
        'أبني تطبيقات cross-platform بمستوى إنتاجي باستخدام Flutter — بمعمارية نظيفة، تجربة سلسة، و تكاملات حقيقية مع الواقع.',
    'hero.ctaProjects': 'عرض المشاريع',
    'hero.ctaCV': 'تحميل السيرة الذاتية',
    'hero.statApps': 'تطبيق منشور',
    'hero.statYears': 'سنوات',
    'hero.statCourses': 'كورس',

    // About
    'about.eyebrow': 'تعريف بسيط',
    'about.title': 'نبذة عني',
    'about.subtitle':
        'مطور Flutter متوسط الخبرة، أكثر من سنتين في بناء تطبيقات إنتاجية في مجالات متعددة.',
    'about.icon.bg': 'الخلفية',
    'about.icon.focus': 'التخصص',
    'about.icon.education': 'التعليم',
    'about.icon.languages': 'اللغات',
    'about.background':
        'مطور Flutter بأركز على شحن تطبيقات mobile موثوقة و قابلة للصيانة على iOS و Android. مرتاح في التعامل مع الـ stack كامل — مسؤول عن جانب الموبايل و التكامل مع REST APIs من Laravel و Node.js و Firebase و Supabase و Odoo.',
    'about.focus':
        'Clean Architecture و SOLID و إدارة state قابلة للتوسع (Bloc/Cubit/Provider/GetX)، و بناء واجهات responsive pixel-perfect.',
    'about.education':
        'بكالوريوس — كلية الحاسبات و الذكاء الاصطناعي، جامعة بني سويف.',
    'about.languages': 'العربية (لغة أم) · الإنجليزية (مستوى احترافي)',

    // Skills
    'skills.eyebrow': 'ما أقدمه',
    'skills.title': 'المهارات و الأدوات',
    'skills.subtitle':
        'الـ tech stack اللي بستخدمه لشحن تطبيقات موثوقة و سريعة و قابلة للصيانة.',
    'skills.group.core': 'الأساسيات',
    'skills.group.architecture': 'المعمارية و الـ DI',
    'skills.group.state': 'إدارة الحالة',
    'skills.group.backend': 'الباك إند و الـ APIs',
    'skills.group.mobile': 'مزايا الموبايل',
    'skills.group.tooling': 'أدوات العمل',

    // Experience
    'experience.eyebrow': 'مسيرتي العملية',
    'experience.title': 'الخبرات العملية',
    'experience.subtitle':
        'الشركات و الفرق اللي شحنت معاها تطبيقات Flutter في الإنتاج.',

    // Projects
    'projects.eyebrow': 'أعمال مختارة',
    'projects.title': 'المشاريع',
    'projects.subtitle':
        'تطبيقات إنتاجية و مشاريع متنوعة — ride-hailing و عقارات و تجارة إلكترونية و سوشيال و رعاية صحية. اضغط على أي مشروع للتفاصيل.',
    'projects.view': 'عرض',
    'projects.highlights': 'أبرز النقاط',
    'projects.techStack': 'التقنيات',
    'projects.filter.all': 'الكل',
    'projects.cat.erp': 'Odoo · ERP',
    'projects.cat.realEstate': 'عقارات',
    'projects.cat.ecommerce': 'تجارة إلكترونية',
    'projects.cat.superApp': 'سوبر آب',
    'projects.cat.rideHailing': 'ride-hailing',
    'projects.playStore': 'فتح في Play Store',
    'projects.appStore': 'فتح في App Store',
    'projects.downloadApk': 'تحميل APK',
    'projects.viewRepo': 'عرض المستودع',

    // Certifications
    'certs.eyebrow': 'إنجازات معتمدة',
    'certs.title': 'الشهادات',
    'certs.subtitle':
        'شهادات بتأكّد على التقنيات و الممارسات اللي بشتغل بيها يومياً.',
    'certs.viewCertificate': 'عرض الشهادة',

    // Courses
    'courses.eyebrow': 'تعلم مستمر',
    'courses.title': 'الكورسات',
    'courses.subtitle':
        'تدريب ذاتي خلصته لصقل مهاراتي في Flutter و المعمارية و الـ full-stack.',
    'courses.viewCourse': 'عرض الكورس',
    'courses.badge.course': 'كورس',
    'courses.badge.cert': 'شهادة',

    // Education
    'education.eyebrow': 'المؤهلات الأكاديمية',
    'education.title': 'التعليم',
    'education.subtitle': 'التدريب الأكاديمي اللي بيؤسس ممارستي الهندسية.',

    // Contact
    'contact.eyebrow': 'تواصل معي',
    'contact.title': 'تواصل',
    'contact.subtitle':
        'متاح لفرص Flutter و مشاريع freelance و تعاونات. هرد عليك في خلال يوم.',
    'contact.callMe': 'اتصل بي',
    'contact.emailMe': 'إيميل',
    'contact.whatsapp': 'واتساب',
    'contact.linkedin': 'لينكدإن',
    'contact.github': 'جيت هاب',

    // Footer
    'footer.tagline':
        'مطور Flutter متوسط الخبرة — بصنع تطبيقات cross-platform جاهزة للإنتاج.',
    'footer.copyright': 'مصنوع بـ Flutter',

    // Toggle tooltips
    'theme.toLight': 'التبديل إلى الوضع الفاتح',
    'theme.toDark': 'التبديل إلى الوضع الداكن',
    'locale.toAr': 'التبديل إلى العربية',
    'locale.toEn': 'Switch to English',
  };
}
