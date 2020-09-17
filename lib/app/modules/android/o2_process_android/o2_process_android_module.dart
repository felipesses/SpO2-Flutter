import 'package:SpO2/app/controllers/process_controller.dart';
import 'package:SpO2/app/modules/android/o2_result_android/o2_result_android_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'o2_process_android_controller.dart';
import 'o2_process_android_page.dart';

class O2ProcessAndroidModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ProcessController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => O2ProcessAndroidPage()),
        Router('/o2ResultAndroid',
            module: O2ResultAndroidModule(),
            transition: TransitionType.rightToLeft),
      ];

  static Inject get to => Inject<O2ProcessAndroidModule>.of();
}
