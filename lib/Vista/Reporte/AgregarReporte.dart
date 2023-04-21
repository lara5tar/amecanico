import 'package:amecanico/Vista/testl.dart';
import 'package:flutter/material.dart';

class EjemploFormulario extends StatefulWidget {
  const EjemploFormulario({super.key});

  @override
  State<EjemploFormulario> createState() => _EjemploFormularioState();
}

class _EjemploFormularioState extends State<EjemploFormulario> {
  List<String> bujiasList = ['4', '6', '8', 'Normal', 'Platino', 'Iridium'];
  List<String> filtroList = ['Aire', 'Aceite', 'Gasolina'];
  List<String> aceiteList = [
    '4',
    '5',
    '6',
    '5w/30',
    '10w/30',
    '15w/30',
    '15w/40',
    '20w/50'
  ];
  List<String> linea4List = [
    'Carbcln',
    'Cables',
    'Liq. Inj',
    'Tapa/Dist.',
    'PCV',
    'Rotor'
  ];
  List<String> linea5List = [
    'Anti-\ncongelante',
    'Aceite Dir. Hidraulica',
    'Aceite de Transmision Aut.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de formulario'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cambio de Bujias:',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: bujiasList[0],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: bujiasList[1],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: bujiasList[2],
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.5,
                ),
                color: Colors.blueGrey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      text: bujiasList[3],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: bujiasList[4],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: bujiasList[5],
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cambio de Filtro:',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: filtroList[0],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: filtroList[1],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: filtroList[2],
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.5,
                ),
                color: Colors.blueGrey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cambio de Aceite:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: aceiteList[0],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: aceiteList[1],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: aceiteList[2],
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    text: aceiteList[3],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: aceiteList[4],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: aceiteList[5],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: aceiteList[6],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: aceiteList[7],
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.5,
                ),
                color: Colors.blueGrey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      text: linea4List[0],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: linea4List[1],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: linea4List[2],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: linea4List[3],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: linea4List[4],
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: linea4List[5],
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    text: linea5List[0],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: linea5List[1],
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: linea5List[2],
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.5,
                ),
                color: Colors.blueGrey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Observaciones:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 5,
                      onTapOutside: (event) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ],
                ),
              ),
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
            title: const Text('  Elige una opcion'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 129, 255, 133),
                      ),
                      child: IconButton(
                        color: Colors.green,
                        iconSize: 80,
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          opcion = 1;
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
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
                          opcion = 2;
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            icon: const Icon(Icons.keyboard_backspace),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text('Volver'),
                      ],
                    ),
                    Container(
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
                        icon: ImageIcon(
                          color: Colors.red,
                          AssetImage('assets/FS.png'),
                          size: 80, // Tamaño del icono
                        ),
                        onPressed: () {
                          opcion = 3;
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
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
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
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
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: opcion == 1
                  ? Icon(Icons.done, color: Colors.green, size: 80)
                  : opcion == 2
                      ? Icon(Icons.close, color: Colors.yellow, size: 80)
                      : opcion == 3
                          ? ImageIcon(
                              color: Colors.red,
                              AssetImage('assets/FS.png'),
                              size: 80, // Tamaño del icono
                            )
                          : Text(''),
            ),
          )
        ],
      ),
    );
  }
}

class AfinMayCom extends StatelessWidget {
  const AfinMayCom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Afinacion Mayor Completa Cambio de...'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Marcar con (X) las partes reemplazadas del vehículo, piezas dañadas con (F/S), y piezas en buen estado con (√)'),
            const SizedBox(height: 20),
            Container(
              child: Row(
                children: [
                  Text('Cambio de bujias'),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Text('4'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                  const SizedBox(width: 20),
                  Text('6'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            Row(
              children: [
                Text('8'),
                const SizedBox(width: 20),
                CustomPopUpMenu(),
              ],
            ),
            const SizedBox(height: 20),
            Text('Cambio de filtro'),
            Container(
              child: Row(
                children: [
                  Text('Aire'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                  const SizedBox(width: 20),
                  Text('Aceite'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text('Gasolina'),
                  const SizedBox(width: 5),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text('Cambio de aceite'),
            Container(
              child: Row(
                children: [
                  Text('4'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                  const SizedBox(width: 25),
                  Text('5'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            Row(
              children: [
                Text('6'),
                const SizedBox(width: 20),
                CustomPopUpMenu(),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text('5w/30'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                  const SizedBox(width: 20),
                  Text('10w/30'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text('15w/30'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                  const SizedBox(width: 20),
                  Text('15w/40'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text('20w/50'),
                  const SizedBox(width: 5),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text('Carbcln'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                  const SizedBox(width: 20),
                  Text('Cables'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text('Liq. Inj.'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                  const SizedBox(width: 20),
                  Text('Tapa/Dist.'),
                  const SizedBox(width: 10),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text('PCV'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                  const SizedBox(width: 20),
                  Text('Rotor'),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text(
                    'Anti-\nCongelante',
                    style: TextStyle(
                      fontSize: 8,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomPopUpMenu(),
                  const SizedBox(width: 20),
                  Text(
                    'Aceite Dir. \nHidraulica',
                    style: TextStyle(
                      fontSize: 8,
                    ),
                  ),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Row(
                children: [
                  Text(
                    'Aceite Transmision \nhidraulica',
                    style: TextStyle(fontSize: 8),
                  ),
                  const SizedBox(width: 20),
                  CustomPopUpMenu(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
