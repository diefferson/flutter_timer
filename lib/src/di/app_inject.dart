import 'package:stark/stark.dart';
import 'app_module.dart';
import 'base_injection_module.dart';

class AppInject {

  List<BaseInjectModule> _injectModules() => [
        AppModule(),
      ];

  List<Set<Bind>> binds() => _injectModules().map((e) => e.binds()).toList();
}
