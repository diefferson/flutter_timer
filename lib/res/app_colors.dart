import 'package:flutter/material.dart';

import 'colors/app_colors_dark.dart';
import 'colors/app_colors_light.dart';

class AppColors {
  AppColors._();
  static AppColorsLight of(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return AppColorsDark();
    }
    return AppColorsLight();
  }

  static AppColorsLight fromBrightness(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return AppColorsDark();
    }
    return AppColorsLight();
  }
}
