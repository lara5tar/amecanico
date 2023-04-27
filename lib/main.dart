import 'package:amecanico/2-Vista/CalendarioPage.dart';
import 'package:amecanico/2-Vista/Navegacion.dart';
import 'package:amecanico/3-Controlador/ControladorCitas.dart';
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
  //metodo sin parametros y sin retorno
  //metodo con paraemtros y sin retorno
  //metodo sin parametros y con retorno
  //metodo con paraemtros y con retorno

  // Cliente prueba = Cliente(
  //     coches: [], domicilio: 'calle x', nombre: 'yisus', telefono: '34174938');
  // prueba.partirPastel();
  // prueba.partirPastelPorNumero(10);
  // print('se le regreso a ' + prueba.partirPastelyDar());
  // print('se le regreso a ' + prueba.partirPastelyDarPorNumeroyNombre(3, 'ana'));

  await Hive.initFlutter();
  Hive.registerAdapter<Coche>(CocheAdapter());
  Hive.registerAdapter<Cliente>(ClienteAdapter());
  await Hive.openBox<Cliente>('clientes');

  Hive.registerAdapter<CalendarEventData>(CalendarEventDataAdapter());
  var caja = await Hive.openBox<CalendarEventData>('Citas');

  CalendarEventData event = CalendarEventData(
    date: DateTime.now(),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 2)),
    title: 'Reunión de trabajo',
    description: 'Reunión de equipo para discutir el progreso del proyecto',
    color: Colors.orange,
    // Reemplazar 'null' con tu objeto T si es necesario
    titleStyle: TextStyle(color: Colors.white, fontSize: 16),
    descriptionStyle: TextStyle(color: Colors.white, fontSize: 12),
  );
  CalendarEventData event1 = CalendarEventData(
    date: DateTime.now(),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(hours: 2)),
    title: 'trabajo',
    description: 'Reunión de equipo para discutir el progreso del proyecto',
    color: Colors.orange,
    // Reemplazar 'null' con tu objeto T si es necesario
    titleStyle: TextStyle(color: Colors.white, fontSize: 16),
    descriptionStyle: TextStyle(color: Colors.white, fontSize: 12),
  );

  // Ejemplo de cómo guardar un evento en la caja de eventos
  await caja.put('evento1', event);
  await caja.put('evento2', event1);

  // Ejemplo de cómo obtener un evento de la caja de eventos
  CalendarEventData? savedEvent = caja.get('evento1');

  print(savedEvent?.title);
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
        home: const CalendarioPage(),
      ),
    );
  }
}
