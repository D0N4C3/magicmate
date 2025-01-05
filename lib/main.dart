// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:magicmate_organizer/intro_Screen/addintro_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helpar/get_di.dart' as di;
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await di.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: onbording(),
    ),
  );
}
