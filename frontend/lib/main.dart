// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_integrador_3/controllers/userController.dart';
import 'package:proyecto_integrador_3/login_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  Get.put(LoginController()); // Inicializa el controlador LoginController
  Get.put(PerfilController()); // Inicializa el controlador LoginController
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final VerificarToken _token = VerificarToken();
  @override
  void initState() {
    super.initState();
    print("inicio");
    // _token.checkLoginStatus();
    print("salida");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const LoginPage()),
      ],
    );
  }
}
