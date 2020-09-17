import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:SpO2/app/app_controller.dart';
import 'package:SpO2/app/controllers/process_controller.dart';
import 'package:SpO2/app/shared/styles.dart';
import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wakelock/wakelock.dart';

import 'package:image/image.dart' as imglib;

import '../styles.dart';

class O2ProcessAndroidPage extends StatefulWidget {
  @override
  _O2ProcessAndroidPageState createState() => _O2ProcessAndroidPageState();
}

class _O2ProcessAndroidPageState
    extends ModularState<O2ProcessAndroidPage, ProcessController>
    with WidgetsBindingObserver, TickerProviderStateMixin {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                'images/capasprojeto.jpg',
                fit: BoxFit.fill,
                alignment: FractionalOffset.topLeft,
                width: MediaQuery.of(context).size.width,
                height: 50,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
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
            padding: const EdgeInsets.only(
              top: 50,
            ),
            child: Container(
              width: 150,
              height: 150,
              color: Colors.red,
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
          SizedBox(
            height: 20,
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
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          color: primaryColor,
          child: Text(
            'SOBRE',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          onPressed: () {
            Modular.to.pushReplacementNamed('/about');
          },
        ),
      ),
    );
  }
}
