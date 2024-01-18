import 'package:amecanico/Componetizacion/ImagenController.dart';
import 'package:flutter/material.dart';

buildImagenView(BuildContext context, ImageControlador controller) {
  return StatefulBuilder(
    builder: (context, setState) => Row(
      children: [
        GestureDetector(
          onTap: () {
            controller.dialogoVerImagen(context, controller.image);
          },
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[300],
              image: controller.imageExist()
                  ? DecorationImage(
                      image: FileImage(controller.image!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: controller.imageExist()
                ? null
                : Icon(
                    Icons.camera_alt_rounded,
                    size: 70,
                    color: Colors.grey[700],
                  ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              controller.imageExist()
                  ? Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.limpiarImagen();
                              setState(() {});
                            },
                            child: const Text('Limpiar imagen'),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.tomarFoto();
                    setState(() {});
                  },
                  child: const Text('Tomar foto'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.seleccionarFoto();
                    setState(() {});
                  },
                  child: const Text(
                    'Seleccionar foto de galeria',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
