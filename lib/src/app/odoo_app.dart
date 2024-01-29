import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timer/res/app_theme.dart';
import 'package:flutter_timer/res/app_colors.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/presentation/pages/splash/splash_page.dart';
import 'package:intl/intl.dart';
import 'app_strings_config.dart';

class OdooApp extends StatefulWidget {
  const OdooApp({super.key});
  @override
  State<OdooApp> createState() => _OdooAppState();
}

class _OdooAppState extends State<OdooApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    Intl.defaultLocale = AppStrings.of(context).locale;
    return MaterialApp(
      title: AppStrings.of(context).appName,
      localizationsDelegates: AppStringsConfig.localizationsDelegates,
      supportedLocales: AppStringsConfig.supportedLocales,
      theme: AppTheme(AppColors.fromBrightness(Brightness.light)).light,
      darkTheme: AppTheme(AppColors.fromBrightness(Brightness.dark)).dark,
      themeMode: ThemeMode.light,
      home: const SplashPage(),
    );
  }
}
