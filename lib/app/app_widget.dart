import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/android/styles.dart';
import 'modules/ios/styles.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            navigatorKey: Modular.navigatorKey,
            title: 'SPO2',
            theme: androidTheme(),
            initialRoute: '/o2ProcessAndroid',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Modular.generateRoute,
          )
        : CupertinoApp(
            navigatorKey: Modular.navigatorKey,
            title: 'SpO2',
            theme: iosTheme(),
            initialRoute: '/o2ProcessIos',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Modular.generateRoute,
          );
  }
}
