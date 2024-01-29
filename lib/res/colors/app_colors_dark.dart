import 'package:flutter/material.dart';

import 'app_colors_light.dart';

class AppColorsDark extends AppColorsLight {

  //Surface variant
  @override
  Color get surfaceVariant => const Color(0x03000000);
  @override
  Color get onSurfaceVariant => const Color(0xFFFFFFFF);
  @override
  Color get outline => const Color(0x29FFFFFF);
  @override
  Color get outlineVariant => const Color(0x7AFFFFFF);
}
