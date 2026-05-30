import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostafa_badr_portfolio/sections/portfolio_home.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/widgets/konami_easter_egg.dart';

void main() {
  runApp(const PortfolioApp());
}

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
              ),
              darkTheme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Colors.transparent,
                textTheme:
                    GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
                cardColor: Colors.black.withValues(alpha: 0.35),
              ),
              home: const KonamiEasterEgg(child: PortfolioHome()),
            );
          },
        );
      },
    );
  }
}
