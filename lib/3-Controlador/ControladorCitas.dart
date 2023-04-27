import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class citasC {
  Box<CalendarEventData> box = Hive.box<CalendarEventData>('citas');

  List<CalendarEventData> get listCitas => box.values.toList();

  initCitas(BuildContext context) {
    print(box.length);
    for (var i = 0; i < listCitas.length; i++) {
      CalendarEventData prueba = listCitas[i];
      CalendarControllerProvider.of(context).controller.add(prueba);
    }
  }

  void agregarCita(
      {required String titulo,
      required String descripcion,
      required DateTime fecha,
      required DateTime horaInicio,
      required DateTime horaFin,
      required Color color,
      required String evento}) {
    box.put(
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
