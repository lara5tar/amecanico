import 'dart:io';

import 'package:amecanico/3-Controlador/ImagenControlador.dart';
import 'package:flutter/material.dart';

class ImageControlador {
  File? image;
  ImageService service = ImageService();

  Future<dynamic> dialogoVerImagen(BuildContext context, File? imagen) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Imagen del coche'),
        content:
            imagen != null ? Image.file(imagen) : const Text('No hay imagen'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  limpiarImagen() {
    image = null;
    service.imagenX = null;
  }

  tomarFoto() async {
    image = await service.tomarImagen();
  }

  seleccionarFoto() async {
    image = await service.imagenDeGaleria();
  }

  imageExist() {
    return image != null;
  }
}
