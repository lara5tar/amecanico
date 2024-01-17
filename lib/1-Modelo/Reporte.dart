import 'dart:convert';
import 'dart:io';

import 'package:amecanico/1-Modelo/Servicios.dart';
import 'package:amecanico/3-Controlador/reporteC.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import '../3-Controlador/ImagenControlador.dart';

import 'package:hive/hive.dart';

import '../3-Controlador/reportepdf.dart';

import 'package:path_provider/path_provider.dart';

@HiveType(typeId: 3)
class Reporte {
  @HiveField(0)
  String fecha;
  @HiveField(1)
  String hora;
  @HiveField(2)
  String nombreCliente;
  @HiveField(3)
  String telefonoCliente;
  @HiveField(4)
  String domicilioCliente;
  @HiveField(5)
  String coche;
  @HiveField(6)
  List<Servicio> servicios = [];
  @HiveField(7)
  List<String> imagenes = [];
  @HiveField(8)
  String conceptos;
  // @HiveField(9)
  // static int contador = 0;

  Reporte({
    required this.fecha,
    required this.hora,
    required this.nombreCliente,
    required this.telefonoCliente,
    required this.domicilioCliente,
    required this.coche,
    required this.servicios,
    required this.imagenes,
    required this.conceptos,
  }) {
    // contador = contador + 1;
  }

