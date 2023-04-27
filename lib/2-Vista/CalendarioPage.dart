import 'package:amecanico/3-Controlador/ControladorCitas.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  @override
  void initState() {
    super.initState();
    CalendarControllerProvider.of(context).controller.add(
          CalendarEventData(
            event: 'Evento Prueba',
            title: 'Evento Prueba',
            date: DateTime(2023, 4, 27),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                citasC().initCitas(context);
                //servicios mas
                // print(Hive.box<CalendarEventData>('citas').get('evento1'));
                // // CalendarControllerProvider.of(context).controller.add(
                // //       CalendarEventData(
                // //         event: 'Evento Prueba',
                // //         title: 'Evento Prueba',
                // //         date: DateTime(2023, 4, 27),
                // //       ),
                // //     );
                // CalendarEventData? prueba =
                //     Hive.box<CalendarEventData>('citas').get('evento1');
                // if (prueba != null)
                //   CalendarControllerProvider.of(context).controller.add(
                //         prueba,
                //       );
              },
              child: const Text('Agregar Cita'),
            ),
          ),
          Expanded(
              child: MonthView(
            onEventTap: (event, date) => print(event),
          )),
        ],
      ),
    );
  }
}
