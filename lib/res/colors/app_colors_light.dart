import 'package:flutter/material.dart';

class AppColorsLight {
  //Primary
  Color get primary => const Color(0xFFFFFFFF);

  Color get onPrimary => const Color(0xFF000000);

  Color get primaryContainer => const Color(0xFFFFFFFF);

  Color get onPrimaryContainer => const Color(0xFF000000);

  //Secondary
  Color get secondary => const Color(0x29FFFFFF);

  Color get onSecondary => const Color(0xFFFFFFFF);

  Color get secondaryContainer => const Color(0x29FFFFFF);

  Color get onSecondaryContainer => const Color(0xFFFFFFFF);

  //Tertiary
  Color get tertiary => const Color(0x52FFFFFF);

  Color get onTertiary => const Color(0xFF000000);

  Color get tertiaryContainer => const Color(0x52FFFFFF);

  Color get onTertiaryContainer => const Color(0xFF000000);

  //Error
  Color get error => const Color(0xFFCC3C21);

  Color get onError => const Color(0xFFFFFFFF);

  Color get errorContainer => const Color(0x52CC3C21);

  Color get onErrorContainer => const Color(0xFFCC3C21);

  //Background
  LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFF0C1D4D),
          Color(0xFF214ECC),
        ],
      );

  //Background
  Color get background => const Color(0xFF0C1D4D);

  Color get onBackground => const Color(0xFFFFFFFF);

  Color get surface => const Color(0xFF0C1D4D);

  Color get onSurface => const Color(0xFFFFFFFF);

  //Surface variant
  Color get surfaceVariant => const Color(0x03000000);

  Color get onSurfaceVariant => const Color(0xFFFFFFFF);

  Color get outline => const Color(0x29FFFFFF);

  Color get outlineVariant => const Color(0x7AFFFFFF);
}
