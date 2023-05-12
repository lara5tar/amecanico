import 'package:amecanico/1-Modelo/Campo.dart';
import 'package:amecanico/3-Controlador/reporteC.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class Seccion {
  @HiveField(0)
  String titulo;
  @HiveField(1)
  List<Campo> campos;

  Seccion({
    required this.titulo,
    required this.campos,
  });

  Widget construirWidget(
      BuildContext context, ReporteC reporteC, int servicio, bool finalizado) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                titulo,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ...campos.map(
            (campo) => Column(
              children: [
                campo.construirWidget(context, reporteC, finalizado),
                campo == campos.last
                    ? const SizedBox()
                    : Container(
                        height: 4,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(30),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Seccion clone() {
    List<Campo> camposClonados = [];
    campos.forEach((campo) {
      camposClonados.add(campo.clone());
    });
    return Seccion(
      titulo: titulo,
      campos: camposClonados,
    );
  }

  toMap() {
    var lista = [];
    for (var campo in campos) {
      if (campo.respuestas.isNotEmpty) {
        lista.addAll(campo.toMap());
      }
    }

    if (lista.isNotEmpty) {
      return [
        {
          'tipo': 'seccion',
          'nombre': titulo,
        },
        ...lista,
      ];
    }
    return [];
  }
}

//hazme el adaptador pra hive, el type id es 5

class SeccionAdapter extends TypeAdapter<Seccion> {
  @override
  // final int typeId = 5;
  final typeId = 5;

  @override
  Seccion read(BinaryReader reader) {
    return Seccion(
      titulo: reader.read(),
      campos: List<Campo>.from(reader.read()),
    );
  }

  @override
  void write(BinaryWriter writer, Seccion obj) {
    writer
      ..write(obj.titulo)
      ..write(obj.campos);
  }
}
