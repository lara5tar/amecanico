import 'package:amecanico/2-Vista/Navegacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

import '1-Modelo/Cliente.dart';
import '1-Modelo/Coche.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  initFlutter();
  runApp(const MyApp());
}

void initFlutter() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ClienteAdapter());
  await Hive.openBox<Cliente>('clientes');

  Hive.registerAdapter(CocheAdapter());
  await Hive.openBox<Coche>('coches');
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
      home: const HomePage(),
    );
  }
}
