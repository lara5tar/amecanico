import 'package:hive/hive.dart';

import 'Coche.dart';

@HiveType(typeId: 0)
class Cliente {
  @HiveField(0)
  String nombre;
  @HiveField(1)
  String domicilio;
  @HiveField(2)
  String telefono;
  @HiveField(3)
  List<Coche> coches;

  Cliente({
    required this.nombre,
    required this.domicilio,
    required this.telefono,
    required this.coches,
  });

  // void partirPastel() {
  //   print('Se partio el pastel en 8');
  // }

  // void partirPastelPorNumero(int partes) {
  //   print('Se partio el pastel en' + partes.toString() + 'partes');
  // }

  // String partirPastelyDar() {
  //   print('Se partio el pastel en 8 partes');

  //   return 'Jesus';
  // }

  // String partirPastelyDarPorNumeroyNombre(int partes, String nombre) {
  //   print('Se partio el pastel en ' + partes.toString() + 'partes');
  //   return nombre;
  // }

  @override
  String toString() =>
      'Cliente(nombre: $nombre, domicilio: $domicilio, telefono: $telefono, coches: $coches)';
}

class ClienteAdapter extends TypeAdapter<Cliente> {
  @override
  // int get typeId => 0;
  final typeId = 0;

  @override
  Cliente read(BinaryReader reader) {
    return Cliente(
      nombre: reader.read(),
      domicilio: reader.read(),
      telefono: reader.read(),
      coches: List<Coche>.from(reader.read()),
    );
  }

  @override
  void write(BinaryWriter writer, Cliente obj) {
    writer
      ..write(obj.nombre)
      ..write(obj.domicilio)
      ..write(obj.telefono)
      ..write(obj.coches);
  }
}
