import 'package:amecanico/2-Vista/CalendarioPage.dart';
import 'package:amecanico/2-Vista/Cliente/AgregarClientePage.dart';
import 'package:amecanico/2-Vista/Reporte/NewSeleccionarCliente.dart';
import 'package:amecanico/2-Vista/ClientePage.dart';
import 'package:amecanico/2-Vista/InicioPage.dart';
import 'package:amecanico/2-Vista/ReportePage.dart';
import 'package:amecanico/2-Vista/TallerView.dart';
import 'package:amecanico/2-Vista/VistaReportes.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../Test/PruebaCalendario.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  //cuando se selecciona un item del bottomNavigationBar, el index cambia
  void indexSeleccionado(int index) => setState(() => this.index = index);
  //lista de las vistas que se muestran en el body al seleccionar un item del bottomNavigationBar
  List<Widget> vistas = [
    const InicioPage(),
    const TallerView(),
    const ClientePage(),
    const CalendarioPage(),
    const VistaReporte(),
  ];
  //lista de los items del bottomNavigationBar
  List<IconData> botonesVistas = const [
    Icons.home,
    Icons.car_repair,
    Icons.groups,
    Icons.event,
  ];

  List<String> titulos = const [
    'Inicio',
    'Taller',
    'Clientes',
    'Calendario',
    'Ordenes',
  ];

  bool isDarkMode(BuildContext context) {
    final theme = Theme.of(context);
    return theme.brightness == Brightness.dark;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.account_circle,
            size: 40,
          ),
        ),
        title: Column(
          children: [
            Text(
              titulos[index],
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        toolbarHeight: 80,
        actions: [
          index == 2
              ? IconButton(
                  iconSize: 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AgregarClientePage(),
                      ),
                    ).then(
                      (value) => setState(() {
                        print('x');
                      }),
                    );
                  },
                  icon: const Icon(Icons.add),
                )
              : Container(),
          index == 2
              ? IconButton(
                  iconSize: 35,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  icon: const Icon(Icons.search),
                )
              : Container(),
          PopupMenuButton(
            iconSize: 40,
            // icon: const Icon(Icons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Configuración'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: vistas[index],
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: isDarkMode(context) ? Colors.grey[900] : Colors.white,
        onTap: indexSeleccionado,
        //icons: botonesVistas,
        activeIndex: index,
        //activeColor: Color(0xffe6a02e),
        height: 70,
        elevation: 100,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        itemCount: botonesVistas.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(botonesVistas[index]),
              Text(titulos[index]),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          index = 4;
          setState(() {});
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment),
            Text('Orden'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
