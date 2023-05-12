import 'package:flutter/material.dart';

class TallerView extends StatefulWidget {
  const TallerView({super.key});

  @override
  State<TallerView> createState() => _TallerViewState();
}

class _TallerViewState extends State<TallerView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Coches en reparacion/revision',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Coches por entregar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
