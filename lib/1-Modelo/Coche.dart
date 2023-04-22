import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Coche {
  @HiveField(0)
  String? marca;
  @HiveField(1)
  String? modelo;
  @HiveField(2)
  String? anio;
  @HiveField(3)
  String? motor;
  @HiveField(4)
  String? vin;
  @HiveField(5)
  String? kilometraje;
  @HiveField(6)
  String? placa;

  Coche({
    this.marca,
    this.modelo,
    this.anio,
    this.motor,
    this.vin,
    this.kilometraje,
    this.placa,
  });

  @override
  String toString() =>
      'Coche(marca: $marca, modelo: $modelo, anio: $anio, motor: $motor, vin: $vin, kilometraje: $kilometraje, placa: $placa)';
}

class CocheAdapter extends TypeAdapter<Coche> {
  @override
  final int typeId = 1;

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
      ..write(obj.placa);
  }
}
