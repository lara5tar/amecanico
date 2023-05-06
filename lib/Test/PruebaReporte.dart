import 'package:amecanico/1-Modelo/Campo.dart';
import 'package:amecanico/1-Modelo/Reporte.dart';
import 'package:amecanico/1-Modelo/Seccion.dart';
import 'package:flutter/material.dart';

import '../1-Modelo/Servicios.dart';

class PruebaReporte extends StatefulWidget {
  const PruebaReporte({super.key});

  @override
  State<PruebaReporte> createState() => _PruebaReporteState();
}

class _PruebaReporteState extends State<PruebaReporte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba Reporte'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Reporte(
              fecha: '04-05-2023',
              hora: '12:00',
              nombreCliente: 'Amando',
              telefonoCliente: '8885858585858',
              domicilioCliente: 'Domicilio x',
              coche: 'coche',
              imagenes: [],
              servicios: [
                Servicio(
                  titulo: 'Afinacion',
                  secciones: [
                    Seccion(
                      titulo: 'Cambio de Aceite',
                      subSecciones: [
                        SubSeccion(
                          subtitulo: 'Filtro',
                          campos: [
                            Campo(
                              tipo: 'text',
                              opciones: ['tiene tal cosa?'],
                              entradas: [],
                            ),
                            Campo(
                              tipo: 'text',
                              opciones: ['tiene tal cosa?'],
                              entradas: [],
                            ),
                          ],
                        ),
                        SubSeccion(
                          subtitulo: 'Filtro',
                          campos: [
                            Campo(
                              tipo: 'radio',
                              opciones: ['1'],
                              entradas: ['done', 'close', 'f/s'],
                            ),
                            Campo(
                              tipo: 'text',
                              opciones: ['observacion'],
                              entradas: ['done', 'close', 'f/s'],
                            ),
                          ],
                        ),
                        SubSeccion(
                          subtitulo: 'Anticongelante',
                          campos: [
                            Campo(
                              tipo: 'check',
                              opciones: ['4', '6'],
                              entradas: ['done', 'close', 'f/s'],
                            )
                          ],
                        ),
                        SubSeccion(
                          subtitulo: 'Anticongelante',
                          campos: [
                            Campo(
                              tipo: 'check',
                              opciones: ['4', '6'],
                              entradas: ['done', 'close', 'f/s'],
                            )
                          ],
                        )
                      ],
                    ),
                    Seccion(
                      titulo: 'Cambio de Frenos',
                      subSecciones: [
                        SubSeccion(
                          subtitulo: 'Filtro',
                          campos: [
                            Campo(
                              tipo: 'check',
                              opciones: ['4', '6'],
                              entradas: ['done', 'close', 'f/s'],
                            )
                          ],
                        ),
                        SubSeccion(
                          subtitulo: 'Cambio de Llantas',
                          campos: [
                            Campo(
                              tipo: 'radio',
                              opciones: ['4', '6'],
                              entradas: ['done', 'close', 'f/s'],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Servicio(
                  titulo: 'Frenos',
                  secciones: [
                    Seccion(
                      titulo: 'Cambio de Aceite',
                      subSecciones: [
                        SubSeccion(subtitulo: 'Filtro', campos: []),
                        SubSeccion(subtitulo: 'Liquido', campos: [])
                      ],
                    ),
                    Seccion(
                      titulo: 'Cambio de Frenos',
                      subSecciones: [
                        SubSeccion(subtitulo: 'Filtro', campos: [
                          Campo(
                            tipo: 'seleccion',
                            opciones: [],
                            entradas: [],
                          )
                        ]),
                        SubSeccion(subtitulo: 'Liquido', campos: [])
                      ],
                    ),
                  ],
                )
              ],
            ).construirWidget()
          ],
        ),
      ),
    );
  }
}
// fecha: DateTime.now().day.toString() +
              //     '/' +
              //     DateTime.now().month.toString() +
              //     '/' +
              //     DateTime.now().year.toString(),
              // hora: DateTime.now().hour.toString() +
              //     ':' +
              //     DateTime.now().minute.toString() +
              //     ' ',