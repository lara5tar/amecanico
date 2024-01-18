import 'dart:io';

import 'package:amecanico/1-Modelo/Cliente.dart';
import 'package:amecanico/3-Controlador/ImagenControlador.dart';
import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:amecanico/Componetizacion/CustomTextField.dart';
import 'package:amecanico/Componetizacion/utilities.dart';
import 'package:flutter/material.dart';

Future<void> validacionDatos(
  BuildContext context,
  Cliente cliente,
  List<CustomTextController> controllers,
  ImageService imagenController,
) async {
  if (_isValid(controllers)) {
    File? image = await imagenController.guardarImagen();
    Ccliente().agregarCocheACliente(
      cliente,
      controllers,
      image?.path ?? '',
    );
    scaffoldMessenger(context, 'Coche agregado');
    Navigator.pop(context);
  } else {
    scaffoldMessenger(context, 'Llena todos los campos');
  }
}

bool _isValid(List<CustomTextController> controllers) {
  bool isValidate = true;
  for (var element in controllers) {
    if (element.getText().isEmpty) {
      isValidate = false;
    }
  }
  return isValidate;
}
