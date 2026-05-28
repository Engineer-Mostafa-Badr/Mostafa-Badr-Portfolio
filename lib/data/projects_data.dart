import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/models/project_item.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';

const _live = L18n('Live · iOS & Android', 'منشور · iOS و Android');

/// All portfolio projects in display order (top → bottom).
/// Featured items get a "FEATURED" badge on their cover.
const List<ProjectItem> projectsData = [
  ProjectItem(
    featured: true,
    categories: [ProjectCategory.erp],
    title: L18n(
      'Al Rajhi Hajj — Pilgrimage Services Platform',
      'الراجحي للحج — منصة خدمات الحجاج',
    ),
    shortDescription: L18n(
      'A unified Flutter app for Al Rajhi pilgrims and supervisors — covers the full Hajj journey from application to completion. Integrated with an Odoo ERP backend over REST APIs. Bilingual (Arabic / English) with Hijri & Gregorian calendars. Live on the App Store and Google Play.',
      'تطبيق Flutter موحّد لحجاج و مشرفي الراجحي — يغطي رحلة الحج كاملةً من التقديم للانتهاء. متكامل مع باك إند Odoo ERP عبر REST APIs. ثنائي اللغة (عربي / إنجليزي) مع تقويم هجري و ميلادي. منشور على App Store و Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'RH',
      appName: L18n('Al Rajhi Hajj', 'الراجحي للحج'),
      subtitle: L18n(
        'End-to-end Hajj services for pilgrims & supervisors.',
        'خدمات حج متكاملة للحجاج و المشرفين.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.assignment_outlined,
          label: L18n('Application', 'التقديم'),
        ),
        ProjectFeature(
          icon: Icons.mosque_outlined,
          label: L18n('Prayer Times', 'مواقيت الصلاة'),
        ),
        ProjectFeature(
          icon: Icons.place_outlined,
          label: L18n('Locations', 'المواقع'),
        ),
        ProjectFeature(
          icon: Icons.qr_code_scanner,
          label: L18n('QR / NFC', 'QR / NFC'),
        ),
        ProjectFeature(
          icon: Icons.translate,
          label: L18n('AR · EN', 'عربي · إنجليزي'),
        ),
        ProjectFeature(
          icon: Icons.auto_stories_outlined,
          label: L18n('Worship', 'العبادات'),
        ),
      ],
      gradient: [Color(0xFF0F172A), Color(0xFF1E3A5F), Color(0xFF1E40AF)],
      accent: Color(0xFFFBBF24),
      coverImage: 'assets/images/haj/cover.png',
    ),
    images: [
      'assets/images/haj/1.png',
      'assets/images/haj/2.png',
      'assets/images/haj/3.png',
      'assets/images/haj/4.png',
      'assets/images/haj/5.png',
      'assets/images/haj/6.png',
      'assets/images/haj/7.png',
      'assets/images/haj/8.png',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=sa.alrajhi.hajj&hl=en-US',
    repoUrl: 'https://apps.apple.com/sa/app/alrajhi-hajj/id6758082821',
    techs: ['Flutter', 'GetX', 'Odoo (ERP Backend)', 'Firebase', 'Dio'],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'Shipped to both Apple App Store and Google Play.',
        'منشور على Apple App Store و Google Play.',
      ),
      L18n(
        'Two roles in one app — pilgrims (application, services, worship corner) and supervisors (QR/NFC, placement, attendance).',
        'دورين في تطبيق واحد — الحجاج (التقديم و الخدمات و ركن العبادات) و المشرفين (QR/NFC و التوزيع و الحضور).',
      ),
      L18n(
        'Integrated with an Odoo ERP backend over REST APIs — handling applications, pilgrim records, and supervisor workflows.',
        'متكامل مع باك إند Odoo ERP عبر REST APIs — يتعامل مع طلبات التقديم و سجلات الحجاج و رحلات المشرفين.',
      ),
      L18n(
        'Multi-step application with auto-save, skeleton loading, staggered animations, and seamless RTL/LTR experience.',
        'تقديم متعدد الخطوات مع حفظ تلقائي و skeleton loading و حركات متدرجة و دعم سلس لـ RTL/LTR.',
      ),
      L18n(
        'Full Arabic/English support with both Hijri and Gregorian calendar pickers.',
        'دعم كامل للعربية و الإنجليزية مع تقويم هجري و ميلادي.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.realEstate],
    title: L18n('Alawaly – Real Estate', 'العوالي — تطبيق عقاري'),
    shortDescription: L18n(
      'Real estate sales & rental platform with OTP authentication, multi-role accounts, admin dashboard, and bank financing integration. Live on the App Store and Google Play.',
      'منصة بيع و تأجير عقارية مع تسجيل OTP و حسابات متعددة الأدوار و لوحة إدارة و تكامل مع التمويل البنكي. منشور على App Store و Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'AL',
      appName: L18n('Alawaly', 'العوالي'),
      subtitle: L18n(
        'Real-estate platform for buying, renting & financing.',
        'منصة عقارية للشراء و التأجير و التمويل.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.home_work_outlined,
          label: L18n('Listings', 'العروض'),
        ),
        ProjectFeature(
          icon: Icons.map_outlined,
          label: L18n('Map Search', 'بحث بالخريطة'),
        ),
        ProjectFeature(
          icon: Icons.account_balance_outlined,
          label: L18n('Financing', 'تمويل'),
        ),
        ProjectFeature(
          icon: Icons.handshake_outlined,
          label: L18n('Multi-role', 'أدوار متعددة'),
        ),
      ],
      gradient: [Color(0xFF064E3B), Color(0xFF0F766E), Color(0xFF10B981)],
      accent: Color(0xFF34D399),
      coverImage: 'assets/images/alawaly/cover.png',
    ),
    images: [
      'assets/images/alawaly/المشاريع.png',
      'assets/images/alawaly/تفاصيل المشروع.png',
      'assets/images/alawaly/تفاصيل الوحدة.png',
      'assets/images/alawaly/نتائج البحث علي الخريطة2.png',
      'assets/images/alawaly/sign up2.png',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=com.bim.alawaly&hl=en-US',
    repoUrl:
        'https://apps.apple.com/us/app/alawaly-%D8%A7%D9%84%D8%B9%D9%88%D8%A7%D9%84%D9%8A/id6741167067',
    techs: ['Flutter', 'Laravel'],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'Shipped to both Apple App Store and Google Play with multi-role onboarding (clients, owners, agents).',
        'منشور على Apple App Store و Google Play مع onboarding متعدد الأدوار (عملاء، ملاك، وكلاء).',
      ),
      L18n(
        'Financing flow with bank selection and role-based dashboards.',
        'رحلة تمويل مع اختيار البنك و dashboards حسب الدور.',
      ),
      L18n(
        'Multi-language search paired with map-based property filtering.',
        'بحث متعدد اللغات مع فلترة العقارات على الخريطة.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.superApp],
    title: L18n('FortyNine – 49-in-1 Super App', 'FortyNine — سوبر آب 49 في 1'),
    shortDescription: L18n(
      'A super-app bundling 49+ services in a single platform — social feed, doctor booking, matchmaking, delivery, marketplace, video & Reels, and chat. Contributed to several modules within the FortyNine ecosystem.',
      'سوبر آب يضمّ أكثر من 49 خدمة في منصة واحدة — feed سوشيال و حجز أطباء و تعارف و توصيل و marketplace و فيديو و Reels و شات. ساهمت في عدة modules ضمن منظومة FortyNine.',
    ),
    cover: ProjectCoverSpec(
      logoText: '49',
      appName: L18n('FortyNine', 'FortyNine'),
      subtitle: L18n(
        'A super-app bundling 49+ services in one platform.',
        'سوبر آب يضم 49+ خدمة في منصة واحدة.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.directions_car_filled_outlined,
          label: L18n('Rides', 'رحلات'),
        ),
        ProjectFeature(
          icon: Icons.restaurant_outlined,
          label: L18n('Food', 'طعام'),
        ),
        ProjectFeature(
          icon: Icons.medical_services_outlined,
          label: L18n('Health', 'صحة'),
        ),
        ProjectFeature(
          icon: Icons.local_shipping_outlined,
          label: L18n('Delivery', 'توصيل'),
        ),
        ProjectFeature(
          icon: Icons.chat_bubble_outline,
          label: L18n('Chat', 'شات'),
        ),
        ProjectFeature(
          icon: Icons.play_circle_outline,
          label: L18n('Reels', 'Reels'),
        ),
      ],
      gradient: [Color(0xFF7F1D1D), Color(0xFFB91C1C), Color(0xFFEF4444)],
      accent: Color(0xFFFCA5A5),
      coverImage: 'assets/images/fortynine/cover.png',
    ),
    images: [
      'assets/images/fortynine/1.png',
      'assets/images/fortynine/2.png',
      'assets/images/fortynine/3.png',
      'assets/images/fortynine/4.png',
      'assets/images/fortynine/5.png',
      'assets/images/fortynine/6.png',
      'assets/images/fortynine/7.png',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=com.fourtyninehub.fourtynine&hl=en-US',
    repoUrl: 'https://apps.apple.com/us/app/49-app/id1632305652',
    techs: ['Flutter', 'Firebase'],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'Live super-app combining 49+ services in one platform — shipped on both iOS and Android.',
        'سوبر آب منشور يضم أكثر من 49 خدمة في منصة واحدة — على iOS و Android.',
      ),
      L18n(
        'Built modules across social feed, chat, video/Reels, and booking flows.',
        'بنيت modules تشمل feed السوشيال و الشات و Video/Reels و رحلات الحجز.',
      ),
      L18n(
        'Worked within a large modular architecture serving multiple verticals.',
        'اشتغلت ضمن معمارية modular كبيرة تخدم قطاعات متعددة.',
      ),
    ],
  ),
  ProjectItem(
    featured: true,
    categories: [ProjectCategory.erp],
    title: L18n(
      'Saqqar Mobile — Odoo Operations Copilot',
      'صقّار موبايل — مساعد عمليات Odoo بالذكاء الاصطناعي',
    ),
    shortDescription: L18n(
      'Native mobile companion to saqqaar.com — an AI agent that operates Odoo ERP via natural language. Live tools (Odoo XML-RPC, PostgreSQL, GitHub) with every risky change gated behind explicit approval. Voice dictation via Whisper, share-to-app from WhatsApp/Photos, encrypted on-device vault, and inline approvals. Currently in Google Play review.',
      'تطبيق موبايل native مكمّل لـ saqqaar.com — وكيل ذكاء اصطناعي بيشغّل Odoo ERP بلغة طبيعية. أدوات حية (Odoo XML-RPC و PostgreSQL و GitHub) مع كل تغيير حساس بيمر على موافقة صريحة. إملاء صوتي عبر Whisper، و share من واتساب/الصور، و vault مشفّر على الجهاز، و موافقات inline. حالياً في مرحلة مراجعة Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'SQ',
      appName: L18n('Saqqar', 'صقّار'),
      subtitle: L18n(
        'AI copilot that operates Odoo ERP from your phone.',
        'مساعد ذكاء اصطناعي بيشغّل Odoo ERP من موبايلك.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.psychology_outlined,
          label: L18n('AI Agent', 'وكيل AI'),
        ),
        ProjectFeature(
          icon: Icons.mic_none_outlined,
          label: L18n('Voice · Whisper', 'صوت · Whisper'),
        ),
        ProjectFeature(
          icon: Icons.lock_outlined,
          label: L18n('Secure Vault', 'Vault مشفّر'),
        ),
        ProjectFeature(
          icon: Icons.verified_user_outlined,
          label: L18n('Approvals', 'موافقات'),
        ),
        ProjectFeature(
          icon: Icons.share_outlined,
          label: L18n('Share Intent', 'مشاركة'),
        ),
        ProjectFeature(
          icon: Icons.translate,
          label: L18n('AR · EN · RTL', 'عربي · إنجليزي · RTL'),
        ),
      ],
      gradient: [Color(0xFF1F3C88), Color(0xFF06B6D4), Color(0xFF8B5CF6)],
      accent: Color(0xFF22D3EE),
      coverImage: 'assets/images/saqqar/cover.png',
    ),
    images: [
      'assets/images/saqqar/Sign-In-Screen.png',
      'assets/images/saqqar/Chats-Screen.png',
      'assets/images/saqqar/Anser-Screen.png',
      'assets/images/saqqar/Account-Screen.png',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=sa.com.digitalharbor.saqqar',
    repoUrl: 'https://saqqaar.com',
    techs: [
      'Flutter',
      'Bloc / Cubit',
      'go_router',
      'Dio',
      'Odoo (ERP Backend)',
      'Sentry',
    ],
    statusLabel: L18n('In Google Play Review', 'تحت مراجعة Google Play'),
    statusColor: Color(0xFFFBBF24),
    impactHighlights: [
      L18n(
        'AI agent operating Odoo ERP via natural language — Odoo XML-RPC, PostgreSQL, server shell, and GitHub as live tools.',
        'وكيل AI بيشغّل Odoo ERP بلغة طبيعية — Odoo XML-RPC و PostgreSQL و server shell و GitHub كأدوات حية.',
      ),
      L18n(
        'Voice dictation via server-side Whisper (Arabic + English + auto code-switch) with on-device recording and 2-min cap.',
        'إملاء صوتي عبر Whisper على السيرفر (عربي + إنجليزي + code-switch تلقائي) مع تسجيل على الجهاز و حد أقصى دقيقتين.',
      ),
      L18n(
        'Share intent from WhatsApp, Photos, Files (ACTION_SEND / ACTION_SEND_MULTIPLE) with full-screen picker overlay.',
        'استقبال share من واتساب و الصور و الملفات (ACTION_SEND / ACTION_SEND_MULTIPLE) مع picker overlay يغطي الشاشة كاملة.',
      ),
      L18n(
        'Schema-driven credentials vault with Test Connection — secret labels and helpers flip dynamically from the server schema.',
        'Vault للبيانات الحساسة schema-driven مع Test Connection — labels و helpers تتغير ديناميكياً من schema السيرفر.',
      ),
      L18n(
        'Inline approval cards in chat — every risky change gated behind explicit user approval, with per-conversation pulse-dot.',
        'بطاقات موافقة inline داخل الشات — كل تغيير حساس مربوط بموافقة صريحة من المستخدم، مع pulse-dot لكل محادثة.',
      ),
      L18n(
        'Dark + Light themes, English + Arabic with full RTL mirroring, Sentry crash reporting with noise filtering.',
        'ثيمات داكنة و فاتحة، إنجليزي و عربي مع RTL كامل، و Sentry لمتابعة الأخطاء مع فلترة الـ noise.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.erp],
    title: L18n(
      'Customer Visits — Field Sales GPS Tracker',
      'زيارات العملاء — تتبّع مبيعات ميداني بالـ GPS',
    ),
    shortDescription: L18n(
      'Field sales companion — sales reps check-in/out at customer locations with live foreground GPS tracking, while managers monitor the team on a live map. Backend: Odoo 19 custom module. Bilingual (Arabic default + English), with offline queue and battery-aware tracking. Currently in Google Play review.',
      'تطبيق ميداني لمندوبي المبيعات — Check-in/Check-out عند العملاء مع تتبّع GPS لايف أثناء استخدام التطبيق، و المديرين بيتابعوا الفريق على الخريطة. الباك إند Odoo 19 (موديول مخصّص). ثنائي اللغة (عربي افتراضي + إنجليزي) مع offline queue و توفير بطارية. حالياً في مرحلة مراجعة Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'CV',
      appName: L18n('Customer Visits', 'زيارات العملاء'),
      subtitle: L18n(
        'GPS-verified field visits powered by Odoo.',
        'زيارات ميدانية بتتبّع GPS و باك إند Odoo.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.where_to_vote_outlined,
          label: L18n('Check-in/out', 'دخول/خروج'),
        ),
        ProjectFeature(
          icon: Icons.my_location_outlined,
          label: L18n('Live GPS', 'GPS لايف'),
        ),
        ProjectFeature(
          icon: Icons.map_outlined,
          label: L18n('Live Map', 'خريطة حية'),
        ),
        ProjectFeature(
          icon: Icons.cloud_off_outlined,
          label: L18n('Offline Queue', 'طابور Offline'),
        ),
        ProjectFeature(
          icon: Icons.insights_outlined,
          label: L18n('Manager KPIs', 'لوحة المدير'),
        ),
        ProjectFeature(
          icon: Icons.translate,
          label: L18n('AR · EN · RTL', 'عربي · إنجليزي · RTL'),
        ),
      ],
      gradient: [Color(0xFF1E2A6E), Color(0xFF1E40AF), Color(0xFF3FBFD9)],
      accent: Color(0xFF3FBFD9),
      coverImage: 'assets/images/vistis/cover.png',
    ),
    images: [
      'assets/images/vistis/Screenshot_20260528_092028.png',
      'assets/images/vistis/Screenshot_20260528_092118.png',
      'assets/images/vistis/Screenshot_20260528_092145.png',
      'assets/images/vistis/Screenshot_20260528_092217.png',
      'assets/images/vistis/Screenshot_20260528_092349.png',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=net.digitalharbor.visits',
    repoUrl:
        'https://play.google.com/store/apps/details?id=net.digitalharbor.visits',
    techs: [
      'Flutter',
      'Bloc / Cubit',
      'go_router',
      'Dio',
      'Odoo 19 (ERP Backend)',
      'OpenStreetMap',
      'geolocator',
      'get_it',
    ],
    statusLabel: L18n('In Google Play Review', 'تحت مراجعة Google Play'),
    statusColor: Color(0xFFFBBF24),
    impactHighlights: [
      L18n(
        'Production field-sales app — sales reps check-in/out at customer locations with GPS verification against the customer site.',
        'تطبيق إنتاجي للمبيعات الميدانية — المندوبين بيعملوا Check-in/Check-out عند العملاء مع التحقق من المسافة لمقر العميل.',
      ),
      L18n(
        'Live foreground tracking — 30-second ticker + 5-meter distance filter + 2-minute heartbeat; auto-stops when app backgrounds to honor the privacy declaration.',
        'تتبّع لايف foreground — كل 30 ثانية + فلتر مسافة 5 متر + heartbeat كل دقيقتين؛ يقف تلقائياً لما التطبيق يدخل background احتراماً لإقرار الخصوصية.',
      ),
      L18n(
        "Manager Dashboard with KPIs and a live map of active employees, plus Nearby Employees view (within 10m of a customer, refreshed every 10s).",
        'لوحة مدير بـ KPIs و خريطة لايف للموظفين النشطين، مع شاشة Nearby Employees (الموظفين على بُعد 10م من العميل، تحدّث كل 10ث).',
      ),
      L18n(
        'Offline queue — check-in/out actions persist locally if the network drops and auto-sync once it returns.',
        'طابور Offline — لو الـ check-in/out اتعمل بدون نت يتخزّن محلياً و يتبعت تلقائياً لما النت يرجع.',
      ),
      L18n(
        'Role-aware navigation — User shell for reps (own visits only), Manager shell with tabs (all customers + employees + dashboard).',
        'تنقّل حسب الدور — User shell للمندوب (زياراته بس)، Manager shell بتابات (كل العملاء + الموظفين + الـ dashboard).',
      ),
      L18n(
        'Bilingual (Arabic default + English), Material 3 with Light/Dark/System theme, Persistent Visit Bar with running timer at the bottom of every screen.',
        'ثنائي اللغة (عربي افتراضي + إنجليزي)، Material 3 مع ثيم Light/Dark/System، و Persistent Visit Bar فيه عدّاد وقت الزيارة في كل شاشة.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.erp],
    title: L18n(
      'HR — Multi-tenant Odoo HR Companion',
      'HR — تطبيق الموارد البشرية لـ Odoo متعدد المؤسسات',
    ),
    shortDescription: L18n(
      'Bilingual (Arabic-first, RTL) HR self-service companion to Odoo 18. Multi-tenant: each company points the same app at their own Odoo server on first launch. Employees check-in via geolocation, view payslips, request time-off, browse the company directory, and approve teammates on the move. Backend: custom hr_app REST module. Currently in Google Play review.',
      'تطبيق Self-Service للموارد البشرية ثنائي اللغة (عربي افتراضي، RTL) مكمّل لـ Odoo 18. متعدد المؤسسات: كل شركة بتوجّه نفس التطبيق على سيرفر Odoo بتاعها أول مرة. الموظفين بيعملوا Check-in بالـ GPS، يشوفوا كشوف الراتب، يطلبوا إجازة، يبصّوا على دليل الشركة، و يوافقوا على طلبات الزملاء. الباك إند: موديول hr_app REST خاص. حالياً في مرحلة مراجعة Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'HR',
      appName: L18n('HR Companion', 'الموارد البشرية'),
      subtitle: L18n(
        'Multi-tenant HR self-service for Odoo 18.',
        'خدمة ذاتية للموارد البشرية متعددة المؤسسات لـ Odoo 18.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.dashboard_outlined,
          label: L18n('Dashboard', 'لوحة الرئيسية'),
        ),
        ProjectFeature(
          icon: Icons.fingerprint_outlined,
          label: L18n('Geo Check-in', 'حضور بالـ GPS'),
        ),
        ProjectFeature(
          icon: Icons.beach_access_outlined,
          label: L18n('Time-off', 'إجازات'),
        ),
        ProjectFeature(
          icon: Icons.receipt_long_outlined,
          label: L18n('Payslips', 'كشوف رواتب'),
        ),
        ProjectFeature(
          icon: Icons.fact_check_outlined,
          label: L18n('Approvals', 'موافقات'),
        ),
        ProjectFeature(
          icon: Icons.business_outlined,
          label: L18n('Multi-tenant', 'متعدد المؤسسات'),
        ),
      ],
      gradient: [Color(0xFF0F172A), Color(0xFF1E3A8A), Color(0xFF22D3EE)],
      accent: Color(0xFF60A5FA),
      coverImage: 'assets/images/hr/cover.png',
    ),
    images: [
      'assets/images/hr/Screenshot_1779944675.png',
      'assets/images/hr/Screenshot_1779944727.png',
      'assets/images/hr/Screenshot_1779944642.png',
      'assets/images/hr/Screenshot_1779944740.png',
      'assets/images/hr/Screenshot_1779944715.png',
      'assets/images/hr/Screenshot_1779944657.png',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=net.digitalharbor.hr',
    repoUrl:
        'https://play.google.com/store/apps/details?id=net.digitalharbor.hr',
    techs: [
      'Flutter 3.35',
      'Bloc / Cubit',
      'get_it (DI)',
      'Dio',
      'Odoo 18 (hr_app REST)',
      'flutter_localizations',
      'Sentry',
      'Clean Architecture',
    ],
    statusLabel: L18n('In Google Play Review', 'تحت مراجعة Google Play'),
    statusColor: Color(0xFFFBBF24),
    impactHighlights: [
      L18n(
        'Multi-tenant by design — one binary on the store; each company types its own Odoo server URL on first launch and the app rebuilds against it.',
        'متعدد المؤسسات من البداية — نسخة واحدة على المتجر؛ كل شركة بتدخل URL الـ Odoo بتاعها في أول تشغيل و التطبيق بيشتغل عليها.',
      ),
      L18n(
        'Bilingual with strict locale purity — Arabic (RTL default) and English with full direction flip, Cairo typography, and zero leaked strings between languages.',
        'ثنائي اللغة بصرامة كاملة — عربي (RTL افتراضي) و إنجليزي مع flip كامل للاتجاه، خط Cairo، و صفر تسرّب لنصوص بين اللغتين.',
      ),
      L18n(
        'Six employee self-service flows in one app — Dashboard, Geo-verified Attendance, Time-off requests + balances, Payslips with PDF share, Approvals, and a searchable Company Directory.',
        'ست خدمات ذاتية للموظف في تطبيق واحد — Dashboard، حضور موثّق بالـ GPS، طلبات إجازة + الأرصدة، كشوف رواتب مع مشاركة PDF، الموافقات، و دليل شركة قابل للبحث.',
      ),
      L18n(
        'Hybrid auth — Bearer token for REST endpoints + session cookie captured at login so Odoo /web/image avatars actually load.',
        'مصادقة هجينة — Bearer token للـ REST endpoints + session cookie متلتقط وقت الـ login عشان صور الـ avatars من /web/image تتحمّل صح.',
      ),
      L18n(
        'Clean Architecture (data / domain / presentation) with SafeCubit base class to silence emit-after-close leaks, NetworkResult sealed family, and shared widget library to keep features consistent.',
        'Clean Architecture (data / domain / presentation) مع SafeCubit base class عشان تمنع تسرّب emit-after-close، و NetworkResult sealed family، و مكتبة widgets مشتركة عشان كل feature تبقى متناسقة.',
      ),
      L18n(
        'Production hardening — Sentry crash reporting (DSN dart-defined, never in source), pretty-log interceptor gated behind kReleaseMode, R8 obfuscation, and auto-uploaded debug symbols.',
        'تجهيز للإنتاج — Sentry لمتابعة الأخطاء (DSN عبر dart-define، مش في الكود)، pretty-log interceptor مغلق في الـ release، obfuscation عبر R8، و رفع تلقائي لـ debug symbols.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.ecommerce],
    title: L18n('E-Commerce App', 'تطبيق تجارة إلكترونية'),
    shortDescription: L18n(
      'E-commerce app: products, reviews, cart and real-time syncing via Supabase.',
      'تطبيق تجارة إلكترونية: منتجات و مراجعات و سلة شراء و مزامنة فورية عبر Supabase.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'EC',
      appName: L18n('E-Commerce', 'تجارة إلكترونية'),
      subtitle: L18n(
        'Shop products, browse reviews & checkout in real time.',
        'تسوق منتجات و راجع التقييمات و ادفع فورياً.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.storefront_outlined,
          label: L18n('Products', 'منتجات'),
        ),
        ProjectFeature(
          icon: Icons.shopping_cart_outlined,
          label: L18n('Cart', 'السلة'),
        ),
        ProjectFeature(
          icon: Icons.star_outline_rounded,
          label: L18n('Reviews', 'تقييمات'),
        ),
        ProjectFeature(
          icon: Icons.payment_outlined,
          label: L18n('Payments', 'دفع'),
        ),
      ],
      gradient: [Color(0xFF4C1D95), Color(0xFF6D28D9), Color(0xFFA855F7)],
      accent: Color(0xFFC4B5FD),
      coverImage: 'assets/images/ecommerce/cover.png',
    ),
    images: [
      'assets/images/ecommerce/IMG-20250411-WA0088.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0090.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0096.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0099.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0101.jpg',
      'assets/images/ecommerce/IMG-20250411-WA0104.jpg',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1yba65wJUIX7U2GLL6KZBKq-VDvyL71lK/view?usp=sharing',
    repoUrl: 'https://github.com/Engineer-Mostafa-Badr/E-commerce-App',
    techs: ['Flutter', 'Supabase'],
    statusLabel: L18n('Internal Demo', 'ديمو داخلي'),
    statusColor: Colors.purple,
    impactHighlights: [
      L18n(
        'Realtime cart & inventory powered by Supabase.',
        'سلة شراء و مخزون فوري مدعومين بـ Supabase.',
      ),
      L18n(
        'Reviews, filters, and checkout ready for QA.',
        'تقييمات و فلاتر و checkout جاهزين للاختبار.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.rideHailing],
    title: L18n(
      'Captain Drive – Ride-Hailing Platform',
      'كابتن درايف — منصة طلب رحلات',
    ),
    shortDescription: L18n(
      'Captain Drive connects customers and owners (captains) on a single platform dedicated to passenger trips.',
      'كابتن درايف بيوصّل العملاء بالكباتن في منصة واحدة مخصصة لرحلات الركاب.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'CD',
      appName: L18n('Captain Drive', 'كابتن درايف'),
      subtitle: L18n(
        'Ride-hailing connecting captains & passengers in real time.',
        'طلب رحلات بيوصّل الكباتن بالركاب فورياً.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.local_taxi_outlined,
          label: L18n('Rides', 'رحلات'),
        ),
        ProjectFeature(
          icon: Icons.route_outlined,
          label: L18n('Routes', 'مسارات'),
        ),
        ProjectFeature(
          icon: Icons.payments_outlined,
          label: L18n('Payments', 'مدفوعات'),
        ),
        ProjectFeature(
          icon: Icons.notifications_active_outlined,
          label: L18n('Alerts', 'تنبيهات'),
        ),
      ],
      gradient: [Color(0xFF1E3A8A), Color(0xFF2563EB), Color(0xFF3B82F6)],
      accent: Color(0xFF93C5FD),
      coverImage: 'assets/images/captain_drive/cover.png',
    ),
    images: [
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 75.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 76.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 77.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 84.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 86.png',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 89.png',
    ],
    apkUrl:
        'https://drive.google.com/file/d/1-XcYMLJmfAivH3k5Ny2VG7U4hBrdpc1o/view?usp=sharing',
    repoUrl: 'https://github.com/Engineer-Mostafa-Badr/Captain-Drive',
    techs: ['Flutter', 'Laravel'],
    statusLabel: L18n('Completed', 'مكتمل'),
    statusColor: Colors.blueGrey,
    impactHighlights: [
      L18n(
        'Multi-role ride-hailing flows for captains and passengers.',
        'رحلات ride-hailing متعددة الأدوار للكباتن و الركاب.',
      ),
      L18n(
        'OTP login, payment split, and push notifications shipped.',
        'تسجيل OTP و تقسيم المدفوعات و الإشعارات الفورية شُحنوا.',
      ),
    ],
  ),
];
