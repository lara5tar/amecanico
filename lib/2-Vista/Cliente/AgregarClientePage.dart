import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:flutter/material.dart';

class AgregarClientePage extends StatefulWidget {
  const AgregarClientePage({super.key});

  @override
  State<AgregarClientePage> createState() => _AgregarClientePageState();
}

class _AgregarClientePageState extends State<AgregarClientePage> {
  Ccliente cclientes = Ccliente();

  TextEditingController nombre = TextEditingController();
  TextEditingController domicilio = TextEditingController();
  TextEditingController telefono = TextEditingController();
  // List<Widget> coches = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Cliente'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nombre,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nombre',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: domicilio,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Domicilio',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: telefono,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Telefono',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              cclientes.agregarCliente(
                nombre,
                domicilio,
                telefono,
                [],
              );
              Navigator.pop(context);
            },
            child: const Text('Agregar Cliente'),
          ),
        ],
      ),
    );
  }
}
