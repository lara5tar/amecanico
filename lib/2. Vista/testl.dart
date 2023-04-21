import 'package:flutter/material.dart';

import '../4. Librerias/CustomPopupMenu.dart';

class Prueba01 extends StatefulWidget {
  const Prueba01({super.key});

  @override
  State<Prueba01> createState() => _Prueba01State();
}

class _Prueba01State extends State<Prueba01> {
  final List<bool> _data = <bool>[false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpansionPanelList'),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(
              () {
                for (int i = 0; i < _data.length; i++) {
                  if (i != index) {
                    _data[i] = false;
                  }
                }
                _data[index] = !isExpanded;
              },
            );
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return const ListTile(
                  title: Text('Panel A'),
                );
              },
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text('Cambio de Bujias:',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('4', style: TextStyle(fontSize: 20)),
                        CustomPopUpMenu(),
                        Text('6', style: TextStyle(fontSize: 20)),
                        CustomPopUpMenu(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('8', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 30),
                        CustomPopUpMenu(),
                      ],
                    ),
                  ],
                ),
              ),
              isExpanded: _data[0],
            ),
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: const Text('Panel B'),
                );
              },
              body: const ListTile(
                title: Text('This is all the inside of the panel'),
              ),
              isExpanded: _data[1],
            ),
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: const Text('Panel C'),
                );
              },
              body: const ListTile(
                title: Text('This is all the inside of the panel'),
              ),
              isExpanded: _data[2],
            ),
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: const Text('Panel C'),
                );
              },
              body: const ListTile(
                title: Text('This is all the inside of the panel'),
              ),
              isExpanded: _data[3],
            ),
          ],
        ),
      ),
    );
  }
}

class Prueba extends StatelessWidget {
  const Prueba({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                offset: const Offset(0, -150),
                onSelected: (value) {
                  switch (value) {
                    case 'Editar':
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Editar'),
                            content: const TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nombre de la categoria',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                      break;
                    case 'Eliminar':
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Eliminar'),
                            content: const Text(
                                '¿Está seguro de eliminar esta categoria?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Editar',
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Eliminar',
                      child: Text('Eliminar'),
                    ),
                  ];
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
              DropdownButton(
                alignment: Alignment.topCenter,
                elevation: 8,
                hint: const Text('Select item'),
                items: const [
                  DropdownMenuItem(
                    child: Text('Item 1'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('Item 2'),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text('Item 3'),
                    value: 3,
                  ),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FS extends StatelessWidget {
  final String titulo;
  const FS({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Color(0xFFE2504C),
          ),
          child: Center(
              child: Text(titulo,
                  style: TextStyle(fontSize: 100, color: Colors.white))),
        ),
        Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: Color(0xFFE2504C),
          ),
          child: Center(child: Text('f/s', style: TextStyle(fontSize: 20))),
        ),
      ],
    );
  }
}
