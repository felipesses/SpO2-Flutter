import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  bool success;

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
          "mobile": "FL - $manufacturer $modelAndroid",
          "uid": v4,
          "userInfo": obs,
        },
      ).then((_) {
        isLoading = false;

        Modular.to.showDialog(
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              title: Text("Dados registrados"),
              content: Text("Obrigado!"),
              actions: [
                RaisedButton(
                  child: Text("Fechar"),
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            );
          },
        );
      }).catchError((error) {
        print(error);
        isLoading = false;
        Modular.to.showDialog(
          barrierDismissible: true,
          builder: (_) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text("Tente novamente"),
              actions: [
                RaisedButton(
                  child: Text("Retornar"),
                  onPressed: () {
                    Modular.to.pop();
                  },
                )
              ],
            );
          },
        );
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
      ).then((_) {
        isLoading = false;

        Modular.to.showDialog(
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              title: Text("Dados registrados"),
              content: Text("Obrigado!"),
              actions: [
                RaisedButton(
                  child: Text("Fechar"),
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            );
          },
        );
      }).catchError((error) {
        print(error);
        isLoading = false;
        Modular.to.showDialog(
          barrierDismissible: true,
          builder: (_) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text("Tente novamente"),
              actions: [
                RaisedButton(
                  child: Text("Retornar"),
                  onPressed: () {
                    Modular.to.pop();
                  },
                )
              ],
            );
          },
        );
      });

      isLoading = false;
    }
  }
}
