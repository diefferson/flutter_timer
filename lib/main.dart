import 'package:flutter/material.dart';
import 'package:flutter_timer/src/app/configurators/hydrated_bloc_configurator.dart';
import 'src/app/configurators/app_configurator.dart';
import 'src/app/configurators/stark_configurator.dart';
import 'src/app/odoo_app.dart';

void main() async {
  startApp();
}

Future startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final List<AppConfigurator> configurators = [
    HydratedBlocConfigurator(),
    StarkConfigurator(),
  ];

  await Future.forEach(configurators, (AppConfigurator configurator) async {
    await configurator.configure();
  });

  runApp(const OdooApp());
}
