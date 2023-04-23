import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:flutter/material.dart';

import '../../1-Modelo/Cliente.dart';
import '../../4-Librerias/CustomListTile.dart';

class BuscarCliente extends StatefulWidget {
  const BuscarCliente({super.key});

  @override
  State<BuscarCliente> createState() => _BuscarClienteState();
}

class _BuscarClienteState extends State<BuscarCliente> {
  Ccliente cclientes = Ccliente();
  Cliente seleccionado = Cliente();
  late List<List<Cliente>> listaclientes;

  @override
  void initState() {
    super.initState();
    listaclientes = cclientes.listClientesOrdenadosPorLetra;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f0f0),
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text('Clientes'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('Agregar',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(onPressed: () {}, icon: Icon(Icons.done))),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(
                children: [
                  for (var clientesletra in listaclientes)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              clientesletra[0].nombre!.substring(0, 1),
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black54),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (int i = 0; i < clientesletra.length - 1; i++)
                                Column(
                                  children: [
                                    CustomListTile(
                                      esSeleccionado:
                                          seleccionado == clientesletra[i],
                                      onTap: () {
                                        if (seleccionado == clientesletra[i]) {
                                          seleccionado = Cliente();
                                        } else {
                                          seleccionado = clientesletra[i];
                                        }
                                        setState(() {});
                                      },
                                      cliente: clientesletra[i],
                                      esUltimo: false,
                                    ),
                                  ],
                                ),
                              CustomListTile(
                                esSeleccionado: seleccionado ==
                                    clientesletra[clientesletra.length - 1],
                                onTap: () {
                                  if (seleccionado ==
                                      clientesletra[clientesletra.length - 1]) {
                                    seleccionado = Cliente();
                                  } else {
                                    seleccionado =
                                        clientesletra[clientesletra.length - 1];
                                  }
                                  setState(() {});
                                },
                                cliente:
                                    clientesletra[clientesletra.length - 1],
                                esUltimo: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
