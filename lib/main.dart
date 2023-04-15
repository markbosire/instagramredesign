import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';

import 'package:instagram_redesign/firebase_options.dart';

import 'package:instagram_redesign/views/root.dart';
import 'package:get/get.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/configurations/firebase_constants.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firebaseInitialization.then((value) {
    // we are going to inject the auth controller over here!
    Get.put(AuthController());
  });

  // ignore: prefer_const_constructors
  HttpOverrides.global = new MyHttpOverrides();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,

    // ignore: prefer_const_constructors

    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: logoImageAsset("logo.png", scale: 0.5),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
