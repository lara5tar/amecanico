import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:flutter/material.dart';

import '../../1-Modelo/Cliente.dart';
import 'SeleccionarCoche.dart';

class BuscarCliente extends StatefulWidget {
  const BuscarCliente({super.key});

  @override
  State<BuscarCliente> createState() => _BuscarClienteState();
}

class _BuscarClienteState extends State<BuscarCliente> {
  TextEditingController conBuscar = TextEditingController();
  Ccliente controladorCliente = Ccliente();

  List<Cliente> coincidenciasClientes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                print(value);
                coincidenciasClientes = controladorCliente.buscarCliente(value);
                setState(() {});
              },
              controller: conBuscar,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Buscar por nombre o telefono',
              ),
            ),
            const SizedBox(height: 20),
            coincidenciasClientes.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text('Sin resultados',
                          style: TextStyle(fontSize: 20)),
                    ),
                  )
                : Expanded(
                    child: Container(
                      child: ListView(
                        children: coincidenciasClientes
                            .map(
                              (e) => ListTile(
                                title: Text(
                                  e.nombre,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                subtitle: Text(
                                  e.telefono,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SeleccionarCoche(
                                        cliente: e,
                                      );
                                    },
                                  ));
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
