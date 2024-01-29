import 'package:flutter_timer/src/di/app_inject.dart';
import 'package:stark/stark.dart';

import 'app_configurator.dart';

class StarkConfigurator implements AppConfigurator {

  @override
  Future configure() async {
    Stark.clear();

    final appInject = AppInject();

    Stark.init(
      appInject.binds(),
      logger: Logger(
        level: Level.INFO,
      ),
    );
  }
}
