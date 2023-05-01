import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImagenC {
  Directory? imagenesCochesPath;
  XFile? imagenX;

  void iniciar() async {
    final directory = await getExternalStorageDirectory();
    final path = directory!.path;
    imagenesCochesPath = Directory('$path/ImagenesCoches');
    if (!await imagenesCochesPath!.exists()) {
      await imagenesCochesPath!.create(recursive: true);
    }
  }

  Future<File?> getImage(String nombre) async {
    //final path = '${imagenesCochesPath!.path}/$nombre';
    File imagen = File(nombre);
    if (await imagen.exists()) {
      return imagen;
    }
    return null;
  }

  Future<File?> guardarImagen() async {
    if (imagenX == null) return null;
    final result = await FlutterImageCompress.compressWithFile(
      imagenX!.path,
      quality: 20, // Establecer la calidad de la imagen comprimida
    );

    if (result == null) return null;
    String ruta = '${imagenesCochesPath!.path}/${imagenX!.name}';
    return await File(ruta).writeAsBytes(result);
  }

  Future<File?> imagenDeGaleria() async {
    final imagenCargada =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagenCargada != null) {
      final result = await FlutterImageCompress.compressWithFile(
        imagenCargada.path,
        quality: 20, // Establecer la calidad de la imagen comprimida
      );
      if (result == null) return null;
      imagenX = imagenCargada;
      return await File(imagenCargada.path).writeAsBytes(result);
      // imagenX = imagenCargada;
      // return File(imagenCargada.path);
    }
    return null;
  }

  Future<File?> tomarImagen() async {
    final imagenTomada =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagenTomada != null) {
      final result = await FlutterImageCompress.compressWithFile(
        imagenTomada.path,
        quality: 20, // Establecer la calidad de la imagen comprimida
      );

      if (result == null) return null;
      imagenX = imagenTomada;
      String ruta = imagenTomada.path;
      return await File(ruta).writeAsBytes(result);
      // imagenX = imagenTomada;
      // return File(imagenTomada.path);
    }
    return null;
  }
}
