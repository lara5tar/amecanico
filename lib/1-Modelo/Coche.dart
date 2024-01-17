import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Coche {
  @HiveField(0)
  String marca;
  @HiveField(1)
  String modelo;
  @HiveField(2)
  String anio;
  @HiveField(3)
  String motor;
  @HiveField(4)
  String vin;
  @HiveField(5)
  String kilometraje;
  @HiveField(6)
  String placa;
  @HiveField(7)
  String imagen;
  @HiveField(8)
  String color;
  @HiveField(9)
  bool seleccionado;
  @HiveField(10)
  bool entregado;

  Coche({
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.motor,
    required this.vin,
    required this.kilometraje,
    required this.placa,
    required this.imagen,
    required this.color,
    this.seleccionado = false,
    this.entregado = false,
  });

  @override
  String toString() =>
      'marca: $marca, modelo: $modelo, anio: $anio, motor: $motor, vin: $vin, kilometraje: $kilometraje, placa: $placa';
}

class CocheAdapter extends TypeAdapter<Coche> {
  @override
  final typeId = 1;

  @override
  Coche read(BinaryReader reader) {
    return Coche(
      marca: reader.read(),
      modelo: reader.read(),
      anio: reader.read(),
      motor: reader.read(),
      vin: reader.read(),
      kilometraje: reader.read(),
      placa: reader.read(),
      imagen: reader.read(),
      color: reader.read(),
      seleccionado: reader.readBool(),
      entregado: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Coche obj) {
    writer
      ..write(obj.marca)
      ..write(obj.modelo)
      ..write(obj.anio)
      ..write(obj.motor)
      ..write(obj.vin)
      ..write(obj.kilometraje)
      ..write(obj.placa)
      ..write(obj.imagen)
      ..write(obj.color)
      ..writeBool(obj.seleccionado)
      ..writeBool(obj.entregado);
  }
}
