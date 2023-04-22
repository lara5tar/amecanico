import 'package:amecanico/2-Vista/Cliente/BuscarCliente.dart';
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
    const Center(child: Text('Calendario')),
  ];
  //lista de los items del bottomNavigationBar
  List<IconData> botonesVistas = const [
    Icons.home,
    Icons.car_repair,
    Icons.person,
    Icons.calendar_today,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automotriz Martinez'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: vistas[index],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        onTap: indexSeleccionado,
        icons: botonesVistas,
        activeIndex: index,
        activeColor: Colors.blueGrey,
        elevation: 100,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuscarCliente(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
