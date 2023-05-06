import 'dart:typed_data';
import 'package:amecanico/1-Modelo/Cliente.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfControlador {
  Future<Uint8List> hacerPDF(Cliente cliente) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: [
              pw.Text(cliente.nombre),
              pw.Text(cliente.telefono),
              pw.Text(cliente.domicilio),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
