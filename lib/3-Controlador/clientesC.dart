import 'package:flutter/material.dart';
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

  bool existeCliente(String nombre) {
    return clientes.containsKey(nombre);
  }

  Cliente? buscarClientePorNombre(String nombre) {
    return clientes.get(nombre);
  }

  List<Cliente> buscarCliente(String controlador) {
    return clientes.values
        .where((element) =>
            element.nombre.toLowerCase().contains(controlador.toLowerCase()) ||
            element.telefono
                .replaceAll(' - ', '')
                .toLowerCase()
                .contains(controlador.toLowerCase()))
        .toList();
  }

  void agregarCocheACliente(Cliente cliente, Coche coche) {
    cliente.coches.add(coche);
    clientes.put(cliente.id, cliente);
  }

  Cliente? cliente;

  String agregarCliente(nombre, domicilio, TextEditingController telefono) {
    // if (telefono.text.length != 16) return 'El telefono debe tener 10 digitos';
    if (nombre.text == '') return 'Faltan campos por llenar';

    // if (listClientes.any((element) => element.telefono == telefono.text))
    //   return 'El telefono ya existe';

    if (listClientes.any((element) => element.nombre == nombre.text)) {
      return 'El nombre ya existe';
    }

    Cliente cliente = Cliente(
      nombre: nombre.text,
      domicilio: domicilio.text == '' ? 'Sin domicilio' : domicilio.text,
      telefono: telefono.text == '' ? 'Sin telefono' : telefono.text,
      coches: [],
    );

    this.cliente = cliente;

    clientes.put(cliente.id, cliente);
    return 'agregado';
  }

  guardarCambios(Cliente cliente) {
    clientes.put(cliente.id, cliente);
  }
}
