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
  @HiveField(4)
  String fechaCreacion = DateTime.now().toString();
  @HiveField(5)
  String fechaModificacion = DateTime.now().toString();
  @HiveField(6)
  String id = '';
  @HiveField(7)
  static int contador = 0;

  Cliente({
    required this.nombre,
    required this.domicilio,
    required this.telefono,
    required this.coches,
    this.fechaCreacion = '',
    this.fechaModificacion = '',
    required this.id,
  }) {
    // contador = contador + 1;
    // id = generateCode(contador.toString()) + contador.toString();
  }

  @override
  String toString() =>
      'Cliente(id: $id, nombre: $nombre, domicilio: $domicilio, telefono: $telefono, coches: $coches)';
}

class ClienteAdapter extends TypeAdapter<Cliente> {
  @override
  final typeId = 0;

  @override
  Cliente read(BinaryReader reader) {
    return Cliente(
      id: reader.read(),
      nombre: reader.read(),
      domicilio: reader.read(),
      telefono: reader.read(),
      coches: List<Coche>.from(reader.read()),
      fechaCreacion: reader.read(),
      fechaModificacion: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Cliente obj) {
    writer
      ..write(obj.id)
      ..write(obj.nombre)
      ..write(obj.domicilio)
      ..write(obj.telefono)
      ..write(obj.coches)
      ..write(obj.fechaCreacion)
      ..write(obj.fechaModificacion);
  }
}