  Future<Directory> getDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  Widget construirWidget(bool finalizado) {
    ImagenControlador imagenC = ImagenControlador();
    imagenC.iniciar();
    ReporteC reporteC = ReporteC(reporte: this);
    return StatefulBuilder(
      builder: (context, setState) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Orden'),
          actions: [
            finalizado
                // ? Container()
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          // shape:
                          ),
                      onPressed: () async {
                        final dir = (await getDirectory()).path;
                        var pdf = await generateReporte(
                          PdfPageFormat.letter,
                          ticket: [
                            {
                              "tipo": "concepto",
                              "nombre": "Thermostato",
                              "seleccionado": 180.00,
                            },
                            {
                              "tipo": "concepto",
                              "nombre": "Reemplazo de Thermostato",
                              "seleccionado": 220.00,
                            },
                          ],
                          items: [
                            {
                              "tipo": "servicio",
                              "nombre": "Afinación Mayor Completa",
                            },
                            {
                              "tipo": "seccion",
                              "nombre": "Cambio de Bujias",
                            },
                            {
                              "tipo": "respuesta",
                              "nombre": "normal",
                              "seleccionado": "done",
                            },
                            {
                              "tipo": "respuesta",
                              "nombre": "Platino",
                              "seleccionado": "No aplica",
                            },
                            {
                              "tipo": "respuesta",
                              "nombre": "Iridium",
                              "seleccionado": "No aplica",
                            },
                          ],
                          domicilio: 'Buen Canada Linda Vista #320',
                          fecha: DateFormat('d MMMM yyyy [h:mm a]')
                              .format(DateTime.now()),
                          tel: '(833) 321 22 44',
                          tipoMantenimiento: 'Diagóstico',
                          cliente: 'Lupe',
                          datosGenerales: 'Jetta 2015',
                        );
                        final file = File('$dir/algo3.pdf');
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Reporte Generado'),
                            content: const Text(
                                'El reporte se ha generado correctamente'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Aceptar'))
                            ],
                          ),
                        );
                        await file.writeAsBytes(pdf).whenComplete(() {
                          Navigator.pop(context);
                        }).then((value) async {
                          // final dir = (await getDirectory()).path;
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Scaffold(
                          //       appBar: AppBar(),
                          //       body: PDFView(
                          //         filePath: '$dir/algo3.pdf',
                          //         enableSwipe: true,
                          //         swipeHorizontal: true,
                          //         autoSpacing: false,
                          //         pageFling: false,
                          //       ),
                          //     ),
                          //   ),
                          // );
                        });
                      },
                      child: const Text('PDF'),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          // shape:
                          ),
                      onPressed: () {
                        // print(toMap());
                        reporteC.finalizarReporte();
                        Navigator.pop(context);
                      },
                      child: const Text('Finalizar'),
                    ),
                  ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Fecha: ',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      fecha,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hora: ',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      hora,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Linea(),
                const Text(
                  'Datos del cliente',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Nombre:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        nombreCliente,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Telefono:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        telefonoCliente,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Domicilio:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        domicilioCliente,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Linea(),
                const Text(
                  'Datos del coche',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Coche:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        coche,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Linea(),
                const Text(
                  'Imagenes',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      finalizado
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                imagenC.tomarImagen().then((value) {
                                  setState(() {
                                    imagenC.guardarImagen().then((value) {
                                      setState(() {
                                        //reporteC.guardarRutaImagen(value!.path);
                                        imagenes.insert(0, value!.path);
                                        reporteC.guardarReporte();
                                      });
                                    });
                                  });
                                });
                              },
                              child: Container(
                                width: 120,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(Icons.add_a_photo,
                                    size: 50, color: Colors.white),
                              ),
                            ),
                      ...imagenes.map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scaffold(
                                  appBar: AppBar(),
                                  body: Center(
                                    child: Image.file(File(e)),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: File(e).existsSync()
                                ? Image.file(
                                    File(e),
                                    width: 120,
                                    height: 140,
                                  )
                                : Text(e
                                    .replaceAll('File:', '')
                                    .replaceAll('\'', '')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Linea(),
                const Text(
                  'Servicios',
                  style: TextStyle(fontSize: 30),
                ),
                Column(
                  children: [
                    ...servicios
                        .map((e) => e.construirWidget(
                            reporteC, servicios.indexOf(e), finalizado))
                        .toList(),
                  ],
                ),
                // Linea(),
                // Text(
                //   'Conceptos',
                //   style: TextStyle(fontSize: 30),
                // ),
                // SizedBox(height: 20),
                // Column(
                //   children: [
                //     // ...conceptos
                //     //     .map((e) =>
                //     //         Text(e['nombre']! + ': ' + e['seleccionado']!,
                //     //             style: TextStyle(
                //     //               fontSize: 20,
                //     //             )))
                //     //     .toList(),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container Linea() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      height: 3,
      color: Colors.grey,
    );
  }

  Reporte clone() {
    return Reporte(
      fecha: fecha,
      hora: hora,
      nombreCliente: nombreCliente,
      telefonoCliente: telefonoCliente,
      domicilioCliente: domicilioCliente,
      coche: coche,
      servicios: servicios.map((e) => e.clone()).toList(),
      imagenes: imagenes,
      conceptos: conceptos,
    );
  }

  // toMap() {
  //   return {
  //     'fecha': fecha,
  //     'hora': hora,
  //     'nombreCliente': nombreCliente,
  //     'telefonoCliente': telefonoCliente,
  //     'domicilioCliente': domicilioCliente,
  //     'coche': coche,
  //     'servicios': servicios.map((e) => e.toMap()).toList(),
  //     'imagenes': imagenes,
  //     'mapa': mapa,
  //   };
  // }

  //hacer un mapa de servicios solo si los campos no estan vacios

  toMap() {
    return [for (var i = 0; i < servicios.length; i++) ...servicios[i].toMap()];
  }
}

class ReporteAdapter extends TypeAdapter<Reporte> {
  @override
  // final int typeId = 3;
  final typeId = 3;

  @override
  Reporte read(BinaryReader reader) {
    return Reporte(
      fecha: reader.read(),
      hora: reader.read(),
      nombreCliente: reader.read(),
      telefonoCliente: reader.read(),
      domicilioCliente: reader.read(),
      coche: reader.read(),
      servicios: List<Servicio>.from(reader.read()),
      imagenes: List<String>.from(reader.read()),
      conceptos: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Reporte obj) {
    writer
      ..write(obj.fecha)
      ..write(obj.hora)
      ..write(obj.nombreCliente)
      ..write(obj.telefonoCliente)
      ..write(obj.domicilioCliente)
      ..write(obj.coche)
      ..write(obj.servicios)
      ..write(obj.imagenes)
      ..write(obj.conceptos);
  }
}
