import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import '../3-Controlador/ControladorCitas.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class Cp extends StatefulWidget {
  const Cp({super.key});

  @override
  State<Cp> createState() => _CpState();
}

class _CpState extends State<Cp> {
  bool init = true;
  String selected = 'Mes';

  Color isDarkMode(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return Colors.deepOrangeAccent;
    } else {
      return Colors.white;
    }
  }

  Widget formatoSeleccionad(CitasC citasC) {
    switch (selected) {
      case 'Dia':
        return DayView(
          headerStyle: HeaderStyle(
            decoration: BoxDecoration(
              color: isDarkMode(context),
            ),
          ),
          backgroundColor: Colors.transparent,
          heightPerMinute: 1.5,
          onDateTap: (date) {
            citasC.agregarCitaPorSeleccion(date);
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Container(
                  height: 320,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Agregar Cita',
                          style: TextStyle(fontSize: 30),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Titulo',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Descripcion',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  citasC.agregarCitaPorSeleccion(date);
                                  Navigator.pop(context);
                                },
                                child: const Text('Agregar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            print(date);
            setState(() {});
          },
        );
      case 'Semana':
        return WeekView(
          headerStyle: HeaderStyle(
            decoration: BoxDecoration(
              color: isDarkMode(context),
            ),
          ),
          backgroundColor: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          heightPerMinute: 2,
          onDateTap: (date) {
            print(date);
          },
        );
      case 'Mes':
        return MonthView(
          headerStyle: HeaderStyle(
            decoration: BoxDecoration(
              color: isDarkMode(context),
            ),
          ),
          onCellTap: (events, date) {
            print(date);
          },
        );
      default:
        return MonthView(
          onCellTap: (events, date) {
            print(date);
          },
        );
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
                    unSelectedColor: Colors.transparent,
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
                      unSelectedColor: Colors.deepOrangeAccent,
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
                  child: formatoSeleccionad(snapshot.data!),
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
