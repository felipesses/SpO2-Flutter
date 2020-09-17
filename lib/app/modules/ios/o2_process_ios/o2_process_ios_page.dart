import 'dart:ffi';

import 'package:SpO2/app/controllers/process_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wakelock/wakelock.dart';
import '../../../app_controller.dart';
import 'package:image/image.dart' as imglib;

import '../styles.dart';

typedef convert_func = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

class O2ProcessIosPage extends StatefulWidget {
  @override
  _O2ProcessIosPageState createState() => _O2ProcessIosPageState();
}

class _O2ProcessIosPageState
    extends ModularState<O2ProcessIosPage, ProcessController>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Wakelock.toggle(on: false);
    super.dispose();

    Wakelock.disable();
    controller.camera.dispose();
    controller.animationController.dispose();
    controller.cameraInitialized = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("APP_STATE: $state");

    if (state == AppLifecycleState.resumed) {
      // user returned to our app
      controller.startTime = DateTime.now().toUtc().millisecondsSinceEpoch;
      controller.initializeCamera().then((value) {
        Wakelock.enable();
      });
    } else if (state == AppLifecycleState.paused) {
      controller.camera.dispose();
      controller.cameraInitialized = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFFFFFFF),
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/logo.png',
              fit: BoxFit.fill,
              alignment: FractionalOffset.topLeft,
              width: 150,
              height: 50,
            ),
            Image.asset(
              'images/governo.png',
              fit: BoxFit.fill,
              alignment: FractionalOffset.topRight,
              width: 100,
              height: 50,
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 10,
              ),
              child: Text(
                'Protótipo de medição de Sp02 em construção/validação (para monitorar/apoiar diagnóstico use um Oxímetro com selo da ANVISA)',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Container(
                width: 120,
                height: 120,
                color: CupertinoColors.systemRed,
                child: Observer(
                  builder: (_) {
                    return controller.cameraInitialized
                        ? AspectRatio(
                            aspectRatio: controller.camera.value.aspectRatio,
                            child: CameraPreview(
                              controller.camera,
                            ),
                          )
                        : Container();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Text(
                'Mantenha o dedo indicador por 30 segundos na câmera',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: controller.animationController,
                              builder: (_, Widget child) {
                                return Text(
                                  '${controller.totalTimeInSecs.toInt()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 60,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CupertinoButton(
                        onPressed: () {
                          Modular.to.pushNamed('/about');
                        },
                        child: Text(
                          'SOBRE',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            letterSpacing: 1.5,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
