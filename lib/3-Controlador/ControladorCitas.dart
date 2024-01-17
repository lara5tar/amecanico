import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CitasC {
  Box<CalendarEventData>? citasBox;

  //lista de citas del dia de hoy
  List<CalendarEventData> get citasHoy {
    if (citasBox == null) {
      return [];
    }
    return citasBox!.values
        .where((element) =>
            element.date.day == DateTime.now().day &&
            element.date.month == DateTime.now().month &&
            element.date.year == DateTime.now().year)
        .toList();
  }

  //lista de citas de mañana
  List<CalendarEventData> get citasManana {
    if (citasBox == null) {
      return [];
    }
    return citasBox!.values
        .where((element) =>
            element.date.day == DateTime.now().day + 1 &&
            element.date.month == DateTime.now().month &&
            element.date.year == DateTime.now().year)
        .toList();
  }

  //lista de citas de la semana
  List<CalendarEventData> get citasSemana {
    if (citasBox == null) {
      return [];
    }
    return citasBox!.values
        .where((element) =>
            element.date.day >= DateTime.now().day &&
            element.date.day <= DateTime.now().day + 9 &&
            element.date.month == DateTime.now().month &&
            element.date.year == DateTime.now().year)
        .toList();
  }

  iniciar() {
    citasBox = Hive.box<CalendarEventData>('citas');
  }

  Future<CitasC> init(context) async {
    await Hive.initFlutter();
    citasBox = await Hive.openBox<CalendarEventData>('citas');
    initCitas(context);
    print('se inicio');
    return this;
  }

  void initCitas(BuildContext context) {
    if (!citasBox!.isOpen) {
      print('no esta abierto');
      return;
    }
    CalendarControllerProvider.of(context).controller.addAll(
          citasBox!.values.toList(),
        );
    print('se iniciarion la lista de citas');
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

  void agregarCita({
    required String titulo,
    required String descripcion,
    required DateTime fecha,
    required DateTime horaInicio,
    required DateTime horaFin,
    required Color color,
  }) {
    citasBox!.add(
      CalendarEventData(
        title: titulo,
        description: descripcion,
        date: fecha,
        startTime: horaInicio,
        endTime: horaFin,
        color: color,
      ),
    );
  }

  void eliminarCita(int index, context) {
    CalendarControllerProvider.of(context)
        .controller
        .remove(citasBox!.getAt(index)!);
    citasBox!.deleteAt(index);
  }
}
