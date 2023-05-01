import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class CitasC {
  Box<CalendarEventData>? citasBox;

  Future<CitasC> init(context) async {
    await Hive.initFlutter();
    citasBox = await Hive.openBox<CalendarEventData>('citas');
    initCitas(context);
    return this;
  }

  void initCitas(BuildContext context) {
    if (!citasBox!.isOpen) {
      print('no esta abierto');
      return;
    }
    CalendarControllerProvider.of(context)
        .controller
        .addAll(citasBox!.values.toList());
    // for (var i = 0; i < citasBox!.length; i++) {
    //   print(citasBox!.getAt(i)?.title);
    //   if (citasBox!.getAt(i) != null) {
    //     CalendarEventData cita = citasBox!.getAt(i)!;
    //     CalendarControllerProvider.of(context).controller.add(
    //           cita,
    //         );
    //     print(citasBox!.getAt(i)?.title);
    //   }
    // }
  }

  void agregarCitaPorSeleccion(DateTime date) {
    citasBox!.put(
      date.toString(),
      CalendarEventData(
        title: date.toString(),
        description: 'descripcion',
        date: date,
        startTime: date,
        endTime: date,
        color: Color(0xffe6a02e),
      ),
    );
  }

  void agregarCita(
      {required String titulo,
      required String descripcion,
      required DateTime fecha,
      required DateTime horaInicio,
      required DateTime horaFin,
      required Color color,
      required String evento}) {
    citasBox!.put(
      titulo,
      CalendarEventData(
        title: titulo,
        description: descripcion,
        date: fecha,
        startTime: horaInicio,
        endTime: horaFin,
        color: color,
        event: evento,
      ),
    );
  }
}
