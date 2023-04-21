import 'package:flutter/material.dart';

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
