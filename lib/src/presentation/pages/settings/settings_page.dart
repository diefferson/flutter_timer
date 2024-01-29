import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OdooHomeAppBar(
        title: AppStrings.of(context).settingsLabel,
      ),
    );
  }
}
