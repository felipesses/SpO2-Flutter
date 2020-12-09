import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'about_controller.g.dart';

@Injectable()
class AboutController = _AboutControllerBase with _$AboutController;

abstract class _AboutControllerBase with Store {}
