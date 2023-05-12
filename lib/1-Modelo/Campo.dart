import 'package:amecanico/3-Controlador/reporteC.dart';
import 'package:amecanico/Test/CampoCheckBox.dart';
import 'package:amecanico/Test/CampoRadioButton.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

@HiveType(typeId: 6)
class Campo {
  //ID
  @HiveField(0)
  String tipo;
  @HiveField(1)
  List<String> opciones;
  @HiveField(2)
  List<String> entradas;
  @HiveField(3)
  Map<String, String> respuestas = {};

  Campo({
    required this.tipo,
    required this.opciones,
    required this.entradas,
    required this.respuestas,
    //required this.alSeleccionarRespuestas,
  });

  Widget construirWidget(
      BuildContext context, ReporteC reporteC, bool finalizado) {
    if (tipo == 'check') {
      return CampoCheckBox(
        opciones: opciones,
        entradas: entradas,
        alSeleccionarRespuestas: (Map<String, String> value) {
          // print(value);
          respuestas = value;
          reporteC.guardarReporte();
        },
        respuestas: respuestas,
        finalizado: finalizado,
      );
    } else if (tipo == 'radio') {
      return CampoRadioButton(
        opciones: opciones,
        entradas: entradas,
        alSeleccionarRespuesta: (Map<String, String> value) {
          // print(value);
          respuestas = value;
          reporteC.guardarReporte();
        },
        respuestas: respuestas,
        finalizado: finalizado,
      );
    } else if (tipo == 'text') {
      return CampoTexto(
        opcion: opciones[0],
        alEscribirRespuesta: (Map<String, String> value) {
          // print(value);
          respuestas = value;
          reporteC.guardarReporte();
        },
        respuestas: respuestas,
      );
    }
    return Container();
  }

  Campo clone() {
    return Campo(
      tipo: tipo,
      opciones: opciones,
      entradas: entradas,
      respuestas: respuestas,
    );
  }

  toMap() {
    return [
      for (var i = 0; i < opciones.length; i++)
        if (respuestas[opciones[i]] != null)
          {
            'tipo': 'respuesta',
            'nombre': opciones[i],
            'seleccionado': respuestas[opciones[i]],
          }
    ];
  }
}

//adaptador de hive, type id 6

class CampoAdapter extends TypeAdapter<Campo> {
  @override
  // final typeId = 6;
  final typeId = 6;

  @override
  Campo read(BinaryReader reader) {
    return Campo(
      tipo: reader.read(),
      opciones: List<String>.from(reader.read()),
      entradas: List<String>.from(reader.read()),
      respuestas: Map<String, String>.from(reader.read()),
    );
  }

  @override
  void write(BinaryWriter writer, Campo obj) {
    writer
      ..write(obj.tipo)
      ..write(obj.opciones)
      ..write(obj.entradas)
      ..write(obj.respuestas);
  }
}

class CampoTexto extends StatefulWidget {
  String opcion;
  final ValueChanged<Map<String, String>> alEscribirRespuesta;
  Map<String, String> respuestas;
  CampoTexto({
    super.key,
    required this.opcion,
    required this.alEscribirRespuesta,
    required this.respuestas,
  });

  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.respuestas[widget.opcion] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            widget.opcion,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            maxLines: null,
            onChanged: (value) {
              widget.alEscribirRespuesta({widget.opcion: value});
              widget.respuestas = {widget.opcion: value};
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              hintText: 'Escribe aqui...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                //borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
