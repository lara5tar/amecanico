import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:group_button/group_button.dart';

import '../3-Controlador/ControladorCitas.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  bool init = true;
  String selected = 'Mes';

  Widget formatoSeleccionad() {
    switch (selected) {
      case 'Dia':
        return const DayView();
      case 'Semana':
        return const WeekView();
      case 'Mes':
        return const MonthView();
      default:
        return const MonthView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: CitasC().init(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.initCitas(context);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomRadioButton(
                    height: 50,
                    width: 120,
                    selectedBorderColor:
                        Theme.of(context).colorScheme.secondary,
                    unSelectedBorderColor:
                        Theme.of(context).colorScheme.secondary,
                    enableShape: true,
                    defaultSelected: selected,
                    elevation: 0,
                    absoluteZeroSpacing: false,
                    unSelectedColor: Colors.white,
                    buttonLables: const [
                      'Dia',
                      'Semana',
                      'Mes',
                    ],
                    buttonValues: const [
                      'Dia',
                      'Semana',
                      'Mes',
                    ],
                    buttonTextStyle: const ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    radioButtonValue: (value) {
                      setState(() {
                        selected = value.toString();
                      });
                    },
                    selectedColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Expanded(
                  child: formatoSeleccionad(),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
