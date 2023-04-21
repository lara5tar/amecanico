import 'package:hive_flutter/adapters.dart';

import '../1. Modelo/Coche.dart';

class Ccoche {
  Box<Coche> coches = Hive.box<Coche>('coches');

  List<Coche> get listCoches => coches.values.toList();

  void agregarCoche(
    String marca,
    String modelo,
    String anio,
    String motor,
    String vin,
    String kilometraje,
    String placa,
  ) {
    coches.put(
      vin,
      Coche(
        marca: marca,
        modelo: modelo,
        anio: anio,
        motor: motor,
        vin: vin,
        kilometraje: kilometraje,
        placa: placa,
      ),
    );
  }
}
