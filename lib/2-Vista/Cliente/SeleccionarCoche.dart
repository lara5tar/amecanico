import 'package:amecanico/1-Modelo/Cliente.dart';
import 'package:amecanico/1-Modelo/Coche.dart';
import 'package:flutter/material.dart';

import 'AgregarCoche.dart';

class SeleccionarCoche extends StatefulWidget {
  final Cliente cliente;
  const SeleccionarCoche({super.key, required this.cliente});

  @override
  State<SeleccionarCoche> createState() => _SeleccionarCocheState();
}

class _SeleccionarCocheState extends State<SeleccionarCoche> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Coche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              widget.cliente.nombre,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                for (var coche in widget.cliente.coches)
                  CustomTarjeta(
                    coche: coche,
                  ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IngresarCarro(
                          cliente: widget.cliente,
                        ),
                      ),
                    ).then((value) {
                      setState(() {
                        // Cliente prueba =
                        //     Hive.box('clientes').get(widget.cliente.nombre);
                        // print('prueb');
                        // for (Coche coche in prueba.coches) {
                        //   print(coche.toString());
                        // }
                      });
                    });
                  },
                  child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffe6a02e),
                      ),
                      child: Icon(Icons.add, size: 50, color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomTarjeta extends StatefulWidget {
  final Coche coche;
  const CustomTarjeta({super.key, required this.coche});

  @override
  State<CustomTarjeta> createState() => _CustomTarjetaState();
}

class _CustomTarjetaState extends State<CustomTarjeta> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Center(child: Text(widget.coche.modelo)),
        ],
      ),
    );
  }
}
