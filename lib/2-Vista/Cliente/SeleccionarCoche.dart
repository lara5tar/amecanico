import 'package:amecanico/1-Modelo/Cliente.dart';
import 'package:amecanico/1-Modelo/Coche.dart';
import 'package:flutter/material.dart';

class SeleccinarCoche extends StatefulWidget {
  final Cliente cliente;
  const SeleccinarCoche({super.key, required this.cliente});

  @override
  State<SeleccinarCoche> createState() => _SeleccinarCocheState();
}

class _SeleccinarCocheState extends State<SeleccinarCoche> {
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
              widget.cliente.nombre!,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                for (var coche in widget.cliente.coches!)
                  CustomTarjeta(
                    coche: coche,
                  ),
                Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
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
          Center(child: Text(widget.coche.modelo!)),
        ],
      ),
    );
  }
}
