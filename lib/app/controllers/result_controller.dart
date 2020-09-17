import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
part 'result_controller.g.dart';

class ResultController = _ResultControllerBase with _$ResultController;

abstract class _ResultControllerBase with Store {
  final FirebaseDatabase firebaseDatabase = new FirebaseDatabase();
  TextEditingController obs = new TextEditingController();

  var uuid = Uuid();

  @observable
  bool isLoading = false;

  @action
  void changeLoading({bool loading}) {
    isLoading = loading;
  }

  @observable
  bool success = false;

  @action
  sendData(int o2, String obs, double r1) async {
    var v4 = uuid.v4();
    var androidInfo;
    var iosInfo;

    if (Platform.isAndroid) {
      androidInfo = await DeviceInfoPlugin().androidInfo;
      var manufacturer = androidInfo.manufacturer;
      var modelAndroid = androidInfo.model;
      DatabaseReference _dataRef =
          firebaseDatabase.reference().child('CollectData').child(v4);

      isLoading = true;

      _dataRef.set(
        {
          "datetime": DateTime.now().toString(),
          "mensuredOnAPP": o2,
          "mensuredOnEQP": o2,
          // "mobile": Platform.isAndroid
          //     ? "FL - $manufacturer $modelAndroid"
          //     : "FL - $version, $name $modelIos",
          "mobile": "FL - $manufacturer $modelAndroid",
          "uid": v4,
          "userInfo": obs,
        },
      ).then((value) {
        success = true;
      }).catchError((error) {
        print(error);
        isLoading = false;
        success = false;
      });

      isLoading = false;
    } else if (Platform.isIOS) {
      iosInfo = await DeviceInfoPlugin().iosInfo;

      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var modelIos = iosInfo.model;

      DatabaseReference _dataRef =
          firebaseDatabase.reference().child('CollectData').child(v4);

      isLoading = true;

      _dataRef.set(
        {
          "datetime": DateTime.now().toString(),
          "mensuredOnAPP": o2,
          "mensuredOnEQP": o2,
          "mobile": "FL - $version, $name $modelIos",
          "uid": v4,
          "userInfo": obs,
        },
      ).then((value) {
        success = true;
      }).catchError((error) {
        print(error);
        isLoading = false;
        success = false;
      });

      isLoading = false;
    }
  }
}
