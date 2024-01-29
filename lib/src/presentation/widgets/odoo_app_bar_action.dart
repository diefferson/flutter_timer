import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_colors.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';

import 'status_bar.dart';


class OdooAppBarAction extends StatelessWidget {
  const OdooAppBarAction({super.key, required this.icon, required this.action});

  final IconData icon;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(12),
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondary,
          ),
        child: Icon(
          icon,
          size: 20
        ),
      ),
    );
  }
}
