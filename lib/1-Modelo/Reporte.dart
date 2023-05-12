import 'dart:io';

import 'package:amecanico/1-Modelo/Servicios.dart';
import 'package:amecanico/3-Controlador/reporteC.dart';
import 'package:flutter/material.dart';

import '../3-Controlador/ImagenC.dart';

import 'package:hive/hive.dart';

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
  Map<String, dynamic> mapa = {};
  @HiveField(9)
  static int contador = 0;

  Reporte({
    required this.fecha,
    required this.hora,
    required this.nombreCliente,
    required this.telefonoCliente,
    required this.domicilioCliente,
    required this.coche,
    required this.servicios,
    required this.imagenes,
    required this.mapa,
  }) {
    contador = contador + 1;
  }

  Widget construirWidget(bool finalizado) {
    ImagenC imagenC = ImagenC();
    imagenC.iniciar();
    ReporteC reporteC = ReporteC(reporte: this);
    return StatefulBuilder(
      builder: (context, setState) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text('Reporte'),
          actions: [
            finalizado
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          // shape:
                          ),
                      onPressed: () {
                        // print(toMap());
                        reporteC.finalizarReporte();
                        Navigator.pop(context);
                      },
                      child: Text('Finalizar'),
                    ),
                  ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Linea(),
                Text(
                  'Datos del cliente',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Nombre:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      nombreCliente,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Telefono:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      telefonoCliente,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Domicilio:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      domicilioCliente,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Linea(),
                Text(
                  'Datos del coche',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Coche:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      coche,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Linea(),
                Text(
                  'Imagenes',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20),
                Container(
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
                                child: Icon(Icons.add_a_photo,
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
                            margin: EdgeInsets.all(10),
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
                Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container Linea() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
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
      mapa: mapa,
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
      mapa: Map<String, dynamic>.from(reader.read()),
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
      ..write(obj.mapa);
  }
}
