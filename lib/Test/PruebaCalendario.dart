import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:intl/intl.dart';

import '../3-Controlador/ControladorCitas.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
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
      case 'Citas':
        return ListView.builder(
          itemCount: citasC.citasBox!.length,
          itemBuilder: (BuildContext context, int index) {
            var cita = citasC.citasBox!.getAt(index);
            return ListTile(
              onTap: () {},
              title: Text(cita!.title.toString()),
              subtitle:
                  Text(DateFormat('dd/MM/yyyy hh:mm a').format(cita.date)),
              trailing: IconButton(
                onPressed: () {
                  citasC.eliminarCita(index, context);
                  setState(() {});
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
        );
      case 'Mes':
        return MonthView(
          minMonth: DateTime.now(),
          headerStyle: HeaderStyle(
            decoration: BoxDecoration(
              color: isDarkMode(context),
            ),
          ),
          onCellTap: (events, date) {
            print(date);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GenerarCitaPage(fecha: date),
              ),
            ).then((value) => setState(() {}));
          }, // onDateTapped(context),
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
                      'Citas',
                      'Mes',
                    ],
                    buttonValues: const [
                      'Citas',
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

class GenerarCitaPage extends StatefulWidget {
  //cremae la variable fecha de tipo DateTime
  final DateTime fecha;

  GenerarCitaPage({Key? key, required this.fecha}) : super(key: key);

  @override
  _GenerarCitaPageState createState() => _GenerarCitaPageState();
}

class _GenerarCitaPageState extends State<GenerarCitaPage> {
  final nom = TextEditingController();
  final tel = TextEditingController();
  final dia = TextEditingController();
  final controlador = TextEditingController();
  final busqueda = TextEditingController();
  final titulo = TextEditingController();
  final desc = TextEditingController();
  final controladorHora = TextEditingController();

  TimeOfDay? _selectedTime;

  void _showTimePicker() async {
    print('object');
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    print('object2');
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        print(_selectedTime!.format(context));
      });
    }
  }

  DateTime fecha = DateTime.now();
  @override
  void initState() {
    super.initState();
    fecha = widget.fecha;
    controlador.text =
        fecha.toString().replaceRange(10, fecha.toString().length, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar Cita'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.grey[900]),
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Datos de la cita',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Titulo de la cita',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titulo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Titulo de cita',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fecha de la cita',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Fecha de cita',
                      ),
                      controller: controlador,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 55,
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: fecha,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2033),
                          ).then((pickedDate) {
                            if (pickedDate == null) {
                              return;
                            }
                            setState(() {
                              controlador.text = pickedDate
                                  .toString()
                                  .replaceRange(10, 23, '');
                              fecha = pickedDate;
                            });
                          });
                        },
                        child: const Icon(Icons.calendar_month_sharp),
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hora de la cita',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Hora de cita',
                      ),
                      controller: controladorHora,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 55,
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((pickedTime) {
                            if (pickedTime == null) {
                              return;
                            }
                            setState(() {
                              controladorHora.text = pickedTime.format(context);
                              fecha = DateTime(
                                fecha.year,
                                fecha.month,
                                fecha.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            });
                          });
                        },
                        child: const Icon(Icons.timer_rounded),
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text('Descripción de la cita'),
              const SizedBox(height: 10),
              TextField(
                controller: desc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  confirmarcita();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.done_all_rounded),
                    const SizedBox(width: 10),
                    Text("Generar cita"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void buscarcliente() {
    //CONTENIDO
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Error al generar cita"),
      content:
          const Text("Ingresa una fecha de cita y un título para la misma..."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void confirmarcita() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  '¿Estás seguro de generar la cita?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controlador.text.isEmpty || titulo.text.isEmpty) {
                        showAlertDialog(context);
                      } else {
                        CitasC citas = CitasC();
                        citas.iniciar();
                        citas.agregarCita(
                          titulo: titulo.text,
                          descripcion: desc.text,
                          fecha: fecha,
                          horaInicio: fecha,
                          horaFin: fecha,
                          color: Colors.orangeAccent,
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Generar Cita'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}


// Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: busqueda,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         labelText: 'Buscar cliente',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     height: 55,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         buscarcliente();
//                       },
//                       child: const Icon(Icons.search_rounded),
//                       style: ButtonStyle(
//                         shape: MaterialStatePropertyAll(
//                           CircleBorder(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 height: 3,
//                 color: Colors.grey,
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Nombre completo del cliente',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Icon(Icons.person),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: nom,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   labelText: 'Nombre del cliente',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Teléfono del cliente',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Icon(Icons.phone_rounded),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: tel,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   labelText: 'Tel. del cliente',
//                 ),
//               ),
//               const SizedBox(height: 20),
