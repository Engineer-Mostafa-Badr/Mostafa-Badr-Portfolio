import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostafa_badr_portfolio/sections/portfolio_home.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/widgets/konami_easter_egg.dart';

void main() {
  runApp(const PortfolioApp());
}

/// Lets mouse and trackpad drag-scroll horizontal carousels (Flutter web only
/// enables touch dragging by default), without changing wheel scrolling.
class _PortfolioScrollBehavior extends MaterialScrollBehavior {
  const _PortfolioScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

const _selection = TextSelectionThemeData(
  cursorColor: Color(0xFF22D3EE),
  selectionColor: Color(0x5922D3EE),
  selectionHandleColor: Color(0xFF22D3EE),
);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemeController.mode,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: AppLocaleController.locale,
          builder: (context, locale, _) {
            return MaterialApp(
              title: 'Mostafa Badr — Portfolio',
              debugShowCheckedModeBanner: false,
              scrollBehavior: const _PortfolioScrollBehavior(),
              themeMode: themeMode,
              locale: locale,
              supportedLocales: const [
                AppLocaleController.en,
                AppLocaleController.ar,
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: Colors.transparent,
                textTheme:
                    GoogleFonts.interTextTheme(ThemeData.light().textTheme),
                cardColor: Colors.white.withValues(alpha: 0.65),
                textSelectionTheme: _selection,
              ),
              darkTheme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Colors.transparent,
                textTheme:
                    GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
                cardColor: Colors.black.withValues(alpha: 0.35),
                textSelectionTheme: _selection,
              ),
              home: const KonamiEasterEgg(child: PortfolioHome())
                  .animate()
                  .fadeIn(duration: 500.ms, curve: Curves.easeOut),
            );
          },
        );
      },
    );
  }
}
