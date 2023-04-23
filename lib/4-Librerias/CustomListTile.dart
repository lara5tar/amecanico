import 'package:flutter/material.dart';

import '../1-Modelo/Cliente.dart';

class CustomListTile extends StatefulWidget {
  final bool esUltimo;
  final Cliente cliente;
  final Function onTap;
  final bool esSeleccionado;

  const CustomListTile(
      {super.key,
      required this.esUltimo,
      required this.cliente,
      required this.onTap,
      required this.esSeleccionado});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: widget.esSeleccionado ? Colors.blue[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.person,
                size: 50,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cliente.nombre!,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.cliente.telefono!,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.esUltimo
                    ? const SizedBox()
                    : Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width - 140,
                        decoration: BoxDecoration(
                          color: Color(0xfff3f0f0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(''),
                      ),
              ],
            ),

            // const Spacer(),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.edit),
            // ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.delete),
            // ),
            // const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
