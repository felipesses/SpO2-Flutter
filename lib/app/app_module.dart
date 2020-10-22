import 'package:SpO2/app/modules/android/o2_result_android/o2_result_android_module.dart';
import 'package:SpO2/app/modules/ios/o2_result_ios/o2_result_ios_module.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'modules/about/about_module.dart';
import 'modules/android/o2_process_android/o2_process_android_module.dart';
import 'modules/ios/o2_process_ios/o2_process_ios_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/o2ProcessAndroid', module: O2ProcessAndroidModule()),
        ModularRouter('/o2ProcessIos', module: O2ProcessIosModule()),
        ModularRouter('/o2ResultAndroid', module: O2ResultAndroidModule()),
        ModularRouter('/o2ResultIos', module: O2ResultIosModule()),
        ModularRouter('/about', module: AboutModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
