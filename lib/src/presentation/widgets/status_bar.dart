import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkStatusBar extends StatelessWidget {
  const DarkStatusBar(
      {super.key, required this.child, this.bottomNavigationColor});

  final Widget child;
  final Color? bottomNavigationColor;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor:
              bottomNavigationColor ?? Colors.transparent),
      child: child,
    );
  }
}

class LightStatusBar extends StatelessWidget {
  const LightStatusBar(
      {super.key, required this.child, this.bottomNavigationColor});

  final Widget child;
  final Color? bottomNavigationColor;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor:
              bottomNavigationColor ?? Colors.transparent),
      child: child,
    );
  }
}

class ThemeStatusBar extends StatelessWidget {
  const ThemeStatusBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // if (Theme.of(context).brightness == Brightness.light) {
      return DarkStatusBar(child: child);
    // }
    return LightStatusBar(child: child);
  }
}

SystemUiOverlayStyle defaultSystemUiOverlayStyle(BuildContext context) =>
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Theme.of(context).brightness,
      systemStatusBarContrastEnforced: false,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
