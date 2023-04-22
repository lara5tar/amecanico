import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:flutter/material.dart';

import '../../1-Modelo/Cliente.dart';
import 'AgregarClientePage.dart';

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
      appBar: AppBar(
        title: const Text('Selecciona Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Buscar Cliente',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title:
                  const Text('Nuevo Cliente', style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.person_add),
              onTap: () {
                for (var x in listaclientes) {
                  print(x[0].nombre!.substring(0, 1));
                  for (var y in x) {
                    print(y.nombre);
                  }
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AgregarClientePage();
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
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: listaclientes.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Text(
                            cclientes
                                .listClientesOrdenadosPorLetra[index][0].nombre!
                                .substring(0, 1),
                            style: const TextStyle(fontSize: 20),
                          ),
                          title: Divider(
                            color: Colors.grey[300],
                            thickness: 1.5,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(
                            //   color: Colors.black,
                            // ),
                          ),
                          child: Column(
                            children: [
                              for (var x in listaclientes[index])
                                if (seleccionado == x)
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // border: Border.all(
                                          //   color: Colors.black,
                                          // ),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            x.nombre!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                          subtitle: Text(
                                            x.telefono!,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              seleccionado = Cliente();
                                            });
                                          },
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                        thickness: 1.5,
                                      )
                                    ],
                                  )
                                else
                                  Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          x.nombre!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        subtitle: Text(
                                          x.telefono!,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        onTap: () {
                                          setState(
                                            () {
                                              seleccionado = x;
                                            },
                                          );
                                        },
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                        thickness: 1.5,
                                      )
                                    ],
                                  ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
