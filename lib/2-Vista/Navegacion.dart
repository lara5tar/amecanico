import 'package:amecanico/2-Vista/Cliente/SeleccionarCliente.dart';
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
      backgroundColor: Color(0xfff3f0f0),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
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
        ),
        centerTitle: true,
        toolbarHeight: 80,
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
              builder: (context) => SeleccionarCliente(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
