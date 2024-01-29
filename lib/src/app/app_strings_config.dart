import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_timer/res/app_strings.dart';

abstract class AppStringsConfig {
  static Iterable<Locale> get supportedLocales {
    return [
      const Locale('en', ''),
      const Locale('pt', ''),
    ];
  }

  static bool isSupportedLocale(Locale locale) {
    return supportedLocales.any((e) => e.languageCode == locale.languageCode);
  }

  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    return [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      const AppStringsDelegate(AppStringsConfig.isSupportedLocale),
    ];
  }
}
