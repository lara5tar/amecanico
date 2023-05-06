import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

//VER SI GUARO LOS DATOS DE LOS CAMPOS COMO UN MAPA O COMO UNA LISTA DE STRINGS
//CONSULTAMOS CON UN MECANICO QUE DICE QUE NO SE CAMBIA EL ACEITE, SOLO SE REMPLAZA POR NUEVO PERO QUE DEPENDE DEL MECANICO
//lE AGRADA LA IDEA QUE USTED PUEDA PERSONALIZAR SU REPORTE PARA QUE PUEDA PONERLOS CAMPOS QUE QUIERA

class CampoRadioButton extends StatefulWidget {
  final List<String> opciones;
  final List<String> entradas;
  final ValueChanged<String> alSeleccionarOpcion;
  final ValueChanged<String> alSeleccionarEntrada;

  const CampoRadioButton({
    super.key,
    required this.opciones,
    required this.entradas,
    required this.alSeleccionarEntrada,
    required this.alSeleccionarOpcion,
  });

  @override
  State<CampoRadioButton> createState() => _CampoRadioButtonState();
}

class _CampoRadioButtonState extends State<CampoRadioButton> {
  int? groupValue = null;
  String opcion = '';
  String entrada = '';

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
        children: [
          Column(
            children: [
              ...widget.opciones.map(
                (e) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RadioListTile(
                      toggleable: true,
                      title: Text(
                        e,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      value: widget.opciones.indexOf(e),
                      groupValue: groupValue,
                      onChanged: (int? value) {
                        setState(
                          () {
                            opcion = value == null ? '' : e.toString();
                            widget.alSeleccionarOpcion(opcion);
                            groupValue = value;
                            setState(() {});
                          },
                        );
                      },
                    ),
                  );
                },
              ).toList(),
              Column(
                children: [
                  GroupButton(
                    onSelected: (value, index, isSelected) {
                      setState(() {
                        entrada = value;
                        widget.alSeleccionarEntrada(entrada);
                      });
                    },
                    buttonBuilder: (selected, value, context) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: groupValue != null ? 80 : 0,
                            width: 80,
                            decoration: BoxDecoration(
                              color: selected ? Colors.grey[800] : Colors.white,
                              border: Border.all(
                                width: 3,
                                color: colorSeleccionado(value, selected),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                seleccionado(
                                    value, selected, groupValue != null),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    buttons: widget.entradas,
                    options: GroupButtonOptions(
                      mainGroupAlignment: MainGroupAlignment.end,
                      spacing: 10,
                      unselectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      selectedColor: Colors.grey[900],
                      unselectedColor: Colors.grey[700],
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // Future<dynamic> respuestasDialogo(BuildContext context) {
  //   String respuesta = '';
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.grey[900],
  //         title: const Text(
  //           'Elige una opción',
  //           style: TextStyle(
  //             color: Colors.white,
  //           ),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: widget.entradas.map(
  //             (e) {
  //               return Container(
  //                 margin: const EdgeInsets.only(top: 10),
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[800],
  //                   borderRadius: BorderRadius.circular(50),
  //                 ),
  //                 child: e.contains('done')
  //                     ? IconButton(
  //                         onPressed: () {
  //                           respuesta = e;
  //                           Navigator.of(context).pop();
  //                         },
  //                         icon: const Icon(
  //                           Icons.done,
  //                           color: Colors.green,
  //                         ),
  //                         iconSize: 80,
  //                       )
  //                     : e.contains('close')
  //                         ? IconButton(
  //                             onPressed: () {
  //                               respuesta = e;
  //                               Navigator.of(context).pop();
  //                             },
  //                             icon: const Icon(
  //                               Icons.close,
  //                               color: Colors.amber,
  //                             ),
  //                             iconSize: 80,
  //                           )
  //                         : e.contains('f/s')
  //                             ? IconButton(
  //                                 onPressed: () {
  //                                   respuesta = e;
  //                                   Navigator.of(context).pop();
  //                                 },
  //                                 icon: const ImageIcon(
  //                                   color: Colors.red,
  //                                   AssetImage('assets/FS.png'),
  //                                 ),
  //                                 iconSize: 80,
  //                               )
  //                             : const SizedBox(),
  //               );
  //             },
  //           ).toList(),
  //         ),
  //         actionsAlignment: MainAxisAlignment.center,
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               respuesta = '';
  //               setState(() {});
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text(
  //               'Restablecer',
  //               style: TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   ).then((value) {
  //     // this.respuesta = respuesta;
  //     // widget.alSeleccionarRespuesta(respuesta);
  //     setState(() {});
  //   });
  // }
}
