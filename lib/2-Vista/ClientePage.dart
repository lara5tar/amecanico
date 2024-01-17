import 'package:flutter/material.dart';

import '../1-Modelo/Cliente.dart';
import '../3-Controlador/clientesC.dart';
import '../4-Librerias/CustomListTile.dart';
import 'Cliente/VerClientes.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  Ccliente cclientes = Ccliente();
  late List<List<Cliente>> listaclientes;
  bool estaBuscando = false;

  Color isDarkMode(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return Colors.grey[900]!;
    } else {
      return Colors.grey[300]!;
    }
  }

  @override
  void initState() {
    super.initState();
    listaclientes = cclientes.listClientesOrdenadosPorLetra;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          listaclientes = cclientes.listClientesOrdenadosPorLetra;
        });
      },
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(
                children: [
                  cclientes.clientes.length == 0
                      ? Center(child: Text('No hay clientes'))
                      : SizedBox(),
                  for (var clientesletra in listaclientes)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              clientesletra[0].nombre.substring(0, 1),
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: isDarkMode(context),
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
                                        print(clientesletra[i]);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VerCliente(
                                              cliente: clientesletra[i],
                                            ),
                                          ),
                                        );
                                      },
                                      cliente: clientesletra[i],
                                      esUltimo: false,
                                    ),
                                  ],
                                ),
                              CustomListTile(
                                esSeleccionado: false,
                                onTap: () {
                                  print(
                                      clientesletra[clientesletra.length - 1]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VerCliente(
                                        cliente: clientesletra[
                                            clientesletra.length - 1],
                                      ),
                                    ),
                                  );
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
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
