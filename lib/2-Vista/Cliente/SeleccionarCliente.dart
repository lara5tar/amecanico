import 'package:amecanico/2-Vista/Cliente/BuscarCliente.dart';
import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:flutter/material.dart';
import '../../1-Modelo/Cliente.dart';
import '../../4-Librerias/CustomListTile.dart';
import 'AgregarClientePage.dart';
import 'SeleccionarCoche.dart';

class SeleccionarCliente extends StatefulWidget {
  const SeleccionarCliente({super.key});

  @override
  State<SeleccionarCliente> createState() => _SeleccionarClienteState();
}

class _SeleccionarClienteState extends State<SeleccionarCliente> {
  Ccliente cclientes = Ccliente();
  Cliente? seleccionado;
  late List<List<Cliente>> listaclientes;

  @override
  void initState() {
    super.initState();
    print('initState');
    listaclientes = cclientes.listClientesOrdenadosPorLetra;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f0f0),
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Seleccionar\nClientes'),
        titleTextStyle: const TextStyle(
          overflow: TextOverflow.visible,
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        actions: [
          IconButton(
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgregarClientePage(),
                ),
              ).then(
                (value) => setState(
                  () {
                    listaclientes = cclientes.listClientesOrdenadosPorLetra;
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BuscarCliente(),
                ),
              );
            },
            iconSize: 35,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: seleccionado != null
          ? ElevatedButton(
              onPressed: () {
                if (seleccionado == null) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SeleccionarCoche(
                        cliente: seleccionado!,
                      );
                    },
                  ),
                ).then(
                  (value) => setState(
                    () {
                      listaclientes = cclientes.listClientesOrdenadosPorLetra;
                    },
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(Size(150, 70)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child: const Text(
                'Seleccionar',
                style: TextStyle(fontSize: 20),
              ))
          : null,
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
                              clientesletra[0].nombre.substring(0, 1),
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
                                          seleccionado = null;
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
                                    seleccionado = null;
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
