import 'package:flutter/material.dart';

import 'Seccion.dart';

class Servicio {
  String titulo;
  List<Seccion> secciones;

  Servicio({
    required this.titulo,
    required this.secciones,
  });

  Widget construirWidget() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VistaServicios(
                titulo: titulo,
                secciones: secciones,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class VistaServicios extends StatelessWidget {
  const VistaServicios({
    super.key,
    required this.titulo,
    required this.secciones,
  });

  final String titulo;
  final List<Seccion> secciones;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...secciones
                .map(
                  (e) => e.construirWidget(context),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
