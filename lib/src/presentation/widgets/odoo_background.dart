
import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_colors.dart';
import 'package:flutter_timer/src/presentation/widgets/status_bar.dart';

class OdooBackground extends StatelessWidget {
  const OdooBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: Material(
        child: Container(
          decoration:  BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.of(context).onPrimaryContainer : null,
            gradient: Theme.of(context).brightness == Brightness.light ? AppColors.of(context).backgroundGradient : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
