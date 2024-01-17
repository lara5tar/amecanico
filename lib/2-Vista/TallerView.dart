import 'dart:io';

import 'package:amecanico/1-Modelo/Coche.dart';
import 'package:amecanico/3-Controlador/ControladorCitas.dart';
import 'package:amecanico/Test/PruebaCalendario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../1-Modelo/Cliente.dart';
import '../3-Controlador/clientesC.dart';

class TallerView extends StatefulWidget {
  const TallerView({super.key});

  @override
  State<TallerView> createState() => _TallerViewState();
}

class _TallerViewState extends State<TallerView> {
  Ccliente ccliente = Ccliente();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Coches en reparacion/revision',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          for (Cliente cliente in ccliente.clientes.values)
            for (Coche coche in cliente.coches)
              if (coche.seleccionado)
                ListTile(
                  titleTextStyle: TextStyle(fontSize: 20),
                  leading: File(coche.imagen).existsSync()
                      ? Image.file(File(coche.imagen))
                      : SizedBox(),
                  title: Text('${coche.marca} ${coche.modelo} ${coche.color}'),
                  subtitle: Text(cliente.nombre),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Coche entregado'),
                              content: Text(
                                  '¿Desea agendar una cita para ${coche.marca} ${coche.modelo} ${coche.color}?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      coche.entregado = true;
                                      coche.seleccionado = false;
                                      Ccliente().guardarCambios(cliente);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GenerarCitaPage(
                                            fecha: DateTime.now(),
                                          ),
                                        ),
                                      ).then((value) => Navigator.pop(context));

                                      // coche.seleccionado = false;
                                      // ccliente.clientes.put(
                                      //     cliente.id, cliente);
                                      // Navigator.pop(context);
                                    });
                                  },
                                  child: Text('Si'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No'),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Coches por entregar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          for (Cliente cliente in ccliente.clientes.values)
            for (Coche coche in cliente.coches)
              if (coche.entregado)
                ListTile(
                  titleTextStyle: TextStyle(fontSize: 20),
                  leading: File(coche.imagen).existsSync()
                      ? Image.file(File(coche.imagen))
                      : SizedBox(),
                  title: Text('${coche.modelo} ${coche.marca} ${coche.color}'),
                  subtitle: Text(cliente.nombre),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Coche entregado'),
                              content: Text(
                                  '¿Estas seguro de que el coche ${coche.modelo} ${coche.marca} ${coche.color} ha sido entregado?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      coche.entregado = false;
                                      Ccliente().guardarCambios(cliente);
                                      //mostrar un dialogo donde pueda agendar una cita para un dentro de un lapso de tiempo que el usuario ingrese
                                      TextEditingController meses =
                                          TextEditingController();
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Agendar cita'),
                                          content: Container(
                                            height: 150,
                                            child: Column(
                                              children: [
                                                Text(
                                                    '¿Desea agendar una recordatorio para una nueva cita ${coche.marca} ${coche.modelo} ${coche.color} dentro de un tiempo?'),
                                                TextField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: meses,
                                                  decoration: InputDecoration(
                                                    hintText: 'Meses',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  CitasC citasC = CitasC();
                                                  citasC.iniciar();
                                                  citasC.agregarCita(
                                                    titulo:
                                                        'recordatorio nueva cita para ${coche.marca} ${coche.modelo} ${coche.color}',
                                                    descripcion:
                                                        'recordatorio de entrega de coche',
                                                    fecha: DateTime.now().add(
                                                      Duration(
                                                          days: int.parse(
                                                                  meses.text) *
                                                              30),
                                                    ),
                                                    color: Colors.blueGrey,
                                                    horaFin: DateTime.now().add(
                                                      Duration(
                                                          days: int.parse(
                                                                  meses.text) *
                                                              30),
                                                    ),
                                                    horaInicio:
                                                        DateTime.now().add(
                                                      Duration(
                                                          days: int.parse(
                                                                  meses.text) *
                                                              30),
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  // coche.entregado = true;
                                                  // coche.seleccionado = false;
                                                  // Ccliente()
                                                  //     .guardarCambios(cliente);
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         GenerarCitaPage(
                                                  //       fecha:
                                                  //           DateTime.now().add(
                                                  //         Duration(
                                                  //           days: int.parse(
                                                  //                   meses
                                                  //                       .text) *
                                                  //               30,
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ).then((value) =>
                                                  //     Navigator.pop(context));

                                                  // coche.seleccionado = false;
                                                  // ccliente.clientes.put(
                                                  //     cliente.id, cliente);
                                                  // Navigator.pop(context);
                                                });
                                              },
                                              child: Text('Si'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text('No'),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  child: Text('Si'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No'),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
