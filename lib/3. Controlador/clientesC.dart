import 'package:hive/hive.dart';

import '../1. Modelo/Cliente.dart';
import '../1. Modelo/Coche.dart';

class Ccliente {
  Box<Cliente> clientes = Hive.box<Cliente>('clientes');

  List<Cliente> get listClientes => clientes.values.toList();

  void agregarCliente(
      String nombre, String domicilio, String telefono, List<Coche> coches) {
    clientes.put(
      nombre,
      Cliente(
        nombre: nombre,
        domicilio: domicilio,
        telefono: telefono,
        coches: coches,
      ),
    );
  }

  void editarCliente(
      String nombre, String domicilio, String telefono, List<Coche> coches) {
    clientes.put(
      nombre,
      Cliente(
        nombre: nombre,
        domicilio: domicilio,
        telefono: telefono,
        coches: coches,
      ),
    );
  }

  void eliminarClienteIndex(int index) {
    clientes.deleteAt(index);
  }

  void eliminarClienteNombre(String nombre) {
    clientes.delete(nombre);
  }

  void eliminarCliente(Cliente cliente) {
    clientes.delete(cliente.nombre);
  }
}
