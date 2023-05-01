import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class TomarImagen extends StatefulWidget {
  const TomarImagen({super.key});

  @override
  State<TomarImagen> createState() => _TomarImagenState();
}

class _TomarImagenState extends State<TomarImagen> {
  Directory? imagenesCochesPath;
  @override
  void initState() {
    super.initState();
    iniciar();
  }

  void iniciar() async {
    final directory = await getExternalStorageDirectory();
    final path = directory!.path;
    imagenesCochesPath = Directory('$path/ImagenesCoches');
    if (!await imagenesCochesPath!.exists()) {
      await imagenesCochesPath!.create(recursive: true);
    }
  }

  File? imagen;
  // Método para seleccionar una imagen de la galería
  Future<File?> pickImageFromGallery() async {
    final imagenCargada =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagenCargada != null) {
      final result = await FlutterImageCompress.compressWithFile(
        imagenCargada.path,
        quality: 20, // Establecer la calidad de la imagen comprimida
      );
      if (result == null) return null;
      return await File('${imagenesCochesPath!.path}/${imagenCargada.name}')
          .writeAsBytes(result);
    }
    return null;
  }

  Future<File?> takePicture() async {
    final imagenTomada =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagenTomada != null) {
      final result = await FlutterImageCompress.compressWithFile(
        imagenTomada.path,
        quality: 20, // Establecer la calidad de la imagen comprimida
      );

      if (result == null) return null;
      String ruta = '${imagenesCochesPath!.path}/${imagenTomada.name}';
      return await File(ruta).writeAsBytes(result);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomar Imagen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imagen != null
              ? Image.file(
                  imagen!,
                  width: 200,
                  height: 200,
                )
              : const Text('No hay imagen seleccionada'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  pickImageFromGallery().then((imageFile) {
                    if (imageFile != null) {
                      imagen = imageFile;
                      setState(() {});
                    }
                  });
                },
                child: const Text('Imagen de Galería'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  takePicture().then((imageFile) {
                    if (imageFile != null) {
                      imagen = imageFile;
                      setState(() {});
                    }
                  });
                },
                child: const Text('Tomar Foto'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
