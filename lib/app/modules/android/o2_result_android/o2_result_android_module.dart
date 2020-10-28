import 'package:SpO2/app/controllers/result_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'o2_result_android_controller.dart';
import 'o2_result_android_page.dart';

class O2ResultAndroidModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => O2ResultAndroidController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => O2ResultAndroidPage(
            o2: args.data[0],
            bpm: args.data[1],
            r1: args.data[2],
          ),
        ),
      ];

  static Inject get to => Inject<O2ResultAndroidModule>.of();
}
