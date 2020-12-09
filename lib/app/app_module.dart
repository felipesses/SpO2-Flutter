import 'package:SpO2/app/modules/o2_process/o2_process_module.dart';
import 'package:SpO2/app/modules/o2_result/o2_result_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:SpO2/app/app_widget.dart';

import 'modules/about/about_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/process',
          module: O2ProcessModule(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          '/result',
          module: O2ResultModule(),
          transition: TransitionType.rightToLeft,
        ),
        ModularRouter(
          '/about',
          module: AboutModule(),
          transition: TransitionType.fadeIn,
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
