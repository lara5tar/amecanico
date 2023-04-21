import 'package:hive/hive.dart';

import 'Coche.dart';

@HiveType(typeId: 0)
class Cliente {
  @HiveField(0)
  String? nombre;
  @HiveField(1)
  String? domicilio;
  @HiveField(2)
  String? telefono;
  @HiveField(3)
  List<Coche>? coches;

  Cliente({
    this.nombre,
    this.domicilio,
    this.telefono,
    this.coches,
  });

  @override
  String toString() =>
      'Cliente(nombre: $nombre, domicilio: $domicilio, telefono: $telefono, coches: $coches)';
}

class ClienteAdapter extends TypeAdapter<Cliente> {
  @override
  final int typeId = 0;

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
