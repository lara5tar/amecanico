import 'package:flutter/material.dart';

class OrdenBotones extends StatefulWidget {
  const OrdenBotones({super.key});

  @override
  State<OrdenBotones> createState() => _OrdenBotonesState();
}

class _OrdenBotonesState extends State<OrdenBotones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Boton(
            alPresionar: () {},
            imagen: 'assets/ejemplo.jpg',
            nombre: 'Ejemplo 01',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen: 'assets/ejemplo.jpg',
            nombre: 'Ejemplo 01',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen: 'assets/ejemplo.jpg',
            nombre: 'Ejemplo 01',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen: 'assets/ejemplo.jpg',
            nombre: 'Ejemplo 01',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen: 'assets/ejemplo.jpg',
            nombre: 'Ejemplo 01',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen: 'assets/ejemplo.jpg',
            nombre: 'Ejemplo 01',
          ),
        ],
      ),
    );
  }
}

class Boton extends StatelessWidget {
  final Function alPresionar;
  final String imagen;
  final String nombre;

  const Boton({
    super.key,
    required this.alPresionar,
    required this.imagen,
    required this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: alPresionar(),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          image: DecorationImage(
            image: AssetImage(imagen),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            nombre,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
