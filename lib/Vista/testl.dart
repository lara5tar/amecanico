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

class CustomPopUpMenu extends StatefulWidget {
  const CustomPopUpMenu({super.key});

  @override
  State<CustomPopUpMenu> createState() => _CustomPopUpMenuState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _CustomPopUpMenuState extends State<CustomPopUpMenu> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
                      : const SizedBox(
                          width: 24,
                        ),
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
  List<String> textButton = ['Normal', 'Platino', 'Iridium'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de formulario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomButton(
              text: textButton[0],
              onTap: () {},
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: textButton[1],
              onTap: () {},
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: textButton[2],
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String text;
  final Function onTap;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  int opcion = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Elige una opcion'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color: Colors.green,
                  iconSize: 80,
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    opcion = 1;
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  color: Colors.yellow,
                  iconSize: 80,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    opcion = 2;
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  color: Colors.red,
                  iconSize: 80,
                  icon: const Icon(Icons.warning),
                  onPressed: () {
                    opcion = 3;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ).then((value) => setState(() {}));
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.5,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: opcion == 1
                  ? Icon(Icons.done)
                  : opcion == 2
                      ? Icon(Icons.close)
                      : opcion == 3
                          ? Text('F/S')
                          : Text(''),
            ),
          )
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
