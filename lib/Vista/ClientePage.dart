import 'package:flutter/material.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text('Clientes'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar cliente',
                  ),
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12, width: 2),
              ),
              child: ListView(
                children: [],
              ),
            ),
          )
        ],
      ),
    );
  }
}
