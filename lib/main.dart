import 'package:amecanico/Vista/AgregarReoporte.dart';
import 'package:amecanico/Vista/Navegacion.dart';
import 'package:amecanico/Vista/testl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //systemNavigationBarColor: Color(0xFF545058),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: EjemploFormulario(),
    );
  }
}
