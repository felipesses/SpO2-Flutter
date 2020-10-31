import 'dart:ffi';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:image/image.dart' as imgLib;

import 'package:SpO2/app/modules/math/fft.dart';
import 'package:SpO2/app/shared/components/image_processing.dart';
import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:wakelock/wakelock.dart';

part 'o2_process_ios_controller.g.dart';

class O2ProcessIosController = _O2ProcessIosControllerBase
    with _$O2ProcessIosController;

typedef convert_func = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

abstract class _O2ProcessIosControllerBase with Store {
  final DynamicLibrary convertImageLib = DynamicLibrary.process();
  Convert conv;

  @observable
  CameraController camera;

  @observable
  bool cameraInitialized = false;

  @observable
  CameraImage savedImage;

  FFT fft = new FFT();

  double sumRed = 0;
  double sumGreen = 0;
  double sumBlue = 0;
  int bpm;
  double r1 = 0.0;
  double stdb = 0.0;
  double stdr = 0.0;
  double a = 100;
  double b = -5;
  int o2 = 0;

  List<double> redAvgList = new List<double>();
  List<double> blueAvgList = new List<double>();
  List<double> greenAvgList = new List<double>();

  @observable
  double totalTimeInSecs = 0.0;

  @observable
  int counter = 0;

  int startTime = 0;
  double samplingFrequency;

  _O2ProcessIosControllerBase() {
    conv = convertImageLib
        .lookup<NativeFunction<convert_func>>('convertImage')
        .asFunction<Convert>();
    initializeCamera().then((value) {
      Wakelock.enable();
    });

    startTime = DateTime.now().toUtc().millisecondsSinceEpoch;
    // Wakelock.enable();
  }

  @action
  Future initializeCamera() async {
    // Pegando lista de cameras no dispositivo
    List<CameraDescription> cameras = await availableCameras();

    // Iniciando controller da câmera
    camera = new CameraController(cameras[0], ResolutionPreset.max);

    camera.initialize().then((_) async {
      // Iniciando stream da câmera

      await camera.startImageStream((image) => processCameraImage(image));

      cameraInitialized = true;

      camera.enableTorch();
    });
  }

  @action
  processCameraImage(CameraImage image) async {
    savedImage = image;
    imgLib.Image img;

    img = imgLib.Image.fromBytes(
      savedImage.planes[2].bytesPerRow,
      savedImage.height,
      savedImage.planes[2].bytes,
      format: imgLib.Format.bgra,
    );

    // Pointer<Uint8> p2 = allocate(count: savedImage.planes[2].bytes.length);

    // Uint8List pointerList2 = p2.asTypedList(savedImage.planes[2].bytes.length);

    // pointerList2.setRange(
    //     0, savedImage.planes[2].bytes.length, savedImage.planes[2].bytes);

    double redAvg;
    double blueAvg;
    double greenAvg;

    redAvg = ImageProcessing.decodeYUV420SPtoRedBlueGreenAvg(
      img.getBytes(),
      176,
      144,
      1,
    );

    sumRed = sumRed + redAvg;

    blueAvg = ImageProcessing.decodeYUV420SPtoRedBlueGreenAvg(
      img.getBytes(),
      176,
      144,
      2,
    );

    sumBlue = sumBlue + blueAvg / 3;

    greenAvg = ImageProcessing.decodeYUV420SPtoRedBlueGreenAvg(
      img.getBytes(),
      176,
      144,
      3,
    );

    sumGreen = sumGreen + greenAvg;

    redAvgList.add(redAvg);
    // blueAvgList.add(blueAvg);
    blueAvgList.add(blueAvg / 3);
    greenAvgList.add(greenAvg);

    ++counter;
    if (redAvg < 200) {
      counter = 0;
      startTime = DateTime.now().toUtc().millisecondsSinceEpoch;
    }

    int endTime = DateTime.now().toUtc().millisecondsSinceEpoch;

    totalTimeInSecs = (endTime - startTime) / 1000;

    if (totalTimeInSecs >= 30) {
      startTime = DateTime.now().toUtc().millisecondsSinceEpoch;

      samplingFrequency = (counter / totalTimeInSecs);

      List<double> red = redAvgList.toList();
      List<double> blue = blueAvgList.toList();
      // List<double> green = greenAvgList.toList();

      double hrFreq = fft.fft(red, counter, samplingFrequency);

      bpm = (hrFreq * 60).toInt();

      double meanR = sumRed / counter;
      // double meanB = (sumBlue / 3) / counter;
      double meanB = sumBlue / counter;

      // Calcula o desvio-padrão das medidas dos componentes vermelho e azul do tecido

      for (int i = 0; i < counter - 1; i++) {
        double bufferb = blue[i] / 3;
        stdb = stdb + ((bufferb - meanB) * (bufferb - meanB));
        double bufferr = red[i];
        stdr = stdr + ((bufferr - meanR) * (bufferr - meanR));
      }

      double varR = math.sqrt(stdr / (counter - 1));
      double varB = math.sqrt(stdb / (counter - 1));

      r1 = (varR / meanR) / (varB / meanB);

      double spo2 = 100 - 5 * r1;

      o2 = spo2.toInt();

      if ((o2 < 30 || o2 > 100) || (bpm < 35 || bpm > 200)) {
        counter = 0;
        startTime = DateTime.now().toUtc().millisecondsSinceEpoch;
      }

      if (o2 != 0 && o2 < 100 && o2 > 30) {
        camera.dispose();
        Modular.to.pushReplacementNamed(
          '/o2ResultIos',
          arguments: [
            o2,
            bpm,
            r1,
          ],
        );
      }
    }
  }
}
