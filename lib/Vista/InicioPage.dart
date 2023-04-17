import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  List<Map<String, String>> lista = [
    {
      'titulo': 'Cambio de aceite',
      'descripcion': 'Cambio de aceite de motor',
      'fecha': '2021-10-10',
      'hora': '10:00',
      'precio': '50',
      'cliente': 'Juan',
      'coche': 'Seat Ibiza',
    },
    {
      'titulo': 'Cambio de aceite',
      'descripcion': 'Cambio de aceite de motor',
      'fecha': '2021-10-10',
      'hora': '10:00',
      'precio': '50',
      'cliente': 'Juan',
      'coche': 'Seat Ibiza',
    },
    {
      'titulo': 'Cambio de aceite',
      'descripcion': 'Cambio de aceite de motor',
      'fecha': '2021-10-10',
      'hora': '10:00',
      'precio': '50',
      'cliente': 'Juan',
      'coche': 'Seat Ibiza',
    },
    {
      'titulo': 'Cambio de aceite',
      'descripcion': 'Cambio de aceite de motor',
      'fecha': '2021-10-10',
      'hora': '10:00',
      'precio': '50',
      'cliente': 'Juan',
      'coche': 'Seat Ibiza',
    },
    {
      'titulo': 'Cambio de aceite',
      'descripcion': 'Cambio de aceite de motor',
      'fecha': '2021-10-10',
      'hora': '10:00',
      'precio': '50',
      'cliente': 'Juan',
      'coche': 'Seat Ibiza',
    },
    {
      'titulo': 'Cambio de aceite',
      'descripcion': 'Cambio de aceite de motor',
      'fecha': '2021-10-10',
      'hora': '10:00',
      'precio': '50',
      'cliente': 'Juan',
      'coche': 'Seat Ibiza',
    },
    {
      'titulo': 'Cambio de aceite',
      'descripcion': 'Cambio de aceite de motor',
      'fecha': '2021-10-10',
      'hora': '10:00',
      'precio': '50',
      'cliente': 'Juan',
      'coche': 'Seat Ibiza',
    },
    {
      'titulo': 'Cambio de aceite',
      'descripcion': 'Cambio de aceite de motor',
      'fecha': '2021-10-10',
      'hora': '10:00',
      'precio': '50',
      'cliente': 'Juan',
      'coche': 'Seat Ibiza',
    },
  ];

  List<Map<String, String>> listaCoches = [
    {
      'marca': 'Seat',
      'modelo': 'Ibiza',
      'matricula': '1234ABC',
      'cliente': 'Juan',
    },
    {
      'marca': 'Seat',
      'modelo': 'Ibiza',
      'matricula': '1234ABC',
      'cliente': 'Juan',
    },
    {
      'marca': 'Seat',
      'modelo': 'Ibiza',
      'matricula': '1234ABC',
      'cliente': 'Juan',
    },
    {
      'marca': 'Seat',
      'modelo': 'Ibiza',
      'matricula': '1234ABC',
      'cliente': 'Juan',
    },
    {
      'marca': 'Seat',
      'modelo': 'Ibiza',
      'matricula': '1234ABC',
      'cliente': 'Juan',
    },
    {
      'marca': 'Seat',
      'modelo': 'Ibiza',
      'matricula': '1234ABC',
      'cliente': 'Juan',
    },
    {
      'marca': 'Seat',
      'modelo': 'Ibiza',
      'matricula': '1234ABC',
      'cliente': 'Juan',
    },
    {
      'marca': 'Seat',
      'modelo': 'Ibiza',
      'matricula': '1234ABC',
      'cliente': 'Juan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'Próximas citas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: lista.length > 10 ? 10 : lista.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CitaCompleta(cita: lista[index]),
                                ),
                              );
                            },
                            leading: Text('${index + 1}'),
                            title: Text(lista[index]['titulo']!),
                            subtitle: Text(lista[index]['cliente']!),
                            trailing: Text(lista[index]['fecha']!),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'Ultimas Reparaciones',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: listaCoches.length > 10 ? 10 : lista.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CitaCompleta(cita: lista[index]),
                                ),
                              );
                            },
                            leading: Text('${index + 1}'),
                            title: Text(listaCoches[index]['modelo']!),
                            subtitle: Text(listaCoches[index]['cliente']!),
                            trailing: Text(listaCoches[index]['matricula']!),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CitaCompleta extends StatelessWidget {
  Map<String, String> cita = {};
  CitaCompleta({super.key, required this.cita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cita completa'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(cita['titulo']!),
          const SizedBox(height: 10),
          Text(cita['descripcion']!),
          const SizedBox(height: 10),
          Text(cita['fecha']!),
          const SizedBox(height: 10),
          Text(cita['hora']!),
          const SizedBox(height: 10),
          Text(cita['precio']!),
          const SizedBox(height: 10),
          Text(cita['cliente']!),
          const SizedBox(height: 10),
          Text(cita['coche']!),
        ],
      ),
    );
  }
}
