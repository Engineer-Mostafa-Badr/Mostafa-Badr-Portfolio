import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/data/projects_data.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';

class CommandPaletteAction {
  final IconData icon;
  final String label;
  final String? hint;
  final VoidCallback onRun;
  final String searchHaystack;

  CommandPaletteAction({
    required this.icon,
    required this.label,
    this.hint,
    required this.onRun,
    String? haystack,
  }) : searchHaystack = (haystack ?? label).toLowerCase();
}

class CommandPaletteHost extends StatefulWidget {
  final Widget child;
  final Future<void> Function(String labelKey) onNavigate;
  final VoidCallback onToggleTheme;
  final VoidCallback onToggleLocale;

  const CommandPaletteHost({
    super.key,
    required this.child,
    required this.onNavigate,
    required this.onToggleTheme,
    required this.onToggleLocale,
  });

  @override
  State<CommandPaletteHost> createState() => _CommandPaletteHostState();
}

class _CommandPaletteHostState extends State<CommandPaletteHost> {
  bool _open = false;

  void _show() {
    if (_open) return;
    _open = true;
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Command palette',
      barrierColor: Colors.black.withValues(alpha: 0.55),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, anim, _, child) {
        return Opacity(
          opacity: anim.value,
          child: _CommandPaletteSheet(
            ar: isArabic(context),
            navigate: widget.onNavigate,
            toggleTheme: widget.onToggleTheme,
            toggleLocale: widget.onToggleLocale,
          ),
        );
      },
    ).whenComplete(() {
      _open = false;
    });
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final isCtrlOrCmd = HardwareKeyboard.instance.isControlPressed ||
        HardwareKeyboard.instance.isMetaPressed;
    if (isCtrlOrCmd && event.logicalKey == LogicalKeyboardKey.keyK) {
      _show();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: _onKey,
      child: widget.child,
    );
  }
}

class _CommandPaletteSheet extends StatefulWidget {
  final bool ar;
  final Future<void> Function(String labelKey) navigate;
  final VoidCallback toggleTheme;
  final VoidCallback toggleLocale;

  const _CommandPaletteSheet({
    required this.ar,
    required this.navigate,
    required this.toggleTheme,
    required this.toggleLocale,
  });

  @override
  State<_CommandPaletteSheet> createState() => _CommandPaletteSheetState();
}

class _CommandPaletteSheetState extends State<_CommandPaletteSheet> {
  final _query = TextEditingController();
  late final List<CommandPaletteAction> _all;
  int _focused = 0;

