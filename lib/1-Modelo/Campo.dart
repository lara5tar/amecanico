import 'package:amecanico/Test/CampoCheckBox.dart';
import 'package:amecanico/Test/CampoRadioButton.dart';
import 'package:flutter/material.dart';

class Campo {
  //ID
  String tipo;
  List<String> opciones;
  List<String> entradas;
  //mapa de respuestas

  Campo({
    required this.tipo,
    required this.opciones,
    required this.entradas,
  }) {
    //Llenar respuestas
    //for i que recorra opciones.length
    //respuestas[i] = mapa[ID][opciones[i]]
    //
  }

  Widget construirWidget(BuildContext context) {
    if (tipo == 'check') {
      return CampoCheckBox(
        opciones: opciones,
        entradas: entradas,
        alSeleccionarEntradas: (List<String> value) {
          print('entradas: ');
          print(value);
        },
        alSeleccionarOpciones: (List<String> value) {
          print('opciones: ');
          print(value);
        },
      );
    } else if (tipo == 'radio') {
      return CampoRadioButton(
        opciones: opciones,
        entradas: entradas,
        alSeleccionarEntrada: (value) {},
        alSeleccionarOpcion: (value) {},
      );
    } else if (tipo == 'text') {
      return CampoTexto(
        opcion: opciones[0],
        alEscribirRespuesta: (value) {
          print('respuesta: ');
          print(value);
        },
      );
    }
    return Container();
  }
}

class CampoTexto extends StatefulWidget {
  String opcion;
  final ValueChanged<String> alEscribirRespuesta;
  CampoTexto(
      {super.key, required this.opcion, required this.alEscribirRespuesta});

  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.opcion,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(height: 10),
          TextField(
            maxLines: null,
            onChanged: (value) {
              widget.alEscribirRespuesta(value);
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
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
