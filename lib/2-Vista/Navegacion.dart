import 'package:amecanico/2-Vista/CalendarioPage.dart';
import 'package:amecanico/2-Vista/Reporte/NewSeleccionarCliente.dart';
import 'package:amecanico/2-Vista/ClientePage.dart';
import 'package:amecanico/2-Vista/InicioPage.dart';
import 'package:amecanico/2-Vista/ReportePage.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

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
    const ReportePage(),
    const ClientePage(),
    const CalendarioPage(),
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
    'Reporte',
    'Clientes',
    'Calendario',
  ];

  bool isDarkMode(BuildContext context) {
    final theme = Theme.of(context);
    return theme.brightness == Brightness.dark;
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
        title: const Column(
          children: [
            Text(
              'AUTOMOTRIZ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'MARTINEZ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        toolbarHeight: 80,
        actions: [
          PopupMenuButton(
            iconSize: 40,
            icon: const Icon(Icons.menu),
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
        itemCount: vistas.length,
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
          print(isDarkMode(context).toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewSeleccionarCliente(),
            ),
          );
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
