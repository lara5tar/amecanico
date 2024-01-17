import 'package:amecanico/1-Modelo/Cliente.dart';
import 'package:flutter/material.dart';

class PruebaPDF extends StatefulWidget {
  const PruebaPDF({super.key});

  @override
  State<PruebaPDF> createState() => _PruebaPDFState();
}

class _PruebaPDFState extends State<PruebaPDF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba PDF'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Cliente cliente = Cliente(
                //   nombre: 'Juan',
                //   telefono: '123456789',
                //   domicilio: 'Calle 1',
                //   coches: [],
                // );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Scaffold(
                //       appBar: AppBar(
                //         title: const Text('PDF generado'),
                //       ),
                //       body: PdfPreview(
                //         build: (context) => PdfControlador().hacerPDF(cliente),
                //       ),
                //     ),
                //   ),
                // );
              },
              child: const Text('Generar PDF'),
            ),
          ),
        ],
      ),
    );
  }
}
