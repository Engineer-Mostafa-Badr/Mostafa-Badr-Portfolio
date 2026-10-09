import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_links.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/data/projects_data.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/contact_links.dart';

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

/// Listens for Ctrl/Cmd+K anywhere in the app and opens the palette.
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
      barrierLabel: Tr.k(context, 'palette.title'),
      barrierColor: Colors.black.withValues(alpha: 0.55),
      transitionDuration: AppDurations.fast,
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, anim, _, child) => Opacity(
        opacity: anim.value,
        child: _CommandPaletteSheet(
          navigate: widget.onNavigate,
          toggleTheme: widget.onToggleTheme,
          toggleLocale: widget.onToggleLocale,
        ),
      ),
    ).whenComplete(() => _open = false);
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
  final Future<void> Function(String labelKey) navigate;
  final VoidCallback toggleTheme;
  final VoidCallback toggleLocale;

  const _CommandPaletteSheet({
    required this.navigate,
    required this.toggleTheme,
    required this.toggleLocale,
  });

  @override
  State<_CommandPaletteSheet> createState() => _CommandPaletteSheetState();
}

class _CommandPaletteSheetState extends State<_CommandPaletteSheet> {
  final _query = TextEditingController();
  int _focused = 0;

  /// Section jump targets: label key plus the icon shown in the list.
  static const _navTargets = <({String key, IconData icon})>[
    (key: 'nav.home', icon: Icons.home_outlined),
    (key: 'nav.about', icon: Icons.person_outline),
    (key: 'nav.skills', icon: Icons.build_circle_outlined),
    (key: 'nav.experience', icon: Icons.work_outline),
    (key: 'nav.projects', icon: Icons.rocket_launch_outlined),
    (key: 'nav.contact', icon: Icons.send_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _query.addListener(() => setState(() => _focused = 0));
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  /// Built per frame rather than cached in [initState] so the labels follow a
  /// locale switch made while the palette is open.
  List<CommandPaletteAction> _buildActions(BuildContext context) {
    final ar = isArabic(context);
    final goTo = Tr.k(context, 'palette.goTo');
    final open = Tr.k(context, 'palette.open');

    return [
      for (final target in _navTargets)
        CommandPaletteAction(
          icon: target.icon,
          label: goTo.withArgs({'target': Tr.k(context, target.key)}),
          hint: Tr.k(context, 'palette.section'),
          haystack: '${target.key} ${Tr.k(context, target.key)}',
          onRun: () async {
            Navigator.of(context).pop();
            await widget.navigate(target.key);
          },
        ),
      CommandPaletteAction(
        icon: Icons.translate,
        label: Tr.k(context, 'palette.toggleLocale'),
        hint: Tr.k(context, 'palette.localeHint'),
        onRun: () {
          Navigator.of(context).pop();
          widget.toggleLocale();
        },
      ),
      CommandPaletteAction(
        icon: Icons.brightness_6_outlined,
        label: Tr.k(context, 'palette.toggleTheme'),
        hint: Tr.k(context, 'palette.themeHint'),
        onRun: () {
          Navigator.of(context).pop();
          widget.toggleTheme();
        },
      ),
      CommandPaletteAction(
        icon: Icons.chat_bubble_outline_rounded,
        label: Tr.k(context, 'palette.openWhatsapp'),
        hint: 'wa.me',
        onRun: () {
          final url = hireMeLink(arabic: ar);
          Navigator.of(context).pop();
          openUrl(url, context: context);
        },
      ),
      CommandPaletteAction(
        icon: Icons.email_outlined,
        label: Tr.k(context, 'palette.sendEmail'),
        hint: AppLinks.email,
        onRun: () {
          final url = emailLink(arabic: ar);
          Navigator.of(context).pop();
          openUrl(url, context: context);
        },
      ),
      CommandPaletteAction(
        icon: Icons.code,
        label: 'GitHub',
        hint: AppLinks.githubUser,
        onRun: () {
          Navigator.of(context).pop();
          openUrl(AppLinks.github, context: context);
        },
      ),
      CommandPaletteAction(
        icon: Icons.link,
        label: 'LinkedIn',
        hint: 'engineer-mostafa-badr',
        onRun: () {
          Navigator.of(context).pop();
          openUrl(AppLinks.linkedIn, context: context);
        },
      ),
      for (final project in projectsData)
        CommandPaletteAction(
          icon: Icons.rocket_launch_outlined,
          label: open.withArgs({'target': project.title.t(context)}),
          hint: Tr.k(context, 'palette.project'),
          haystack: '${project.title.en} ${project.title.ar}',
          onRun: () {
            final url = project.apkUrl;
            Navigator.of(context).pop();
            openUrl(url, context: context);
          },
        ),
    ];
  }

  List<CommandPaletteAction> _filter(List<CommandPaletteAction> all) {
    final q = _query.text.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all.where((a) => a.searchHaystack.contains(q)).toList();
  }

  KeyEventResult _onSheetKey(
    FocusNode _,
    KeyEvent event,
    int resultCount,
    VoidCallback runFocused,
  ) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.escape) {
      Navigator.of(context).pop();
      return KeyEventResult.handled;
    }
    if (resultCount == 0) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() => _focused = (_focused + 1).clamp(0, resultCount - 1));
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() => _focused = (_focused - 1).clamp(0, resultCount - 1));
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      runFocused();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final results = _filter(_buildActions(context));
    final focusedIndex =
        results.isEmpty ? 0 : _focused.clamp(0, results.length - 1);

    return SafeArea(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
          constraints: const BoxConstraints(
            maxWidth: AppSizes.commandPaletteMaxWidth,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusXl),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.modalSurface,
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
            onKeyEvent: (node, event) => _onSheetKey(
              node,
              event,
              results.length,
              () => results.isEmpty ? null : results[focusedIndex].onRun(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SearchField(controller: _query),
                ConstrainedBox(
                  // Bounded against the viewport so the palette still fits on
                  // a short window instead of running past the screen edge.
                  constraints: BoxConstraints(
                    maxHeight: context.heightFraction(
                      0.5,
                      min: 160,
                      max: 380,
                    ),
                  ),
                  child: results.isEmpty
                      ? const _NoResults()
                      : _ResultsList(
                          results: results,
                          focusedIndex: focusedIndex,
                          onFocus: (i) => setState(() => _focused = i),
                        ),
                ),
                const _PaletteFooter(),
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
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  const _SearchField({required this.controller});

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, AppSizes.sm),
      child: TextField(
        controller: controller,
        autofocus: true,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: AppColors.cyan),
          hintText: Tr.k(context, 'palette.hint'),
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.03),
          border: _border(Colors.white.withValues(alpha: 0.10)),
          enabledBorder: _border(Colors.white.withValues(alpha: 0.10)),
          focusedBorder: _border(AppColors.cyan.withValues(alpha: 0.50)),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _ResultsList extends StatelessWidget {
  final List<CommandPaletteAction> results;
  final int focusedIndex;
  final ValueChanged<int> onFocus;

  const _ResultsList({
    required this.results,
    required this.focusedIndex,
    required this.onFocus,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(
        AppSizes.sm,
        AppSizes.xs,
        AppSizes.sm,
        AppSizes.sm,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final action = results[index];
        final focused = index == focusedIndex;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Material(
            color: focused
                ? AppColors.cyan.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              onTap: action.onRun,
              onHover: (_) => onFocus(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: 11,
                ),
                child: Row(
                  children: [
                    Icon(
                      action.icon,
                      size: 16,
                      color: focused ? AppColors.cyan : Colors.grey[400],
                    ),
                    const SizedBox(width: AppSizes.md),
                    Expanded(
                      child: Text(
                        action.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (action.hint != null) ...[
                      const SizedBox(width: AppSizes.sm),
                      // Capped so a long hint (an email address) cannot push
                      // the label out of the row.
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusXs),
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                          child: Text(
                            action.hint!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 26,
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            Tr.k(context, 'palette.noResults'),
            style: TextStyle(color: Colors.grey[400], fontSize: 13.5),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            Tr.k(context, 'palette.noResultsHint'),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

/// Keyboard hints. Laid out as a [Wrap] because the three hints plus the title
/// need ~355px, which overflowed the palette on any phone — they now flow onto
/// a second line, and the keyboard-only hints hide entirely on touch widths
/// where they are useless anyway.
class _PaletteFooter extends StatelessWidget {
  const _PaletteFooter();

  @override
  Widget build(BuildContext context) {
    final showKeyHints = !context.isMobile;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: AppSizes.md - 2,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Row(
        children: [
          if (showKeyHints)
            Expanded(
              child: Wrap(
                spacing: AppSizes.lg,
                runSpacing: AppSizes.xs + 2,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _KeyHint(
                    keyLabel: '↑↓',
                    label: Tr.k(context, 'palette.hintNavigate'),
                  ),
                  _KeyHint(
                    keyLabel: '↵',
                    label: Tr.k(context, 'palette.hintSelect'),
                  ),
                  _KeyHint(
                    keyLabel: 'Esc',
                    label: Tr.k(context, 'palette.hintClose'),
                  ),
                ],
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: AppSizes.md),
          Text(
            Tr.k(context, 'palette.title'),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyHint extends StatelessWidget {
  final String keyLabel;
  final String label;

  const _KeyHint({required this.keyLabel, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.xs + 2,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.xs),
            color: Colors.white.withValues(alpha: 0.06),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Text(
            keyLabel,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSizes.xs + 2),
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
