import 'dart:io';
import 'package:amecanico/1-Modelo/Cliente.dart';
import 'package:amecanico/1-Modelo/Reporte.dart';
import 'package:amecanico/2-Vista/Cliente/AgregarCoche.dart';
import 'package:amecanico/3-Controlador/reporteC.dart';
import 'package:flutter/material.dart';
import '../../1-Modelo/Coche.dart';
import '../../3-Controlador/ImagenC.dart';
import '../../3-Controlador/clientesC.dart';

// ignore: must_be_immutable
class NewSeleccionarCoche extends StatefulWidget {
  final Cliente cliente;
  final bool seGuardara;
  final Reporte plantilla;

  const NewSeleccionarCoche({
    super.key,
    required this.cliente,
    required this.seGuardara,
    required this.plantilla,
  });

  @override
  State<NewSeleccionarCoche> createState() => _NewSeleccionarCocheState();
}

class _NewSeleccionarCocheState extends State<NewSeleccionarCoche> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Coche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                physics: BouncingScrollPhysics(),
                padEnds: false,
                children: [
                  for (var i = 0; i < widget.cliente.coches.length; i++)
                    TarjetaCoche(
                      coche: widget.cliente.coches[i],
                    ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IngresarCarro(
                            cliente: widget.cliente,
                            seGuardara: widget.seGuardara,
                          ),
                        ),
                      ).then((value) {
                        if (value != null) {
                          print(value);
                          for (var i = 0;
                              i < widget.cliente.coches.length;
                              i++) {
                            print(widget.cliente.coches[i].marca);
                          }
                          // Ccliente().guardarCambios(widget.cliente);
                        }
                        setState(() {});
                      });
                    },
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.car_crash_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                          Text(
                            'AGREGAR COCHE',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.cliente.coches.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: index == i
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: index == widget.cliente.coches.length
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    size: 15,
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    index == widget.cliente.coches.length
                        ? const SizedBox()
                        : Column(
                            children: [
                              ListTile(
                                title: Text(
                                  widget.cliente.coches[index].marca
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'MARCA',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  widget.cliente.coches[index].modelo
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'MODELO',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  widget.cliente.coches[index].placa
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'PLACA',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  widget.cliente.coches[index].anio
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'AÑO',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  widget.cliente.coches[index].motor
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'MOTOR',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  widget.cliente.coches[index].placa
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'PLACA',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  widget.cliente.coches[index].vin
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'VIN',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              ListTile(
                                title: Text(
                                  widget.cliente.coches[index].kilometraje
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'KILOMETRAJE',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: index != widget.cliente.coches.length
          ? FloatingActionButton.extended(
              onPressed: () {
                ReporteC controlador = ReporteC(reporte: widget.plantilla);
                controlador.crearReporteBorrador(
                    widget.cliente, widget.cliente.coches[index]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          controlador.reporte!.construirWidget(false)),
                ).then((value) => setState(() {
                      Navigator.pop(context);
                    }));
              },
              label: const Row(
                children: [
                  Text(
                    'Seguir',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class TarjetaCoche extends StatefulWidget {
  final Coche coche;
  const TarjetaCoche({super.key, required this.coche});

  @override
  State<TarjetaCoche> createState() => _TarjetaCocheState();
}

class _TarjetaCocheState extends State<TarjetaCoche> {
  ImagenC imagenC = ImagenC();
  File? imagen;
  @override
  void initState() {
    super.initState();
    print('object');
    imagenC.iniciar();
    print(widget.coche);
    imagen = widget.coche.imagen.isEmpty ? null : File(widget.coche.imagen);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Imagen del coche'),
              content: imagen != null
                  ? Image.file(imagen!)
                  : const Text('No hay imagen'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
            image: imagen != null
                ? DecorationImage(
                    opacity: 0.8,
                    image: FileImage(imagen!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'MARCA',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.coche.marca.toUpperCase(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.visible,
                ),
                Text(
                  'MODELO',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.coche.modelo.toUpperCase(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
