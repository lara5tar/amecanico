import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class CampoCheckBox extends StatefulWidget {
  final List<String> opciones;
  final List<String> entradas;
  final ValueChanged<Map<String, String>> alSeleccionarRespuestas;
  final Map<String, String> respuestas;
  final bool finalizado;

  const CampoCheckBox({
    super.key,
    required this.opciones,
    required this.entradas,
    required this.alSeleccionarRespuestas,
    required this.respuestas,
    required this.finalizado,
  });

  @override
  State<CampoCheckBox> createState() => _CampoCheckBoxState();
}

class _CampoCheckBoxState extends State<CampoCheckBox> {
  List<String> respuestasEntradas = [];
  Map<String, String> opcionesEntradasMap = {};
  List<GroupButtonController> controllers = [];

  @override
  void initState() {
    super.initState();
    opcionesEntradasMap = widget.respuestas;
    respuestasEntradas = widget.respuestas.keys.toList();
    controllers = List.generate(
      widget.opciones.length,
      (index) => GroupButtonController(),
    );
    for (int i = 0; i < controllers.length; i++) {
      //entra si existe respuesta en el indice de la opcion
      if (widget.respuestas.keys.toList().contains(widget.opciones[i])) {
        //selecciona el indice de la opcion en el controlador
        controllers[i].selectIndex(
            widget.entradas.indexOf(widget.respuestas[widget.opciones[i]]!));
        if (widget.finalizado) {
          controllers[i].disableIndexes([0, 1, 2]);
        }
      }
    }
  }

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
            (opcion) {
              return AnimatedContainer(
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
                        enabled: !widget.finalizado,
                        activeColor: Colors.white,
                        checkColor: Colors.grey[800],
                        controlAffinity: ListTileControlAffinity.leading,
                        title:
                            Text(opcion, style: const TextStyle(fontSize: 25)),
                        value: respuestasEntradas.contains(opcion),
                        onChanged: (value) {
                          if (value == true) {
                            respuestasEntradas.add(opcion);
                            opcionesEntradasMap
                                .addEntries([MapEntry(opcion, 'No aplica')]);
                          } else {
                            respuestasEntradas.remove(opcion);
                            opcionesEntradasMap.remove(opcion);
                          }
                          widget.alSeleccionarRespuestas(opcionesEntradasMap);
                          setState(() {});
                        },
                      ),
                    ),
                    !respuestasEntradas.contains(opcion)
                        ? const SizedBox(height: 0)
                        : GroupButton(
                            // maxSelected: widget.finalizado ? 0 : 1,
                            controller: controllers[widget.opciones
                                .indexOf(opcion)], //asigna el controlador
                            onSelected: (value, index, isSelected) {
                              opcionesEntradasMap[opcion] = value;
                              widget
                                  .alSeleccionarRespuestas(opcionesEntradasMap);
                              setState(() {});
                            },
                            buttons: widget.entradas,
                            buttonBuilder: (selected, value, context) {
                              return AnimatedContainer(
                                margin: EdgeInsets.only(
                                  bottom: respuestasEntradas.contains(opcion)
                                      ? 10
                                      : 0,
                                ),
                                duration: const Duration(milliseconds: 200),
                                height: respuestasEntradas.contains(opcion)
                                    ? 80
                                    : 0,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? Colors.grey[900]
                                      : Colors.white,
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
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
