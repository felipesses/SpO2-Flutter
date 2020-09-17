import 'package:SpO2/app/modules/about/about_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AboutModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => AboutPage()),
      ];

  static Inject get to => Inject<AboutModule>.of();
}
