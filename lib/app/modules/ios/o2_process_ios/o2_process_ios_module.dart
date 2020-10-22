import 'package:SpO2/app/controllers/process_controller.dart';
import 'package:SpO2/app/modules/ios/o2_result_ios/o2_result_ios_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'o2_process_ios_controller.dart';
import 'o2_process_ios_page.dart';

class O2ProcessIosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ProcessController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => O2ProcessIosPage()),
        ModularRouter('/o2ResultIos',
            module: O2ResultIosModule(),
            transition: TransitionType.rightToLeft),
      ];

  static Inject get to => Inject<O2ProcessIosModule>.of();
}
