import 'package:SpO2/app/shared/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'SpO2',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      initialRoute: '/process',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
