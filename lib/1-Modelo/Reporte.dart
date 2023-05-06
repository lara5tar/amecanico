import 'dart:io';

import 'package:amecanico/1-Modelo/Servicios.dart';
import 'package:flutter/material.dart';

import '../3-Controlador/ImagenC.dart';

class Reporte {
  String fecha;
  String hora;
  String nombreCliente;
  String telefonoCliente;
  String domicilioCliente;
  String coche;
  List<Servicio> servicios = [];
  List<String> imagenes = [];

  Reporte({
    required this.fecha,
    required this.hora,
    required this.nombreCliente,
    required this.telefonoCliente,
    required this.domicilioCliente,
    required this.coche,
    required this.servicios,
    required this.imagenes,
  });

  Widget construirWidget() {
    ImagenC imagenC = ImagenC();
    imagenC.iniciar();
    return StatefulBuilder(
      builder: (context, setState) => Container(
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20, right: 20, left: 20),
        decoration: BoxDecoration(
            color: Colors.grey[900], borderRadius: BorderRadius.circular(30)),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      : Text(e.replaceAll('File:', '').replaceAll('\'', '')),
                ),
              ),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    imagenC.tomarImagen().then((value) {
                      setState(() {
                        imagenC.guardarImagen().then((value) {
                          setState(() {
                            print('path');
                            print('path' + value.toString());
                            imagenes.add(value!.path);
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
                    child:
                        Icon(Icons.add_a_photo, size: 50, color: Colors.white),
                  ),
                )
              ],
            ),
            Linea(),
            Text(
              'Servicios',
              style: TextStyle(fontSize: 30),
            ),
            Column(
              children: [
                ...servicios.map((e) => e.construirWidget()).toList(),
              ],
            ),
          ],
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
}
