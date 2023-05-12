import 'package:amecanico/2-Vista/Reporte/NewSeleccionarCliente.dart';
import 'package:amecanico/3-Controlador/reporteC.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class VistaReporte extends StatefulWidget {
  const VistaReporte({super.key});

  @override
  State<VistaReporte> createState() => _VistaReporteState();
}

class _VistaReporteState extends State<VistaReporte> {
  ReporteC reporteC = ReporteC();
  GroupButtonController controller = GroupButtonController();
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    controller.selectIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text('Crea una nueva orden', style: TextStyle(fontSize: 20)),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                ...reporteC.plantillas.values
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NewSeleccionarCliente(
                                  plantilla: e.clone(),
                                );
                              },
                            ),
                          ).then((value) => setState(() {}));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.only(left: 20, right: 10),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                reporteC.plantillas
                                    .keyAt(reporteC.listPlantillas.indexOf(e)),
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Icon(
                                Icons.assignment_add,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
            child: GroupButton(
              onSelected: (value, index, isSelected) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              controller: controller,
              buttons: const ['Ordenes en proceso', 'Ordenes finalizadas'],
              options: GroupButtonOptions(
                spacing: 10,
                selectedColor: Colors.deepOrangeAccent,
                selectedTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                unselectedTextStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
                unselectedColor: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          Expanded(
            child: PageView(
              controller: pageController,
              padEnds: false,
              physics: BouncingScrollPhysics(),
              children: [
                reporteC.listBorradores.isEmpty
                    ? const Center(
                        child: Text(
                          'No tienes ordenes en proceso',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView(
                        children: [
                          ...reporteC.listBorradores.map(
                            (e) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return e.construirWidget(false);
                                    },
                                  ),
                                ).then(
                                  (value) => {
                                    setState(() {}),
                                  },
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                margin: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  subtitle: Text(
                                    'Fecha:${e.fecha} ${e.hora}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  title: Text(
                                    '${e.nombreCliente}\n${e.telefonoCliente}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  leading: Icon(
                                    Icons.assignment,
                                    size: 40,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60)
                        ],
                      ),
                reporteC.listReportes.isEmpty
                    ? const Center(
                        child: Text(
                          'No tienes ordenes finalizadas',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView(
                        children: [
                          ...reporteC.listReportes.map(
                            (e) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return e.construirWidget(true);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                margin: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  subtitle: Text(
                                    'Fecha:${e.fecha} ${e.hora}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  title: Text(
                                    '${e.nombreCliente}\n${e.telefonoCliente}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  leading: Icon(
                                    Icons.assignment,
                                    size: 40,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),

          // Padding(
          //   padding:
          //       const EdgeInsets.only(top: 10, right: 30, left: 30, bottom: 10),
          //   child: Text(
          //     'Ordenes Activos',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // ),
          // reporteC.listBorradores.length == 0
          //     ? Container(
          //         padding: EdgeInsets.only(top: 20),
          //         child: Text(
          //           'No tienes ordenes en borradores',
          //           style: TextStyle(fontSize: 15),
          //           textAlign: TextAlign.center,
          //         ),
          //       )
          //     : Container(),
          // ...reporteC.listBorradores.map(
          //   (e) => GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return Scaffold(
          //               appBar: AppBar(
          //                 title: Text('Reporte'),
          //               ),
          //               body: SingleChildScrollView(
          //                 child: Column(
          //                   children: [
          //                     e.construirWidget(),
          //                     const SizedBox(height: 20)
          //                   ],
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       );
          //     },
          //     child: Container(
          //       padding: EdgeInsets.all(30),
          //       margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          //       decoration: BoxDecoration(
          //         color: Colors.grey[900],
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Text(
          //         'Reporte del ${e.fecha}',
          //         style: TextStyle(
          //           fontSize: 20,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding:
          //       const EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 10),
          //   child: Text(
          //     'Ordenes Finalizadas',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // ),
          // reporteC.listReportes.length == 0
          //     ? Container(
          //         padding: EdgeInsets.only(top: 20),
          //         child: Text(
          //           'No tienes ordenes en borradores',
          //           style: TextStyle(fontSize: 15),
          //           textAlign: TextAlign.center,
          //         ),
          //       )
          //     : Container(),
          // ...reporteC.listReportes
          //     .map(
          //       (e) => GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) {
          //                 return Scaffold(
          //                   appBar: AppBar(
          //                     title: Text('Reporte'),
          //                   ),
          //                   body: SingleChildScrollView(
          //                     child: Column(
          //                       children: [
          //                         e.construirWidget(),
          //                       ],
          //                     ),
          //                   ),
          //                 );
          //               },
          //             ),
          //           );
          //         },
          //         child: Container(
          //           padding: EdgeInsets.all(30),
          //           margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          //           decoration: BoxDecoration(
          //             color: Colors.grey[900],
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: Text(
          //             'Reporte del ${e.fecha}',
          //             style: TextStyle(
          //               fontSize: 20,
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //     .toList(),
          // SizedBox(
          //   height: 20,
          // )
        ],
      ),
    );
  }
}
