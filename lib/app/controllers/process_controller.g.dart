// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProcessController on _ProcessControllerBase, Store {
  final _$cameraAtom = Atom(name: '_ProcessControllerBase.camera');

  @override
  CameraController get camera {
    _$cameraAtom.reportRead();
    return super.camera;
  }

  @override
  set camera(CameraController value) {
    _$cameraAtom.reportWrite(value, super.camera, () {
      super.camera = value;
    });
  }

  final _$cameraInitializedAtom =
      Atom(name: '_ProcessControllerBase.cameraInitialized');

  @override
  bool get cameraInitialized {
    _$cameraInitializedAtom.reportRead();
    return super.cameraInitialized;
  }

  @override
  set cameraInitialized(bool value) {
    _$cameraInitializedAtom.reportWrite(value, super.cameraInitialized, () {
      super.cameraInitialized = value;
    });
  }

  final _$savedImageAtom = Atom(name: '_ProcessControllerBase.savedImage');

  @override
  CameraImage get savedImage {
    _$savedImageAtom.reportRead();
    return super.savedImage;
  }

  @override
  set savedImage(CameraImage value) {
    _$savedImageAtom.reportWrite(value, super.savedImage, () {
      super.savedImage = value;
    });
  }

  final _$totalTimeInSecsAtom =
      Atom(name: '_ProcessControllerBase.totalTimeInSecs');

  @override
  double get totalTimeInSecs {
    _$totalTimeInSecsAtom.reportRead();
    return super.totalTimeInSecs;
  }

  @override
  set totalTimeInSecs(double value) {
    _$totalTimeInSecsAtom.reportWrite(value, super.totalTimeInSecs, () {
      super.totalTimeInSecs = value;
    });
  }

  final _$counterAtom = Atom(name: '_ProcessControllerBase.counter');

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  final _$initializeCameraAsyncAction =
      AsyncAction('_ProcessControllerBase.initializeCamera');

  @override
  Future<dynamic> initializeCamera() {
    return _$initializeCameraAsyncAction.run(() => super.initializeCamera());
  }

  final _$processCameraImageAsyncAction =
      AsyncAction('_ProcessControllerBase.processCameraImage');

  @override
  Future processCameraImage(CameraImage image) {
    return _$processCameraImageAsyncAction
        .run(() => super.processCameraImage(image));
  }

  @override
  String toString() {
    return '''
camera: ${camera},
cameraInitialized: ${cameraInitialized},
savedImage: ${savedImage},
totalTimeInSecs: ${totalTimeInSecs},
counter: ${counter}
    ''';
  }
}
