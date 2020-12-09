import 'package:SpO2/app/controllers/process_controller.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'o2_process_page.dart';

class O2ProcessModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ProcessController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => O2ProcessPage()),
      ];

  static Inject get to => Inject<O2ProcessModule>.of();
}
