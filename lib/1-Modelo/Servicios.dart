import 'dart:convert';

import 'package:amecanico/3-Controlador/reporteC.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Seccion.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class Servicio {
  @HiveField(0)
  String titulo;
  @HiveField(1)
  List<Seccion> secciones;

  Servicio({
    required this.titulo,
    required this.secciones,
  });

  Widget construirWidget(
      ReporteC reporteC, int indexServicio, bool finalizado) {
    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VistaServicios(
                titulo: titulo,
                secciones: secciones,
                reporteC: reporteC,
                finalizado: finalizado,
              ),
            ),
          ).then((value) => setState(() {}));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      titulo,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Servicio clone() {
    return Servicio(
      titulo: titulo,
      secciones: secciones.map((e) => e.clone()).toList(),
    );
  }

  toMap() {
    var lista = [];
    for (var seccion in secciones) {
      if (seccion.toMap().isNotEmpty) {
        lista.addAll(seccion.toMap());
      }
    }

    if (lista.isNotEmpty) {
      return [
        {
          'tipo': 'servicio',
          'nombre': titulo,
        },
        ...lista
      ];
    }

    return [];
  }
}

class VistaServicios extends StatelessWidget {
  const VistaServicios({
    super.key,
    required this.titulo,
    required this.secciones,
    required this.reporteC,
    this.finalizado = false,
  });

  final String titulo;
  final List<Seccion> secciones;
  final ReporteC reporteC;
  final bool finalizado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(titulo),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       TextEditingController nombre = TextEditingController();
          //       TextEditingController precio = TextEditingController();
          //       showDialog(
          //         context: context,
          //         builder: (context) => AlertDialog(
          //           title: Text('Agregar Concepto\$'),
          //           content: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               TextField(
          //                 controller: nombre,
          //                 decoration: InputDecoration(
          //                   labelText: 'Nombre',
          //                 ),
          //               ),
          //               TextField(
          //                 inputFormatters: [
          //                   FilteringTextInputFormatter.allow(
          //                       RegExp(r'^\d+\.?\d{0,2}'))
          //                 ],
          //                 keyboardType:
          //                     TextInputType.numberWithOptions(decimal: true),
          //                 controller: precio,
          //                 decoration: InputDecoration(
          //                   labelText: 'Precio',
          //                 ),
          //               ),
          //             ],
          //           ),
          //           actions: [
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.pop(context);
          //               },
          //               child: Text('Cancelar'),
          //             ),
          //             TextButton(
          //               onPressed: () {
          //                 var conecpto = {
          //                   'tipo': 'concepto',
          //                   'nombre': nombre.text,
          //                   'seleccionado': precio.text.toString(),
          //                 };

          //                 String x = reporteC.reporte!.conceptos;
          //                 print(x);

          //                 List<dynamic> concepto = json.decode(x);

          //                 concepto.add(conecpto);

          //                 reporteC.reporte!.conceptos = json.encode(concepto);

          //                 reporteC.guardarReporte();
          //                 Navigator.pop(context);
          //               },
          //               child: Text('Aceptar'),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //     child: Text('Agregar Concepto \$'),
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...secciones
                .map(
                  (e) => e.construirWidget(
                    context,
                    reporteC,
                    secciones.indexOf(e),
                    finalizado,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class ServicioAdapter extends TypeAdapter<Servicio> {
  @override
  // final int typeId = 4;
  final typeId = 4;

  @override
  Servicio read(BinaryReader reader) {
    return Servicio(
      titulo: reader.read(),
      secciones: List<Seccion>.from(reader.read()),
    );
  }

  @override
  void write(BinaryWriter writer, Servicio obj) {
    writer
      ..write(obj.titulo)
      ..write(obj.secciones);
  }
}
