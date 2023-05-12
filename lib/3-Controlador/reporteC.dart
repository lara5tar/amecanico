import 'package:hive_flutter/adapters.dart';

import '../1-Modelo/Cliente.dart';
import '../1-Modelo/Coche.dart';
import '../1-Modelo/Reporte.dart';

class ReporteC {
  Box<Reporte> reportes = Hive.box<Reporte>('reportes');
  Box<Reporte> borradores = Hive.box<Reporte>('borradores');
  Box<Reporte> plantillas = Hive.box<Reporte>('plantillas');

  Reporte? reporte;

  ReporteC({this.reporte});

  List<Reporte> get listReportes => reportes.values.toList();
  List<Reporte> get listBorradores => borradores.values.toList();
  List<Reporte> get listPlantillas => plantillas.values.toList();

  // //obtener la lista de borradores desde el ultimo borrador hasta el primero
  // List<Reporte> get listBorradoresInvertida {
  //   List<Reporte> lista = [];
  //   for (var i = listBorradores.length - 1; i >= 0; i--) {
  //     lista.add(listBorradores[i]);
  //   }
  //   return lista;
  // }

  crearReporteBorrador(Cliente cliente, Coche coche) {
    reporte!.nombreCliente = cliente.nombre;
    reporte!.telefonoCliente = cliente.telefono;
    reporte!.domicilioCliente = cliente.domicilio;
    reporte!.coche = '${coche.marca} ${coche.modelo} ${coche.anio}';
    reporte!.fecha =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
    reporte!.hora =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    borradores.add(reporte!);
  }

  guardarPlantilla() {
    plantillas.put(
      plantillas.values.toList().indexOf(reporte!),
      reporte!,
    );
  }

  guardarReporte() {
    print(reporte);

    borradores.put(
      borradores.values.toList().indexOf(reporte!),
      reporte!,
    );
    print(reporte!.toMap());
  }

  eliminarReporte() {
    reportes.deleteAt(
      reportes.values.toList().indexOf(reporte!),
    );
  }

  finalizarReporte() {
    borradores.deleteAt(
      borradores.values.toList().indexOf(reporte!),
    );
    reportes.add(reporte!);
  }
}
