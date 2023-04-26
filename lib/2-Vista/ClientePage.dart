import 'package:flutter/material.dart';

import '../1-Modelo/Cliente.dart';
import '../3-Controlador/clientesC.dart';
import '../4-Librerias/CustomListTile.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  Ccliente cclientes = Ccliente();
  late List<List<Cliente>> listaclientes;
  bool estaBuscando = false;

  @override
  void initState() {
    super.initState();

    listaclientes = cclientes.listClientesOrdenadosPorLetra;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    setState(() {
                      estaBuscando = true;
                    });
                  },
                  onTapOutside: (event) {
                    setState(() {
                      estaBuscando = false;
                      FocusScope.of(context).unfocus();
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      listaclientes = cclientes.listClientesOrdenadosPorLetra;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Buscar',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              AnimatedContainer(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: estaBuscando ? Colors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                duration: const Duration(milliseconds: 400),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
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
                                    esSeleccionado: false,
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   '/coche',
                                      //   arguments: clientesletra[i],
                                      // );
                                    },
                                    cliente: clientesletra[i],
                                    esUltimo: false,
                                  ),
                                ],
                              ),
                            CustomListTile(
                              esSeleccionado: false,
                              onTap: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   '/coche',
                                //   arguments:
                                //       clientesletra[clientesletra.length - 1],
                                // );
                              },
                              cliente: clientesletra[clientesletra.length - 1],
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
    );
  }
}
