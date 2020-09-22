import 'package:flutter/material.dart';
import 'package:SpO2/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
    ),
  );
}