  @override
  void initState() {
    super.initState();
    _all = _buildActions();
    _query.addListener(() {
      setState(() {
        _focused = 0;
      });
    });
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  List<CommandPaletteAction> _buildActions() {
    final navTargets = [
      ('Home', 'الرئيسية', 'nav.home', Icons.home_outlined),
      ('About', 'نبذة عني', 'nav.about', Icons.person_outline),
      ('Skills', 'المهارات', 'nav.skills', Icons.build_circle_outlined),
      ('Experience', 'الخبرات', 'nav.experience', Icons.work_outline),
      ('Projects', 'المشاريع', 'nav.projects', Icons.rocket_launch_outlined),
      ('Contact', 'تواصل', 'nav.contact', Icons.send_outlined),
    ];

    return [
      for (final (en, ar, key, icon) in navTargets)
        CommandPaletteAction(
          icon: icon,
          label: widget.ar ? 'الذهاب إلى $ar' : 'Go to $en',
          hint: widget.ar ? 'قسم' : 'Section',
          haystack: '$en $ar $key',
          onRun: () async {
            Navigator.of(context).pop();
            await widget.navigate(key);
          },
        ),
      CommandPaletteAction(
        icon: Icons.translate,
        label: widget.ar ? 'تبديل اللغة' : 'Toggle language',
        hint: widget.ar ? 'AR ⇄ EN' : 'AR ⇄ EN',
        onRun: () {
          Navigator.of(context).pop();
          widget.toggleLocale();
        },
      ),
      CommandPaletteAction(
        icon: Icons.brightness_6_outlined,
        label: widget.ar ? 'تبديل الثيم' : 'Toggle theme',
        hint: widget.ar ? 'Light ⇄ Dark' : 'Light ⇄ Dark',
        onRun: () {
          Navigator.of(context).pop();
          widget.toggleTheme();
        },
      ),
      CommandPaletteAction(
        icon: Icons.chat_bubble_outline_rounded,
        label: widget.ar ? 'تواصل واتساب' : 'Open WhatsApp',
        hint: 'wa.me',
        onRun: () {
          Navigator.of(context).pop();
          openUrl('https://wa.me/201004652998');
        },
      ),
      CommandPaletteAction(
        icon: Icons.email_outlined,
        label: widget.ar ? 'إرسال إيميل' : 'Send email',
        hint: 'mostafamostafabadrbadr@gmail.com',
        onRun: () {
          Navigator.of(context).pop();
          openUrl('mailto:mostafamostafabadrbadr@gmail.com');
        },
      ),
      CommandPaletteAction(
        icon: Icons.code,
        label: 'GitHub',
        hint: 'Engineer-Mostafa-Badr',
        onRun: () {
          Navigator.of(context).pop();
          openUrl('https://github.com/Engineer-Mostafa-Badr');
        },
      ),
      CommandPaletteAction(
        icon: Icons.link,
        label: 'LinkedIn',
        hint: 'engineer-mostafa-badr',
        onRun: () {
          Navigator.of(context).pop();
          openUrl('https://www.linkedin.com/in/engineer-mostafa-badr/');
        },
      ),
      for (final project in projectsData)
        CommandPaletteAction(
          icon: Icons.rocket_launch_outlined,
          label: widget.ar ? 'فتح ${project.title.ar}' : 'Open ${project.title.en}',
          hint: widget.ar ? 'مشروع' : 'Project',
          haystack: '${project.title.en} ${project.title.ar}',
          onRun: () {
            Navigator.of(context).pop();
            openUrl(project.apkUrl);
          },
        ),
    ];
  }

  List<CommandPaletteAction> get _filtered {
    final q = _query.text.trim().toLowerCase();
    if (q.isEmpty) return _all;
    return _all.where((a) => a.searchHaystack.contains(q)).toList();
  }

  void _runFocused() {
    final list = _filtered;
    if (list.isEmpty) return;
    list[_focused.clamp(0, list.length - 1)].onRun();
  }

  KeyEventResult _onSheetKey(FocusNode _, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      Navigator.of(context).pop();
      return KeyEventResult.handled;
    }
    final list = _filtered;
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _focused = (_focused + 1).clamp(0, list.length - 1);
      });
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _focused = (_focused - 1).clamp(0, list.length - 1);
      });
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      _runFocused();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final list = _filtered;

    return SafeArea(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          constraints: const BoxConstraints(maxWidth: 620),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0E152B), Color(0xFF1A1130)],
            ),
            border: Border.all(color: palette.cardBorderStrong),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Focus(
            autofocus: true,
            onKeyEvent: _onSheetKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                  child: TextField(
                    controller: _query,
                    autofocus: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF40C4FF),
                      ),
                      hintText: widget.ar
                          ? 'ابحث أو اختر إجراء…'
                          : 'Type a command or search…',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.03),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: const Color(0xFF40C4FF)
                              .withValues(alpha: 0.50),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                // Results
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 380),
                  child: list.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(28),
                          child: Center(
                            child: Text(
                              widget.ar ? 'لا توجد نتائج' : 'No results',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                          itemCount: list.length,
                          itemBuilder: (context, i) {
                            final action = list[i];
                            final focused = i == _focused;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Material(
                                color: focused
                                    ? const Color(0xFF40C4FF)
                                        .withValues(alpha: 0.12)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: action.onRun,
                                  onHover: (_) =>
                                      setState(() => _focused = i),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 11,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          action.icon,
                                          size: 16,
                                          color: focused
                                              ? const Color(0xFF40C4FF)
                                              : Colors.grey[400],
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            action.label,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        if (action.hint != null)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 7,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: Colors.white
                                                  .withValues(alpha: 0.05),
                                            ),
                                            child: Text(
                                              action.hint!,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 10.5,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                // Footer hints
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      _kbdHint('↑↓', widget.ar ? 'تنقّل' : 'navigate'),
                      const SizedBox(width: 16),
                      _kbdHint('↵', widget.ar ? 'تنفيذ' : 'select'),
                      const SizedBox(width: 16),
                      _kbdHint('Esc', widget.ar ? 'إغلاق' : 'close'),
                      const Spacer(),
                      Text(
                        widget.ar ? 'لوحة الأوامر' : 'Command Palette',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 180.ms)
            .scale(
              begin: const Offset(0.96, 0.96),
              end: const Offset(1, 1),
              duration: 180.ms,
            ),
      ),
    );
  }

  Widget _kbdHint(String key, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white.withValues(alpha: 0.06),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Text(
            key,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
