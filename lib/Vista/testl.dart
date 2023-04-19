import 'package:flutter/material.dart';

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
                print('index: $index, isExpanded: $isExpanded');
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
                return ListTile(
                  title: const Text('Panel A'),
                );
              },
              body: const ListTile(
                title: Text('This is all the inside of the panel'),
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

class PopupMenuApp extends StatelessWidget {
  const PopupMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PopupMenuExample(),
    );
  }
}

class PopupMenuWidget<T> extends PopupMenuEntry<T> {
  const PopupMenuWidget({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  final Widget child;

  @override
  final double height;

  @override
  bool get enabled => false;

  @override
  _PopupMenuWidgetState createState() => _PopupMenuWidgetState();

  @override
  bool represents(T? value) {
    return false;
  }
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}

class PopupMenuExample extends StatefulWidget {
  const PopupMenuExample({super.key});

  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _PopupMenuExampleState extends State<PopupMenuExample> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          selectedMenu == SampleItem.itemOne
              ? const Icon(Icons.done)
              : selectedMenu == SampleItem.itemTwo
                  ? const Icon(Icons.close)
                  : selectedMenu == SampleItem.itemThree
                      ? const Icon(Icons.construction)
                      : const SizedBox(),
          PopupMenuButton<SampleItem>(
            icon: const Icon(Icons.arrow_drop_down_rounded),
            initialValue: selectedMenu,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            padding: EdgeInsets.zero,
            offset: const Offset(-106, -80),
            onSelected: (SampleItem item) {
              setState(
                () {
                  selectedMenu = item;
                },
              );
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuWidget(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          setState(() {
                            selectedMenu = SampleItem.itemOne;
                          });
                        },
                      ),
                      IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            selectedMenu = SampleItem.itemTwo;
                          });
                        },
                      ),
                      IconButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              BeveledRectangleBorder()),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        icon: const Icon(Icons.construction),
                        onPressed: () {
                          setState(() {
                            selectedMenu = SampleItem.itemThree;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

class EjemploFormulario extends StatefulWidget {
  const EjemploFormulario({super.key});

  @override
  State<EjemploFormulario> createState() => _EjemploFormularioState();
}

class _EjemploFormularioState extends State<EjemploFormulario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de formulario'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text('Formulario 01:', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                PopupMenuExample(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
