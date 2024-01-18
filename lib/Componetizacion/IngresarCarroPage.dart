import 'dart:io';

import 'package:amecanico/3-Controlador/ImagenControlador.dart';
import 'package:amecanico/Componetizacion/CustomTextField.dart';
import 'package:amecanico/Componetizacion/ImagenController.dart';
import 'package:amecanico/Componetizacion/formularioCoche.dart';
import 'package:amecanico/Componetizacion/buildImageView.dart';
import 'package:amecanico/Componetizacion/validacionDatos.dart';
import 'package:flutter/material.dart';
import '../../1-Modelo/Cliente.dart';

//throw error
class IngresarCarroPage extends StatefulWidget {
  final Cliente cliente;
  final bool seGuardara;
  const IngresarCarroPage(
      {super.key, required this.cliente, required this.seGuardara});

  @override
  State<IngresarCarroPage> createState() => _IngresarCarroPageState();
}

class _IngresarCarroPageState extends State<IngresarCarroPage> {
  ImageControlador imageControlador = ImageControlador();

  List<CustomTextController> controladores = [
    CustomTextController('Marca'),
    CustomTextController('Modelo'),
    CustomTextController('Año'),
    CustomTextController('Motor'),
    CustomTextController('Vin'),
    CustomTextController('Kilometros'),
    CustomTextController('Placas'),
    CustomTextController('Color'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresa el vehiculo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            buildImagenView(context, imageControlador),
            const SizedBox(height: 20),
            Column(children: getFormulario(context, controladores))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          validacionDatos(
            context,
            widget.cliente,
            controladores,
            imageControlador.service,
          );
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
