import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'o2_result_android_controller.g.dart';

class O2ResultAndroidController = _O2ResultAndroidControllerBase
    with _$O2ResultAndroidController;

abstract class _O2ResultAndroidControllerBase with Store {}
