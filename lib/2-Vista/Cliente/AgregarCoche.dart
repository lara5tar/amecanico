import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:flutter/material.dart';
import '../../1-Modelo/Cliente.dart';
import '../../1-Modelo/Coche.dart';

class IngresarCarro extends StatefulWidget {
  final Cliente cliente;
  IngresarCarro({super.key, required this.cliente});

  @override
  State<IngresarCarro> createState() => _IngresarCarroState();
}

class _IngresarCarroState extends State<IngresarCarro> {
  TextEditingController Marca = TextEditingController();

  TextEditingController Modelo = TextEditingController();

  TextEditingController Anio = TextEditingController();

  TextEditingController Motor = TextEditingController();

  TextEditingController Vin = TextEditingController();

  TextEditingController Km = TextEditingController();

  TextEditingController Placas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del vehiculo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Dueño actual del carro:',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.cliente.nombre,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Ingresa los datos el vehiculo ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Marca,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Marca',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Modelo,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Modelo',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Anio,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Año',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Motor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Motor',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Vin,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vin',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Km,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Kilometraje',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Placas,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Placas',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Coche coche = Coche(
                  marca: Marca.text,
                  modelo: Modelo.text,
                  anio: Anio.text,
                  motor: Motor.text,
                  vin: Vin.text,
                  kilometraje: Km.text,
                  placa: Placas.text,
                );
                Ccliente().agregarCocheACliente(widget.cliente, coche);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}
