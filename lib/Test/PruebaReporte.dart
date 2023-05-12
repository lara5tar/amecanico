import 'dart:async';

import 'package:amecanico/1-Modelo/Reporte.dart';
import 'package:amecanico/3-Controlador/reporteC.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

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
        title: Text('Prueba re'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              builder: (context, reporteC) {
                if (reporteC.hasData) {
                  return Column(
                    children: [
                      Text(reporteC.data!.reportes.length.toString()),
                      ...reporteC.data!.listReportes
                          .map(
                            (e) => ElevatedButton(
                              onPressed: () {
                                //
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Scaffold(
                                        appBar: AppBar(
                                          title: Text('Reporte'),
                                        ),
                                        body: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              e.construirWidget(false),
                                              const SizedBox(height: 20)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                                //
                              },
                              child: Text(e.fecha),
                            ),
                          )
                          .toList(),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      CircularProgressIndicator(
                        color: Colors.red,
                        semanticsLabel: 'Loading',
                        semanticsValue: 'Loading',
                      ),
                    ],
                  );
                }
              },
              future: Future.delayed(Duration(seconds: 3), () {
                return ReporteC();
              }),
            ),
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
