import 'package:flutter_modular/flutter_modular.dart';
import '../../controllers/result_controller.dart';

import 'o2_result_page.dart';

class O2ResultModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ResultController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => O2ResultPage(
            o2: args.data[0],
            bpm: args.data[1],
            r1: args.data[2],
          ),
        ),
      ];

  static Inject get to => Inject<O2ResultModule>.of();
}
