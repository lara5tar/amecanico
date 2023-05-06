import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class CampoCheckBox extends StatefulWidget {
  final List<String> opciones;
  final List<String> entradas;
  final ValueChanged<List<String>> alSeleccionarOpciones;
  final ValueChanged<List<String>> alSeleccionarEntradas;

  const CampoCheckBox({
    super.key,
    required this.opciones,
    required this.entradas,
    required this.alSeleccionarEntradas,
    required this.alSeleccionarOpciones,
  });

  @override
  State<CampoCheckBox> createState() => _CampoCheckBoxState();
}

class _CampoCheckBoxState extends State<CampoCheckBox> {
  List<String> respuestasEntradas = [];
  String respuesta = '';

  Widget seleccionado(String seleccionado, bool selected, bool bool) {
    if (seleccionado.contains('done')) {
      return Icon(
        Icons.done,
        color: selected ? Colors.green[400] : Colors.green[800],
        size: bool ? 50 : 0,
      );
    } else if (seleccionado.contains('close')) {
      return Icon(
        Icons.close,
        color: selected ? Colors.amber[400] : Colors.amber[800],
        size: bool ? 50 : 0,
      );
    } else if (seleccionado.contains('f/s')) {
      return ImageIcon(
        color: selected ? Colors.red[400] : Colors.red[900],
        AssetImage('assets/FS.png'),
        size: bool ? 50 : 0,
      );
    } else {
      return Icon(Icons.touch_app);
    }
  }

  colorSeleccionado(String seleccionado, bool selected) {
    if (seleccionado.contains('done')) {
      return selected ? Colors.green[400] : Colors.white;
    } else if (seleccionado.contains('close')) {
      return selected ? Colors.amber[400] : Colors.white;
    } else if (seleccionado.contains('f/s')) {
      return selected ? Colors.red[400] : Colors.white;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...widget.opciones.map(
            (opcion) => AnimatedContainer(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: CheckboxListTile(
                      activeColor: Colors.white,
                      checkColor: Colors.grey[800],
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(opcion, style: const TextStyle(fontSize: 25)),
                      value: respuestasEntradas.contains(opcion),
                      onChanged: (value) {
                        if (value == true) {
                          respuestasEntradas.add(opcion);
                        } else {
                          respuestasEntradas.remove(opcion);
                        }
                        widget.alSeleccionarEntradas(respuestasEntradas);
                        setState(() {});
                      },
                    ),
                  ),
                  GroupButton(
                    //entradas
                    onSelected: (value, index, isSelected) {
                      // if (value == 'done') {
                      //   respuesta = 'Correcto';
                      // } else if (value == 'close') {
                      //   respuesta = 'Incorrecto';
                      // } else if (value == 'f/s') {
                      //   respuesta = 'Falta/ Sobran';
                      // } else {
                      //   respuesta = '';
                      // }
                      widget.alSeleccionarOpciones(respuestasEntradas);
                      setState(() {});
                    },
                    buttons: widget.entradas,
                    buttonBuilder: (selected, value, context) {
                      return AnimatedContainer(
                        margin: EdgeInsets.only(
                            bottom:
                                respuestasEntradas.contains(opcion) ? 10 : 0),
                        duration: const Duration(milliseconds: 200),
                        height: respuestasEntradas.contains(opcion) ? 80 : 0,
                        width: 80,
                        decoration: BoxDecoration(
                          color: selected ? Colors.grey[900] : Colors.white,
                          border: Border.all(
                            width: 3,
                            color: colorSeleccionado(value, selected),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            seleccionado(value, selected,
                                respuestasEntradas.contains(opcion)),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
