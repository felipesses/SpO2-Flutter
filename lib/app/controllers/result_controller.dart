// import 'dart:io';

// import 'package:device_info/device_info.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:mobx/mobx.dart';
// import 'package:uuid/uuid.dart';

// import '../../main.dart';
// part 'result_controller.g.dart';

// class ResultController = _ResultControllerBase with _$ResultController;

// abstract class _ResultControllerBase with Store {
//   final FirebaseDatabase firebaseDatabase = new FirebaseDatabase();
//   TextEditingController obs = new TextEditingController();

//   var uuid = Uuid();

//   @observable
//   bool isLoading = false;

//   @action
//   void changeLoading({bool loading}) {
//     isLoading = loading;
//   }

//   @observable
//   bool success;

//   @action
//   sendData(
//       int o2, int mensured, String obs, double r1, Function onPressed) async {
//     isLoading = true;
//     changeLoading(loading: true);
//     var v4 = uuid.v4();
//     var androidInfo;
//     var iosInfo;

//     if (Platform.isAndroid) {
//       androidInfo = await DeviceInfoPlugin().androidInfo;
//       var manufacturer = androidInfo.manufacturer;
//       var modelAndroid = androidInfo.model;
//       DatabaseReference _dataRef =
//           firebaseDatabase.reference().child('CollectData').child(v4);

//       _dataRef.set(
//         {
//           "datetime": DateTime.now().toString(),
//           "mensuredOnAPP": o2,
//           "mensuredOnEQP": mensured,
//           "mobile": "FESF - $manufacturer $modelAndroid",
//           "uid": v4,
//           "userInfo": obs,
//         },
//       ).then((_) {
//         Modular.to.showDialog(
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Dados registrados"),
//               content: Text("Obrigado!"),
//               actions: [
//                 RaisedButton(
//                   child: Text("Retornar"),
//                   onPressed: onPressed,
//                 )
//               ],
//             );
//           },
//         );
//       }).catchError((error) {
//         print(error);
//         isLoading = false;
//         Modular.to.showDialog(
//           barrierDismissible: true,
//           builder: (_) {
//             return AlertDialog(
//               title: Text("Erro"),
//               content: Text("Tente novamente"),
//               actions: [
//                 RaisedButton(
//                   child: Text("Retornar"),
//                   onPressed: () {
//                     Modular.to.pop();
//                   },
//                 )
//               ],
//             );
//           },
//         );
//       });

//       isLoading = false;
//     } else if (Platform.isIOS) {
//       isLoading = true;

//       iosInfo = await DeviceInfoPlugin().iosInfo;

//       var version = iosInfo.systemVersion;
//       var name = iosInfo.name;
//       var modelIos = iosInfo.model;

//       DatabaseReference _dataRef =
//           firebaseDatabase.reference().child('CollectData').child(v4);

//       isLoading = true;

//       _dataRef.set(
//         {
//           "datetime": DateTime.now().toString(),
//           "mensuredOnAPP": o2,
//           "mensuredOnEQP": mensured,
//           "mobile": "FESF - $version, $name $modelIos",
//           "uid": v4,
//           "userInfo": obs,
//         },
//       ).then((_) {
//         Modular.to.showDialog(
//           barrierDismissible: true,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Dados registrados"),
//               content: Text("Obrigado!"),
//               actions: [
//                 RaisedButton(
//                   child: Text("Retornar"),
//                   onPressed: onPressed,
//                 )
//               ],
//             );
//           },
//         );
//       }).catchError((error) {
//         print(error);
//         isLoading = false;
//         Modular.to.showDialog(
//           barrierDismissible: true,
//           builder: (_) {
//             return AlertDialog(
//               title: Text("Erro"),
//               content: Text("Tente novamente"),
//               actions: [
//                 RaisedButton(
//                   child: Text("Retornar"),
//                   onPressed: () {
//                     Modular.to.pop();
//                   },
//                 )
//               ],
//             );
//           },
//         );
//       });
//     }
//   }
// }
