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
      coverImage: 'assets/images/haj/cover.webp',
    ),
    images: [
      'assets/images/haj/1.webp',
      'assets/images/haj/2.webp',
      'assets/images/haj/3.webp',
      'assets/images/haj/4.webp',
      'assets/images/haj/5.webp',
      'assets/images/haj/6.webp',
      'assets/images/haj/7.webp',
      'assets/images/haj/8.webp',
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
    featured: true,
    categories: [ProjectCategory.erp],
    title: L18n(
      'Saqqar Mobile — Odoo Operations Copilot',
      'صقّار موبايل — مساعد عمليات Odoo بالذكاء الاصطناعي',
    ),
    shortDescription: L18n(
      'The mobile companion to saqqaar.com — an AI agent that operates Odoo ERP systems. Connect your Odoo environments, then ask in plain language, by typing or voice, for reports, diagnostics or changes. The agent works against the live system and every risky change waits for your explicit approval — in the chat or from Apple Watch. Bilingual with full RTL. Live on the App Store and Google Play.',
      'التطبيق المحمول لـ saqqaar.com — وكيل ذكاء اصطناعي بيشغّل أنظمة Odoo ERP. اربط بيئات Odoo بتاعتك وبعدين اطلب بلغتك العادية، كتابةً أو صوتًا، تقارير أو تشخيصًا أو تعديلات. الوكيل بيشتغل على النظام الحي وأي تغيير حساس بيستنى موافقتك الصريحة — في الشات أو من Apple Watch. ثنائي اللغة مع RTL كامل. منشور على App Store و Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'SQ',
      appName: L18n('Saqqar', 'صقّار'),
      subtitle: L18n(
        'Your Odoo copilot, in your pocket.',
        'مساعدك الذكي لإدارة Odoo من جيبك.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.smart_toy_outlined,
          label: L18n('AI Agent', 'وكيل AI'),
        ),
        ProjectFeature(
          icon: Icons.verified_user_outlined,
          label: L18n('Approvals', 'موافقات'),
        ),
        ProjectFeature(
          icon: Icons.mic_none_outlined,
          label: L18n('Voice', 'صوت'),
        ),
        ProjectFeature(
          icon: Icons.lock_outlined,
          label: L18n('Credentials Vault', 'خزنة الاعتماد'),
        ),
        ProjectFeature(
          icon: Icons.monitor_heart_outlined,
          label: L18n('Business Pulse', 'نبض الأعمال'),
        ),
        ProjectFeature(
          icon: Icons.watch_outlined,
          label: L18n('Apple Watch', 'Apple Watch'),
        ),
      ],
      gradient: [Color(0xFF030712), Color(0xFF1F3C88), Color(0xFF06B6D4)],
      accent: Color(0xFF22D3EE),
      coverImage: 'assets/images/saqqar/cover.webp',
    ),
    images: [
      'assets/images/saqqar/Screenshot_1783481354.webp',
      'assets/images/saqqar/Screenshot_1784388612.webp',
      'assets/images/saqqar/Screenshot_1784388260.webp',
      'assets/images/saqqar/Screenshot_1784388623.webp',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=sa.com.digitalharbor.saqqar',
    repoUrl: 'https://apps.apple.com/eg/app/saqqar-odoo-copilot/id6784956650',
    websiteUrl: 'https://saqqaar.com',
    techs: [
      'Flutter',
      'Bloc / Cubit',
      'go_router',
      'Dio',
      'Firebase (FCM)',
      'Odoo (ERP Backend)',
      'Sentry',
    ],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'AI agent on a live ERP — plain-language requests (text or voice) run against the real Odoo system, and every risky change goes through an approval gate, inline in chat or from Apple Watch.',
        'وكيل AI على ERP حي — طلبات بلغة عادية (نص أو صوت) بتتنفذ على نظام Odoo الحقيقي، وكل تغيير حساس بيعدّي على بوابة موافقة، داخل الشات أو من Apple Watch.',
      ),
      L18n(
        'Business Pulse dashboard cards for seven domains — accounting, finance, HR, inventory, purchasing, manufacturing and quality — each with one-tap requests to the agent.',
        'كروت Business Pulse لسبعة مجالات — محاسبة، مالية، موارد بشرية، مخزون، مشتريات، تصنيع وجودة — وفي كل كارت أزرار بتبعت طلب للوكيل بضغطة.',
      ),
      L18n(
        'Deep native integration — Share Extension and share-to-app from WhatsApp and Photos, an Apple Watch app with Complication, Universal / App Links, and FCM notifications with separate channels.',
        'تكامل native عميق — Share Extension واستقبال الملفات من واتساب والصور، تطبيق Apple Watch مع Complication، Universal / App Links، وإشعارات FCM بقنوات منفصلة.',
      ),
      L18n(
        'Schema-driven credentials vault for projects and Odoo environments with Test Connection, plus biometric lock and tokens kept in Keychain / Keystore.',
        'خزنة اعتماد schema-driven للمشاريع وبيئات Odoo مع Test Connection، وقفل بيومتري و tokens محفوظة في Keychain / Keystore.',
      ),
      L18n(
        'Fully bilingual (Arabic RTL / English) with dark and light themes, voice-to-text in both languages, and Sentry crash reporting without personal data.',
        'ثنائي اللغة بالكامل (عربي RTL / إنجليزي) مع ثيم داكن وفاتح، وتحويل صوت لنص بالاتنين، ومتابعة أخطاء Sentry بدون بيانات شخصية.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.erp],
    title: L18n(
      'HR — Employee Self-Service for Odoo',
      'HR — الخدمة الذاتية للموظفين على Odoo',
    ),
    shortDescription: L18n(
      'A bilingual (Arabic-first, RTL) employee self-service app for companies running Odoo. Employees see their day at a glance, check in and out with location, review attendance and weekly hours, check leave balances and submit requests, handle approvals, and reach payroll, calendar, public holidays, colleagues, directory, documents and expenses from one place. Managers and HR still review requests inside Odoo. Live on the App Store and Google Play.',
      'تطبيق خدمة ذاتية للموظفين ثنائي اللغة (عربي أولًا، RTL) للشركات اللي بتستخدم Odoo. الموظف بيشوف يومه من الشاشة الرئيسية، ويسجّل حضوره وانصرافه بالموقع، ويراجع الحضور وساعات الأسبوع، ويشوف أرصدة إجازاته ويقدّم طلباته، ويتعامل مع الموافقات، ويوصل للرواتب والتقويم والإجازات الرسمية والزملاء والدليل والمستندات والمصروفات من مكان واحد. المديرون والموارد البشرية بيراجعوا الطلبات من داخل Odoo. منشور على App Store و Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'HR',
      appName: L18n('HR', 'الموارد البشرية'),
      subtitle: L18n(
        'Your HR requests, in your pocket.',
        'طلبات الموارد البشرية في جيبك.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.dashboard_outlined,
          label: L18n('Dashboard', 'الرئيسية'),
        ),
        ProjectFeature(
          icon: Icons.fingerprint_outlined,
          label: L18n('Attendance', 'الحضور'),
        ),
        ProjectFeature(
          icon: Icons.beach_access_outlined,
          label: L18n('Leave', 'الإجازات'),
        ),
        ProjectFeature(
          icon: Icons.receipt_long_outlined,
          label: L18n('Payroll', 'الرواتب'),
        ),
        ProjectFeature(
          icon: Icons.fact_check_outlined,
          label: L18n('Approvals', 'الموافقات'),
        ),
        ProjectFeature(
          icon: Icons.translate,
          label: L18n('AR · EN', 'عربي · إنجليزي'),
        ),
      ],
      gradient: [Color(0xFF0C0F14), Color(0xFF0C1329), Color(0xFF1565C0)],
      accent: Color(0xFF7CB1FF),
      coverImage: 'assets/images/hr/cover.webp',
    ),
    images: [
      'assets/images/hr/Screenshot_1786433069.webp',
      'assets/images/hr/Screenshot_1786433073.webp',
      'assets/images/hr/Screenshot_1786433088.webp',
      'assets/images/hr/Screenshot_1786433144.webp',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=net.digitalharbor.hr',
    repoUrl: 'https://apps.apple.com/us/app/hrms-dh/id6800236795',
    techs: [
      'Flutter',
      'Bloc / Cubit',
      'get_it (DI)',
      'Dio',
      'Odoo 18 (JSON-RPC)',
      'flutter_localizations',
      'Sentry',
      'Clean Architecture',
    ],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'Real Odoo 18 integration — one JSON-RPC layer over Dio with a session-cookie interceptor and error mapping; the employee identity is decided by the server from the session.',
        'تكامل حقيقي مع Odoo 18 — طبقة JSON-RPC موحّدة فوق Dio مع session-cookie interceptor و error mapping؛ وهوية الموظف بيحددها السيرفر من الجلسة.',
      ),
      L18n(
        'Employee self-service in one app — Dashboard, location-aware Attendance with weekly hours, Leave balances and requests, Payroll, Approvals, Calendar, Public holidays, Colleagues, Directory, Documents and Expenses.',
        'خدمة ذاتية للموظف في تطبيق واحد — الرئيسية، حضور بالموقع مع ساعات الأسبوع، أرصدة وطلبات الإجازات، الرواتب، الموافقات، التقويم، الإجازات الرسمية، الزملاء، الدليل، المستندات، والمصروفات.',
      ),
      L18n(
        'Dynamic approval forms — fields (amount, dates, location, quantity, reference) are driven by flags on each Odoo category, validated locally and again before submit.',
        'نماذج موافقات ديناميكية — الحقول (مبلغ، تواريخ، موقع، كمية، مرجع) بتتحدد من أعلام كل فئة في Odoo، مع تحقق محلي وإعادة تحقق قبل الإرسال.',
      ),
      L18n(
        'Bilingual with full RTL / LTR flip, Cairo typography and complete light and dark Material 3 themes.',
        'ثنائي اللغة مع flip كامل لـ RTL / LTR، خط Cairo، وثيمين فاتح وداكن بـ Material 3 كاملين.',
      ),
      L18n(
        'Secure by design — session stored in secure storage, HTTPS-only origin, and Sentry crash reporting enabled only when a DSN is supplied at build time.',
        'آمن من التصميم — الجلسة في secure storage، origin بـ HTTPS فقط، ومتابعة أخطاء Sentry بتشتغل بس لو الـ DSN اتحدد وقت البناء.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.erp],
    title: L18n(
      'Field Visits — GPS-verified Visit Management',
      'الزيارات الميدانية — إدارة زيارات موثّقة بالموقع',
    ),
    shortDescription: L18n(
      'A work tool for sales reps and technicians who visit customers, and for the managers who review those visits. Each visit starts and ends with a GPS-stamped check-in measured against the customer location, and the route is recorded on the map. Visits go through an approval workflow with push notifications, and offline actions are queued and sent when the connection returns. Connects to the company own Odoo server. Bilingual with full RTL.',
      'أداة عمل للمندوبين والفنيين اللي بيزوروا العملاء، وللمديرين اللي بيراجعوا الزيارات دي. كل زيارة بتبدأ وتنتهي بتسجيل موقع GPS بيتقارن بموقع العميل، ومسار الزيارة بيتسجّل ويتعرض على الخريطة. الزيارات بتعدي على دورة اعتماد مع إشعارات فورية، والإجراءات اللي بتحصل بدون إنترنت بتتخزن وتتبعت تلقائيًا لما الاتصال يرجع. بيتصل بسيرفر Odoo الخاص بالشركة. ثنائي اللغة مع RTL كامل.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'FV',
      appName: L18n('Field Visits', 'الزيارات الميدانية'),
      subtitle: L18n(
        'GPS-verified field visits, tracked and approved.',
        'زيارات ميدانية موثّقة بالموقع ومعتمدة بسهولة.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.location_on_outlined,
          label: L18n('GPS Check-in', 'تسجيل بالموقع'),
        ),
        ProjectFeature(
          icon: Icons.route_outlined,
          label: L18n('Visit Route', 'مسار الزيارة'),
        ),
        ProjectFeature(
          icon: Icons.fact_check_outlined,
          label: L18n('Approvals', 'دورة الاعتماد'),
        ),
        ProjectFeature(
          icon: Icons.cloud_off_outlined,
          label: L18n('Offline Queue', 'طابور Offline'),
        ),
        ProjectFeature(
          icon: Icons.insights_outlined,
          label: L18n('Manager Dashboard', 'لوحة المدير'),
        ),
        ProjectFeature(
          icon: Icons.notifications_active_outlined,
          label: L18n('Push Alerts', 'الإشعارات'),
        ),
      ],
      gradient: [Color(0xFF091731), Color(0xFF1E2A6E), Color(0xFF3FBFD9)],
      accent: Color(0xFF3FBFD9),
      coverImage: 'assets/images/visits/cover.webp',
    ),
    images: [
      'assets/images/visits/Screenshot_1786260328.webp',
      'assets/images/visits/Screenshot_1786260334.webp',
      'assets/images/visits/Screenshot_1786260340.webp',
      'assets/images/visits/Screenshot_1786260349.webp',
      'assets/images/visits/Screenshot_1786260427.webp',
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
      'Odoo (JSON-RPC + REST)',
      'flutter_map (OpenStreetMap)',
      'geolocator',
      'Firebase (FCM)',
      'get_it',
    ],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'GPS verification and route capture — each visit is checked against the customer location, and the route is recorded only during an active visit with explicit user consent, using a native Android foreground service and iOS background location.',
        'توثيق بالـ GPS وتسجيل المسار — كل زيارة بتتقارن بموقع العميل، والمسار بيتسجّل أثناء الزيارة بس وبموافقة المستخدم الصريحة، عبر foreground service على Android و background location على iOS.',
      ),
      L18n(
        'Visit approval workflow — submit, approve, reject, reschedule or cancel, with participant approvals and FCM push notifications that deep-link straight to the visit.',
        'دورة اعتماد للزيارات — تقديم واعتماد ورفض وإعادة جدولة وإلغاء، مع موافقات المشاركين وإشعارات FCM بتفتح الزيارة مباشرة.',
      ),
      L18n(
        'Offline-first actions — start and end actions taken without a connection are stored on the device and replayed automatically; GPS points are uploaded in batches.',
        'إجراءات تشتغل أوفلاين — إجراءات البدء والإنهاء بدون إنترنت بتتخزن على الجهاز وتتبعت تلقائيًا، ونقاط الـ GPS بتترفع على دفعات.',
      ),
      L18n(
        'Manager tools — dashboard with KPIs and a live map of running visits, weekly chart, on-time leaderboard, a review queue and customer map with one-tap call, email and directions.',
        'أدوات المدير — لوحة بمؤشرات أداء وخريطة للزيارات الجارية، رسم أسبوعي، ترتيب بالالتزام، طابور مراجعة، وخريطة عملاء باتصال وإيميل واتجاهات بضغطة.',
      ),
      L18n(
        'Per-company Odoo server set at runtime on a setup screen, role-aware UI for employees and managers, and bilingual RTL / LTR with Light, Dark and System themes.',
        'سيرفر Odoo لكل شركة بيتحدد وقت التشغيل من شاشة إعداد، وواجهة حسب الدور (موظف / مدير)، وثنائي اللغة RTL / LTR مع ثيم فاتح وداكن وتلقائي.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.erp],
    title: L18n(
      'DH Sprints — Odoo Projects & Tasks Companion',
      'DH Sprints — تطبيق مهام ومشاريع أودو',
    ),
    shortDescription: L18n(
      'A bilingual (Arabic / English) mobile companion for teams that run their work on Odoo. It connects directly to your own Odoo server over JSON-RPC — no intermediate backend. Manage projects, tasks, timesheets and discussions from your phone, with a Kanban board, calendar, timeline, reports and global search. Live on the App Store and Google Play.',
      'تطبيق موبايل ثنائي اللغة (عربي / إنجليزي) للفرق اللي بتدير شغلها على أودو. بيتصل مباشرة بسيرفر أودو الخاص بالشركة عبر JSON-RPC من غير باك إند وسيط. إدارة المشاريع والمهام وسجلات الوقت والنقاشات من الموبايل، مع لوحة Kanban وتقويم وجدول زمني وتقارير وبحث شامل. منشور على App Store و Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'DH',
      appName: L18n('DH Sprints', 'DH Sprints'),
      subtitle: L18n(
        'Your Odoo projects and tasks, in your pocket.',
        'مشاريع ومهام أودو في جيبك.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.view_kanban_rounded,
          label: L18n('Kanban', 'كانبان'),
        ),
        ProjectFeature(
          icon: Icons.task_alt_rounded,
          label: L18n('My Tasks', 'مهامي'),
        ),
        ProjectFeature(
          icon: Icons.timer_rounded,
          label: L18n('Timesheets', 'سجلات الوقت'),
        ),
        ProjectFeature(
          icon: Icons.bar_chart_rounded,
          label: L18n('Reports', 'التقارير'),
        ),
        ProjectFeature(
          icon: Icons.calendar_month_rounded,
          label: L18n('Calendar', 'التقويم'),
        ),
        ProjectFeature(
          icon: Icons.fingerprint_rounded,
          label: L18n('Biometric Lock', 'قفل بالبصمة'),
        ),
      ],
      gradient: [Color(0xFF161C4D), Color(0xFF232C73), Color(0xFF0E96A4)],
      accent: Color(0xFF18C0D1),
      coverImage: 'assets/images/sprints/cover.webp',
    ),
    images: [
      'assets/images/sprints/Screenshot_1783863008.webp',
      'assets/images/sprints/Screenshot_1783863014.webp',
      'assets/images/sprints/Screenshot_1783863021.webp',
      'assets/images/sprints/Screenshot_1783863046.webp',
      'assets/images/sprints/Screenshot_1783863050.webp',
      'assets/images/sprints/Screenshot_1783863053.webp',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=net.digitalharbor.odoo_tasks',
    repoUrl: 'https://apps.apple.com/us/app/dh-sprints/id6795838837',
    techs: [
      'Flutter',
      'Bloc / Cubit',
      'Odoo (JSON-RPC)',
      'Material 3',
      'Sentry',
      'Feature-first MVVM',
    ],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'Direct Odoo integration with no intermediate backend — works with any Odoo server by entering its URL, with automatic database discovery and nothing hard-coded.',
        'تكامل مباشر مع Odoo بدون باك إند وسيط — بيشتغل مع أي سيرفر بإدخال الـ URL، مع اكتشاف تلقائي للـ database ومن غير قيم مكتوبة في الكود.',
      ),
      L18n(
        'Full task workflow — Kanban with drag-and-drop between stages, My Tasks with swipe actions, task workspace (details, time, discussion), subtasks and attachments.',
        'دورة عمل كاملة للمهام — Kanban بسحب المهام بين المراحل، مهامي مع swipe actions، تفاصيل المهمة (التفاصيل والوقت والنقاش)، مهام فرعية ومرفقات.',
      ),
      L18n(
        'Fully bilingual (Arabic RTL / English) with light and dark themes, plus calendar, timeline, reports powered by Odoo read_group, and global search.',
        'ثنائي اللغة بالكامل (عربي RTL / إنجليزي) مع وضع فاتح وداكن، بالإضافة للتقويم والجدول الزمني وتقارير بـ read_group من Odoo وبحث شامل.',
      ),
      L18n(
        'Security & reliability — biometric lock, session in secure storage, read cache with a connectivity banner, and privacy-first Sentry error monitoring.',
        'أمان واعتمادية — قفل بالبصمة، الجلسة في secure storage، كاش للقراءة مع شريط حالة الاتصال، ومتابعة أخطاء Sentry بدون إرسال بيانات تعريفية.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.erp],
    title: L18n(
      'Sijil IT — IT Asset Management for Odoo',
      'سِجل IT — إدارة الأصول التقنية على Odoo',
    ),
    shortDescription: L18n(
      'A bilingual (Arabic / English) mobile app for managing company IT assets — laptops, monitors, phones and more. It talks directly to the company Odoo instance over XML-RPC, so the team works on the records they already use, with no extra server or second database. Scan, assign, hand over, audit and track devices, and follow maintenance requests. Live on the App Store and Google Play.',
      'تطبيق موبايل ثنائي اللغة (عربي / إنجليزي) لإدارة الأصول التقنية في الشركات — لابتوبات وشاشات وموبايلات وغيرها. بيتوصّل مباشرة بنظام Odoo الخاص بالشركة عبر XML-RPC، فالفريق بيشتغل على نفس السجلات اللي بيستخدمها من غير سيرفر إضافي أو قاعدة بيانات تانية. مسح الأجهزة وتسليمها واستلامها وجردها ومتابعة طلبات الصيانة. منشور على App Store و Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'SJ',
      appName: L18n('Sijil IT', 'سِجل IT'),
      subtitle: L18n(
        'IT assets in your pocket, live from Odoo.',
        'أصول الـ IT في جيبك، مباشرة من Odoo.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.dashboard_outlined,
          label: L18n('Dashboard', 'لوحة المؤشرات'),
        ),
        ProjectFeature(
          icon: Icons.qr_code_scanner,
          label: L18n('QR Scan', 'مسح الباركود'),
        ),
        ProjectFeature(
          icon: Icons.inventory_2_outlined,
          label: L18n('Assets', 'الأصول'),
        ),
        ProjectFeature(
          icon: Icons.swap_horiz,
          label: L18n('Handover', 'التسليم والاستلام'),
        ),
        ProjectFeature(
          icon: Icons.fact_check_outlined,
          label: L18n('Audit', 'الجرد'),
        ),
        ProjectFeature(
          icon: Icons.build_circle_outlined,
          label: L18n('Maintenance', 'الصيانة'),
        ),
      ],
      gradient: [Color(0xFF0B1226), Color(0xFF16255C), Color(0xFF4C82F7)],
      accent: Color(0xFF2FE3A8),
      coverImage: 'assets/images/sijil/cover.webp',
    ),
    images: [
      'assets/images/sijil/Screenshot_1788436818.webp',
      'assets/images/sijil/Screenshot_1788436834.webp',
      'assets/images/sijil/Screenshot_1788436978.webp',
      'assets/images/sijil/Screenshot_1788436950.webp',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=net.digitalharbor.sijilit',
    repoUrl: 'https://apps.apple.com/us/app/sijil-it/id6805446716',
    techs: [
      'Flutter',
      'Bloc / Cubit',
      'get_it (DI)',
      'go_router',
      'Odoo (XML-RPC)',
      'Hive',
      'Clean Architecture',
      'Sentry',
    ],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'Direct Odoo integration with no addon or middleware — standard models over XML-RPC, adapting at runtime to Odoo 17, 18 and 19 and hiding features whose Odoo apps are not installed.',
        'تكامل مباشر مع Odoo بدون addon أو middleware — models قياسية عبر XML-RPC، ويتكيّف وقت التشغيل مع Odoo 17 و18 و19 ويخفي الميزات اللي تطبيقاتها غير مثبتة.',
      ),
      L18n(
        'Complete asset lifecycle — QR / barcode scanning, create and search (including voice), handover and return with an on-screen signature, field audits, maintenance requests with photos, and PDF / CSV export.',
        'دورة حياة كاملة للأصل — مسح QR / باركود، إنشاء وبحث (بما فيه البحث الصوتي)، تسليم واستلام بتوقيع إلكتروني، جرد ميداني، طلبات صيانة بالصور، وتصدير PDF / CSV.',
      ),
      L18n(
        'Offline-first handover — local cache plus an ordered write queue for assign, return and status changes, syncing automatically when the connection returns.',
        'تسليم يشتغل أوفلاين — كاش محلي وطابور كتابة مرتّب لعمليات التسليم والاستلام وتغيير الحالة، ويتزامن تلقائيًا لما الاتصال يرجع.',
      ),
      L18n(
        'Fully bilingual (Arabic RTL / English) with light and dark themes and phone and tablet layouts, plus Clean Architecture with Cubit view-models.',
        'ثنائي اللغة بالكامل (عربي RTL / إنجليزي) مع وضع فاتح وداكن وتخطيطات للموبايل والتابلت، مع Clean Architecture و Cubit كـ view-models.',
      ),
      L18n(
        'Security first — credentials in Keychain / encrypted storage, biometric or device-PIN lock, sanitized logs, and HTTPS by default.',
        'الأمان أولًا — الاعتمادات في Keychain / تخزين مشفّر، قفل بالبصمة أو PIN الجهاز، تنقية الـ logs، و HTTPS افتراضيًا.',
      ),
    ],
  ),
  ProjectItem(
    categories: [ProjectCategory.ar],
    title: L18n(
      'Rack Design — AR Preview for Datacenter Designs',
      'Rack Design — معاينة تصميمات مراكز البيانات بالواقع المعزز',
    ),
    shortDescription: L18n(
      'A companion app for RD (Rack Designer), Digital Harbor datacenter design tool. Open a layout in RD, choose Preview in AR, and scan the QR code — the 3D model (GLB) is downloaded and placed on the real floor at true 1:1 size, so engineers and clients can walk around a rack or container before it is built. Short on floor space? Show it at a reduced preview scale. Phones without AR get an interactive 3D viewer. No account needed. Bilingual with full RTL. Live on the App Store and Google Play.',
      'تطبيق مرافق لأداة RD (Rack Designer) من Digital Harbor لتصميم مراكز البيانات. افتح تصميمك في RD واختار المعاينة بالواقع المعزز وامسح رمز QR — الموديل ثلاثي الأبعاد (GLB) بيتنزّل ويتحط على أرض الغرفة الحقيقية بحجمه الفعلي 1:1، فالمهندس أو العميل يقدر يلف حوالين الراك أو الحاوية قبل تنفيذها. المساحة صغيرة؟ اعرضه بمقياس معاينة مصغّر. والهواتف اللي مش بتدعم AR بتفتح التصميم في عارض 3D تفاعلي. من غير حساب. ثنائي اللغة مع RTL كامل. منشور على App Store و Google Play.',
    ),
    cover: ProjectCoverSpec(
      logoText: 'RD',
      appName: L18n('Rack Design', 'Rack Design'),
      subtitle: L18n(
        'Your datacenter design, standing on the floor in AR.',
        'تصميم مركز البيانات واقفًا أمامك بالواقع المعزز.',
      ),
      features: [
        ProjectFeature(
          icon: Icons.qr_code_scanner,
          label: L18n('QR Scan', 'مسح QR'),
        ),
        ProjectFeature(
          icon: Icons.view_in_ar_rounded,
          label: L18n('True-Scale AR', 'AR بالحجم الحقيقي'),
        ),
        ProjectFeature(
          icon: Icons.straighten,
          label: L18n('Preview Scales', 'مقاييس المعاينة'),
        ),
        ProjectFeature(
          icon: Icons.threed_rotation,
          label: L18n('3D Viewer', 'عارض 3D'),
        ),
        ProjectFeature(
          icon: Icons.ios_share,
          label: L18n('Share Photo', 'مشاركة صورة'),
        ),
        ProjectFeature(
          icon: Icons.translate,
          label: L18n('AR · EN · RTL', 'عربي · إنجليزي · RTL'),
        ),
      ],
      gradient: [Color(0xFF0B1014), Color(0xFF0F766E), Color(0xFF5EEAD4)],
      accent: Color(0xFF5EEAD4),
      coverImage: 'assets/images/rack/cover.webp',
    ),
    images: [
      'assets/images/rack/image.webp',
      'assets/images/rack/rack.webp',
      'assets/images/rack/rack2.webp',
      'assets/images/rack/unnamed.webp',
      'assets/images/rack/04_scale.webp',
    ],
    apkUrl:
        'https://play.google.com/store/apps/details?id=com.Digitalharbor.Design',
    repoUrl: 'https://apps.apple.com/us/app/rack-design-ai/id6796253857',
    websiteUrl: 'https://rackdesign.ai',
    techs: [
      'Flutter',
      'ARCore / ARKit',
      'model_viewer_plus (WebGL)',
      'mobile_scanner',
      'Dio',
      'Sentry',
    ],
    statusLabel: _live,
    statusColor: Colors.green,
    impactHighlights: [
      L18n(
        'True-scale AR — the rack or container is placed on a detected floor plane at 1:1 size, with six preview scales for tight rooms. The scale is applied to the GLB geometry itself, because the AR plugin applies it inconsistently across platforms.',
        'AR بالحجم الحقيقي — الراك أو الحاوية بتتحط على الأرض المكتشفة بحجم 1:1، مع ست مقاييس معاينة للغرف الضيقة. المقياس بيتطبّق على هندسة ملف GLB نفسها، لأن الـ plugin بيطبّقه بشكل غير متسق بين المنصتين.',
      ),
      L18n(
        'Graceful degradation — when a device does not support ARCore, or it cannot be installed, the app switches to an interactive 3D viewer with drag and pinch instead of an error screen.',
        'تراجع سلس — لو الجهاز مش بيدعم ARCore أو تعذّر تثبيته، التطبيق بيتحول لعارض 3D تفاعلي بالسحب والتكبير بدل شاشة خطأ.',
      ),
      L18n(
        'Frictionless entry — scan the QR code or paste a link, with App Links / Universal Links, no account and no sign-up; the model is validated as a complete GLB before it is shown.',
        'دخول من غير تعقيد — مسح QR أو لصق الرابط، مع App Links / Universal Links، ومن غير حساب أو تسجيل؛ وبيتم التحقق إن ملف GLB كامل قبل عرضه.',
      ),
      L18n(
        'Structured error handling — around 17 translated failure types, each with a title, a cause, a fix step and a support code tied to Sentry events.',
        'معالجة أخطاء منظّمة — حوالي 17 نوع خطأ مترجم، لكل نوع عنوان وسبب وخطوة حل وكود دعم مربوط بأحداث Sentry.',
      ),
      L18n(
        'Fully bilingual (Arabic RTL / English) with light and dark themes, and widget tests that render every screen at four sizes in both languages.',
        'ثنائي اللغة بالكامل (عربي RTL / إنجليزي) مع وضع فاتح وداكن، واختبارات widgets بتعرض كل الشاشات بأربعة أحجام وباللغتين.',
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
      coverImage: 'assets/images/alawaly/cover.webp',
    ),
    images: [
      'assets/images/alawaly/المشاريع.webp',
      'assets/images/alawaly/تفاصيل المشروع.webp',
      'assets/images/alawaly/تفاصيل الوحدة.webp',
      'assets/images/alawaly/نتائج البحث علي الخريطة2.webp',
      'assets/images/alawaly/sign up2.webp',
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
      coverImage: 'assets/images/fortynine/cover.webp',
    ),
    images: [
      'assets/images/fortynine/1.webp',
      'assets/images/fortynine/2.webp',
      'assets/images/fortynine/3.webp',
      'assets/images/fortynine/4.webp',
      'assets/images/fortynine/5.webp',
      'assets/images/fortynine/6.webp',
      'assets/images/fortynine/7.webp',
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
      coverImage: 'assets/images/ecommerce/cover.webp',
    ),
    images: [
      'assets/images/ecommerce/IMG-20250411-WA0088.webp',
      'assets/images/ecommerce/IMG-20250411-WA0090.webp',
      'assets/images/ecommerce/IMG-20250411-WA0096.webp',
      'assets/images/ecommerce/IMG-20250411-WA0099.webp',
      'assets/images/ecommerce/IMG-20250411-WA0101.webp',
      'assets/images/ecommerce/IMG-20250411-WA0104.webp',
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
      coverImage: 'assets/images/captain_drive/cover.webp',
    ),
    images: [
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 75.webp',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 76.webp',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 77.webp',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 84.webp',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 86.webp',
      'assets/images/captain_drive/iPhone 14 & 15 Pro Max - 89.webp',
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

/// Projects that are published on the stores. Drives every "live apps" figure
/// on the site (hero, sticky banner, about pill) so the numbers never drift
/// from the cards below.
int get liveProjectsCount =>
    projectsData.where((p) => p.statusColor == Colors.green).length;

/// Projects built as Odoo companions.
int get odooProjectsCount => projectsData
    .where((p) => p.categories.contains(ProjectCategory.erp))
    .length;
