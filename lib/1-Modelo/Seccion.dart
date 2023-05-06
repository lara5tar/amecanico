import 'package:amecanico/1-Modelo/Campo.dart';
import 'package:flutter/material.dart';

class Seccion {
  String titulo;
  List<SubSeccion> subSecciones;
  Seccion({
    required this.titulo,
    required this.subSecciones,
  });

  Widget construirWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          ...subSecciones.map((subSeccion) => Column(
                children: [
                  subSeccion.construirWidget(context),
                  subSeccion == subSecciones.last
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
              )),
        ],
      ),
    );
  }
}

class SubSeccion {
  String subtitulo;
  List<Campo> campos;
  SubSeccion({
    required this.subtitulo,
    required this.campos,
  });

  Widget construirWidget(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: subtitulo == '' ? 0 : 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subtitulo == ''
              ? const SizedBox()
              : Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      subtitulo,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
          SizedBox(height: subtitulo == '' ? 0 : 10),
          ...campos.map((campo) => campo.construirWidget(context)),
        ],
      ),
    );
  }
}
