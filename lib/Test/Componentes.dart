import 'package:flutter/material.dart';

class PruebaComponentes extends StatefulWidget {
  const PruebaComponentes({super.key});

  @override
  State<PruebaComponentes> createState() => _PruebaComponentesState();
}

class _PruebaComponentesState extends State<PruebaComponentes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PruebaComponentes'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // CampoCheckBox(
            //   titulo: 'Cambio de Filtro',
            //   opciones: [
            //     ['Aire', 'Gasolina'],
            //     ['Aceite']
            //   ],
            //   entradas: ['done', 'close', 'f/s'],
            //   alSeleccionarEntradas: (List<String> value) {
            //     for (var item in value) {
            //       print('valor' + item);
            //     }
            //   },
            //   alSeleccionarOpciones: (List<String> value) {
            //     for (var item in value) {
            //       print('opcion' + item);
            //     }
            //   },
            // ),
            // CampoRadioButton(
            //   titulo: 'Cambio de Bujias',
            //   opciones: [
            //     [
            //       '1',
            //       '4',
            //       '6',
            //       '8',
            //     ],
            //     [
            //       '2',
            //       '3',
            //       '5',
            //       '7',
            //     ],
            //   ],
            //   respuestas: ['done', 'close', 'f/s'],
            //   alSeleccionarRespuesta: (List<String> value) {
            //     print(value);
            //   },
            //   alSeleccionarOpcion: (value) {
            //     print(value);
            //   },
            //   mapa: const {
            //     'opciones': [
            //       ['1'],
            //       ['2', '3']
            //     ],
            //     'entradas': ['done', 'close', 'f/s'],
            //   },
            // ),
            CampoDeTexto(
                'Cambio Bujiasaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                TextEditingController()),
            CampoSeleccion(
              'Cambio de Aceite',
              opciones: const [
                '1aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                '2aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                '3',
                'hghg',
              ],
              seleccionados: const ['done', 'close'],
              alSeleccionar: (int index) {},
            ),
            CampoSeleccion(
              'Cambio de Aceite',
              opciones: const ['4', '5', '6'],
              seleccionados: const ['done', 'close', 'f/s'],
              alSeleccionar: (int index) {
                print('x' + index.toString());
              },
            ),
            const SizedBox(height: 20),
            // Campo(
            //   titulo: 'nose',
            //   tipo: 'seleccion',
            //   opciones: ['1', '6', '9'],
            //   valores: ['done', 'close', 'f/s'],
            //   respuesta: '',
            // ).construirWidget(),
          ],
        ),
      ),
    );
  }
}

class CampoSeleccion extends StatefulWidget {
  String titulo;
  final List<String> opciones;
  final List<String> seleccionados;
  final ValueChanged<int> alSeleccionar;

  CampoSeleccion(
    this.titulo, {
    super.key,
    required this.opciones,
    required this.seleccionados,
    required this.alSeleccionar,
  });

  @override
  State<CampoSeleccion> createState() => _CampoSeleccionState();
}

class _CampoSeleccionState extends State<CampoSeleccion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[900],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  widget.titulo,
                  style: const TextStyle(
                    fontSize: 25,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < widget.opciones.length; i++)
            NewCustomBoton(
              widget.opciones[i],
              seleccionados: widget.seleccionados,
              onSelect: widget.alSeleccionar,
            ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NewCustomBoton extends StatefulWidget {
  String tituloOpcion;
  final List<String> seleccionados;
  final ValueChanged<int> onSelect;
  NewCustomBoton(this.tituloOpcion,
      {super.key, required this.seleccionados, required this.onSelect});

  @override
  State<NewCustomBoton> createState() => _NewCustomBotonState();
}

class _NewCustomBotonState extends State<NewCustomBoton> {
  int seleccionado = 0;

  Widget siEsSeleccionado() {
    if (seleccionado == 0) {
      return Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey[800],
        size: 80,
      );
    } else if (seleccionado == 1) {
      return const Icon(
        Icons.done,
        color: Colors.green,
        size: 80,
      );
    } else if (seleccionado == 2) {
      return const Icon(
        Icons.close,
        color: Colors.amber,
        size: 80,
      );
    } else {
      return const ImageIcon(
        color: Colors.red,
        AssetImage('assets/FS.png'),
        size: 50, // Tamaño del icono
      );
    }
  }

  isDarkMode(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  seleccionar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const SizedBox(width: 10),
            Text('Seleccione'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.seleccionados.contains('done')
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color.fromARGB(255, 129, 255, 133),
                        ),
                        child: IconButton(
                          color: Colors.green,
                          iconSize: 80,
                          icon: const Icon(Icons.done),
                          onPressed: () {
                            seleccionado = 1;
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      )
                    : SizedBox(),
                widget.seleccionados.contains('close')
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(255, 255, 244, 147),
                        ),
                        child: IconButton(
                          color: Colors.yellow.shade700,
                          iconSize: 80,
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            seleccionado = 2;
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IconButton(
                        iconSize: 80,
                        icon: const Icon(Icons.change_circle_outlined),
                        onPressed: () {
                          seleccionado = 0;
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('Quitar'),
                  ],
                ),
                widget.seleccionados.contains('f/s')
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(255, 255, 172, 172),
                        ),
                        child: IconButton(
                          color: Colors.blue,
                          iconSize: 80,
                          icon: const ImageIcon(
                            color: Colors.red,
                            AssetImage('assets/FS.png'),
                            size: 80, // Tamaño del icono
                          ),
                          onPressed: () {
                            seleccionado = 3;
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    ).then((value) => widget.onSelect(seleccionado));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.tituloOpcion);
        seleccionar();
        // seleccionar().then(() => widget.onSelect(seleccionado));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[800],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 30),
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                widget.tituloOpcion,
                style: const TextStyle(
                  fontSize: 25,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: isDarkMode(context),
              ),
              child: siEsSeleccionado(),
            )
          ],
        ),
      ),
    );
  }
}

class CampoDeTexto extends StatefulWidget {
  String titulo;
  TextEditingController controller;
  CampoDeTexto(this.titulo, this.controller, {super.key});

  @override
  State<CampoDeTexto> createState() => _CampoDeTextoState();
}

class _CampoDeTextoState extends State<CampoDeTexto> {
  Color? isDarkMode(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return Colors.grey[800];
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[900],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  widget.titulo,
                  style: const TextStyle(
                    fontSize: 25,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDarkMode(context),
              hintText: 'Escribe aqui...',
              hintStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
