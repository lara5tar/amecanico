import 'package:hive/hive.dart';

import '../1-Modelo/Cliente.dart';
import '../1-Modelo/Coche.dart';

class Ccliente {
  Box<Cliente> clientes = Hive.box<Cliente>('clientes');

  List<Cliente> get listClientes => clientes.values.toList();

  List<Cliente> get listClientesOrdenados =>
      clientes.values.toList()..sort((a, b) => a.nombre.compareTo(b.nombre));

  List<List<Cliente>> get listClientesOrdenadosPorLetra {
    List<List<Cliente>> lista = [];
    List<Cliente> listaClientes = listClientesOrdenados;
    String letra = '';
    for (int i = 0; i < listaClientes.length; i++) {
      if (letra != listaClientes[i].nombre[0]) {
        letra = listaClientes[i].nombre[0];
        lista.add([listaClientes[i]]);
      } else {
        lista[lista.length - 1].add(listaClientes[i]);
      }
    }
    return lista;
  }

  List<Cliente> buscarCliente(String controlador) {
    return clientes.values
        .where((element) =>
            element.nombre.toLowerCase().contains(controlador.toLowerCase()) ||
            element.telefono.toLowerCase().contains(controlador.toLowerCase()))
        .toList();
  }

  void agregarCocheACliente(Cliente cliente, Coche coche) {
    cliente.coches.add(coche);
    clientes.put(cliente.nombre, cliente);
  }

  void agregarCliente(nombre, domicilio, telefono, List<Coche> coches) {
    clientes.put(
      nombre.text,
      Cliente(
        nombre: nombre.text,
        domicilio: domicilio.text,
        telefono: telefono.text,
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
