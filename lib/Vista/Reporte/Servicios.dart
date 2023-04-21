import 'package:flutter/material.dart';

import '../Opciones.dart';

class OrdenBotones extends StatefulWidget {
  const OrdenBotones({super.key});

  @override
  State<OrdenBotones> createState() => _OrdenBotonesState();
}

class _OrdenBotonesState extends State<OrdenBotones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        // backgroundColor: Colors.black,
        toolbarHeight: 50,
      ),
      body: ListView(
        children: [
          Boton(
            alPresionar: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Opciones();
              }));
            },
            imagen:
                'https://thelogisticsworld.com/wp-content/uploads/2022/10/technician-checking-the-electrical-system-of-the-car-e1665089545141.jpg',
            nombre: 'Afinacion',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen:
                'https://elceo.com/wp-content/uploads/2020/03/automotriz.jpg',
            nombre: 'Frenos',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3nkrWlhJ5w1YHO4fWWNPbKHkdhS5SvqRLgQ&usqp=CAU',
            nombre: 'Suspension',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen:
                'https://uploads-ssl.webflow.com/60aea4e5ac6df63edce0b8b4/617424aa36e754a0f7f5c229_Autoseguro-Crabi-Blog-Cat-Mantenimiento-Automotriz.jpg',
            nombre: 'Direccion Hidraulica',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen:
                'https://www.uag.mx/contenido/HR3fmIRZBn/en-que-consiste-la-carrera-de-ingenieria-automotriz_k8r.jpg',
            nombre: 'Motor',
          ),
          const SizedBox(height: 10),
          Boton(
            alPresionar: () {},
            imagen:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiCf7QF5js7_6jNQYRuJmsDqbL94NsZw8w6w&usqp=CAU',
            nombre: 'Enfriamento',
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
      onTap: alPresionar as void Function()?,
      child: Container(
        height: (MediaQuery.of(context).size.height - 120) / 6,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.darken),
            image: NetworkImage(imagen),
            fit: BoxFit.cover,
          ),
          // borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            nombre,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
