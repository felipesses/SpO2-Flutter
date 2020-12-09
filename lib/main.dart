import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:SpO2/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    ModularApp(
      module: AppModule(),
    ),
  );
}
