import 'package:amecanico/2-Vista/Navegacion.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import '1-Modelo/CalendarioEventData.dart';
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

initFlutter() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Coche>(CocheAdapter());
  Hive.registerAdapter<Cliente>(ClienteAdapter());
  await Hive.openBox<Cliente>('clientes');

  Hive.registerAdapter<CalendarEventData>(CalendarEventDataAdapter());
  await Hive.openBox<CalendarEventData>('citas');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xff2c3e50,
            <int, Color>{
              50: Color(0xffe6a02e),
              100: Color(0xffe6a02e),
              200: Color(0xffe6a02e),
              300: Color(0xffe6a02e),
              400: Color(0xffe6a02e),
              500: Color(0xffe6a02e),
              600: Color(0xffe6a02e),
              700: Color(0xffe6a02e),
              800: Color(0xffe6a02e),
              900: Color(0xffe6a02e),
            },
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
