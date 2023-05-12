import 'dart:convert';

import 'package:amecanico/1-Modelo/Campo.dart';
import 'package:amecanico/1-Modelo/Reporte.dart';
import 'package:amecanico/1-Modelo/Seccion.dart';
import 'package:amecanico/1-Modelo/Servicios.dart';
import 'package:amecanico/3-Controlador/ImagenC.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import '1-Modelo/CalendarioEventData.dart';
import '1-Modelo/Cliente.dart';
import '1-Modelo/Coche.dart';
import '2-Vista/Navegacion.dart';
import 'package:crypto/crypto.dart';

//REFEREBTE AL REPORTE, LA PARTE A LA QUE YO LLAMO SECCION EL COMO LA ESTRUCTURA, SI COMO LO HICE O DE OTRA FORMA

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  initFlutter();
  ImagenC().iniciar();

  print(generateCode('l'));

  ///3152412888
  ///1821009953
  ///2795808791

  runApp(const MyApp());
}

String generateCode(String secretKey) {
  // Obtener el tiempo actual en segundos
  int time = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  // Concatenar la llave secreta y el tiempo actual
  String combined = secretKey + time.toString();

  // Calcular el hash criptográfico (SHA-256) del valor combinado
  List<int> bytes = utf8.encode(combined);
  Digest hash = sha256.convert(bytes);

  // Tomar solo los primeros 4 dígitos del valor hash y convertirlos a decimal
  int decimal = int.parse(hash.toString().substring(0, 8), radix: 16);

  // Asegurarse de que el código de acceso tenga exactamente 4 dígitos
  String code = decimal.toString().padLeft(8, '0');

  return code;
}

initFlutter() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Coche>(CocheAdapter());
  Hive.registerAdapter<Cliente>(ClienteAdapter());
  var clientes = await Hive.openBox<Cliente>('clientes');

  Hive.registerAdapter<CalendarEventData>(CalendarEventDataAdapter());
  await Hive.openBox<CalendarEventData>('citas');

  Hive.registerAdapter<Campo>(CampoAdapter());
  Hive.registerAdapter<Seccion>(SeccionAdapter());
  Hive.registerAdapter<Servicio>(ServicioAdapter());
  Hive.registerAdapter<Reporte>(ReporteAdapter());

  await Hive.openBox<Reporte>('reportes');
  await Hive.openBox<Reporte>('borradores');
  var reportes = await Hive.openBox<Reporte>('plantillas');

  // clientes.addAll(clienteS());

  // for (Cliente cliente in clienteS()) {
  //   clientes.put(cliente.id, cliente);
  // }

  await Hive.openBox('mensajes');

  reportes.put('Orden Completa', reporte());

  reportes.put(
    'Orden Simple',
    Reporte(
      mapa: {},
      fecha: '',
      hora: '',
      nombreCliente: '',
      telefonoCliente: '',
      domicilioCliente: '',
      coche: '',
      imagenes: [],
      servicios: [
        Servicio(
          titulo: 'Problemas que presenta el vehiculo',
          secciones: [
            Seccion(
              titulo: '',
              campos: [
                Campo(
                  tipo: 'text',
                  opciones: ['Observaciones'],
                  entradas: [],
                  respuestas: {},
                ),
              ],
            ),
          ],
        ),
        Servicio(
          titulo: 'Procedimientos llevados a cabo',
          secciones: [
            Seccion(
              titulo: '',
              campos: [
                Campo(
                  tipo: 'text',
                  opciones: ['Observaciones'],
                  entradas: [],
                  respuestas: {},
                ),
              ],
            ),
          ],
        ),
        Servicio(
          titulo:
              'Partes que fueron/seran necesarias para el manteniemto/reparacion',
          secciones: [
            Seccion(
              titulo: '',
              campos: [
                Campo(
                  tipo: 'text',
                  opciones: ['Observaciones'],
                  entradas: [],
                  respuestas: {},
                ),
              ],
            ),
          ],
        ),
        Servicio(
          titulo: 'Trabajos pendientes para su proxima reparacion',
          secciones: [
            Seccion(
              titulo: '',
              campos: [
                Campo(
                  tipo: 'text',
                  opciones: ['Observaciones'],
                  entradas: [],
                  respuestas: {},
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MaterialColor colorAzul = const MaterialColor(
      0xFFFF6E40,
      <int, Color>{
        50: Color(0xffe6a02e),
        100: Color(0xffe6a02e),
        200: Color(0xffe6a02e),
        300: Color(0xffe6a02e),
        400: Color(0xffe6a02e),
        500: Color(0xffe6a02e),
        600: Color(0xffe6a02e),
        700: Color(0xffe6a02e),
        800: Color(0xffe6a02e),
        900: Color(0xffe6a02e),
      },
    );

    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData(
          cardColor: Color(0xff2c3e50),
          brightness: Brightness.dark,
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: colorAzul,
            cardColor: Color(0xff2c3e50),
            accentColor: Color(0xFFFF6E40),
            brightness: Brightness.dark,
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}

clienteS() {
  return [
    Cliente(
      nombre: 'Leslie Noemi',
      domicilio: 'Calle del Sol # 456, Colonia Centro',
      telefono: '833-456-7890',
      coches: [
        Coche(
          placa: 'DEF-5678',
          marca: 'Kia ',
          modelo: 'Sportage',
          kilometraje: '80,000 km',
          motor: '1.6L',
          imagen: '',
          vin: '2C3KA53G85H678901',
          anio: '2008',
          color: 'Azul',
        ),
      ],
    ),
    Cliente(
      nombre: 'Juan García',
      domicilio: 'Avenida de la Revolución # 789, Colonia Juárez',
      telefono: '833-123-4567',
      coches: [
        Coche(
          placa: 'ABC-1234',
          marca: 'Nissan ',
          modelo: 'Sentra',
          kilometraje: '50,000 km',
          motor: '2.0L',
          imagen: '',
          vin: '1HGCM82633A123456',
          anio: '2010',
          color: 'Rojo',
        ),
        Coche(
          placa: 'GHI-9012',
          marca: 'Ford ',
          modelo: 'Focus',
          kilometraje: '65,000 km',
          motor: '1.8L',
          imagen: '',
          vin: '3VWST7AJ8FM123456',
          anio: '2015',
          color: 'Blanco',
        ),
        Coche(
          placa: 'JKL-3456',
          marca: 'Toyota ',
          modelo: 'Hilux',
          kilometraje: '40,000 km',
          motor: '1.5L',
          imagen: '',
          vin: 'JA4JT21H4CP678901',
          anio: '2012',
          color: 'Rojo',
        ),
      ],
    ),
    Cliente(
      nombre: 'Ana López',
      domicilio: 'Calle Ocampo # 321, Colonia San Francisco',
      telefono: '833-987-6543',
      coches: [
        Coche(
          placa: 'MNO-7890',
          marca: 'Honda ',
          modelo: 'Civic',
          kilometraje: '70,000 km',
          motor: '2.4L',
          imagen: '',
          vin: '1C4RJFAG3FC234567',
          anio: '2014',
          color: 'Rojo',
        ),
        Coche(
          placa: 'PQR-2345',
          marca: 'Hyundai ',
          modelo: 'Elantra',
          kilometraje: '55,000 km',
          motor: '1.4L',
          imagen: '',
          vin: 'KMHDU4AD2AU901234',
          anio: '2015',
          color: 'Blanco',
        ),
      ],
    ),
    Cliente(
      nombre: 'Luis Torres',
      domicilio: 'Calle 16 de Septiembre # 234, Colonia Centro',
      telefono: '833-234-5678',
      coches: [
        Coche(
          placa: 'STU-6789',
          marca: 'Nissan ',
          modelo: 'Versa',
          kilometraje: '90,000 km',
          motor: '2.2L',
          imagen: '',
          vin: '5FNRL5H64EB456789',
          anio: '2013',
          color: 'Azul',
        ),
        Coche(
          placa: 'VWX-0123',
          marca: 'Chevrolet',
          modelo: 'Aveo',
          kilometraje: '75,000 km',
          motor: '1.9L',
          imagen: '',
          vin: '1G1JC5442G7890123',
          anio: '2014',
          color: 'Blanco',
        ),
      ],
    ),
    Cliente(
      nombre: 'María Ramírez',
      domicilio: 'Avenida Insurgentes # 567, Colonia Condesa',
      telefono: '833-876-5432',
      coches: [
        Coche(
          placa: 'YZA-4567',
          marca: 'Volkswagen',
          modelo: 'Vento',
          kilometraje: '60,000 km',
          motor: '2.5L',
          imagen: '',
          vin: '1NXBR32E35Z567890',
          anio: '2014',
          color: 'Rojo',
        ),
        Coche(
          placa: 'BCD-8901',
          marca: 'Honda ',
          modelo: 'CR-V',
          kilometraje: '85,000 km',
          motor: '1.3L',
          imagen: '',
          vin: 'JA32U2FU1DU234567',
          anio: '2004',
          color: 'Blanco',
        ),
        Coche(
          placa: 'ABC-123',
          marca: 'Ford ',
          modelo: 'F-150',
          kilometraje: '60,000 km',
          motor: '1.8L',
          imagen: '',
          vin: '1HGCM82633A123456',
          anio: '2016',
          color: 'Rojo',
        ),
      ],
    ),
    Cliente(
      nombre: 'Carlos Mendoza',
      domicilio: 'Calle Hidalgo # 987, Colonia Centro',
      telefono: '833-345-6789',
      coches: [
        Coche(
          placa: 'DEF-456',
          marca: 'Toyota ',
          modelo: 'Corolla',
          kilometraje: '45,000 km',
          motor: '2.0L',
          imagen: '',
          vin: '2C3KA53G85H678901',
          anio: '2013',
          color: 'Blanco',
        ),
      ],
    ),
    Cliente(
      nombre: 'Laura Ortiz',
      domicilio: 'Avenida México # 432, Colonia Lomas',
      telefono: '833-765-4321',
      coches: [
        Coche(
          placa: '',
          marca: 'Mazda',
          modelo: '3',
          kilometraje: '75,000 km',
          motor: '1.6L',
          imagen: '',
          vin: '3VWST7AJ8FM123456',
          anio: '2020',
          color: 'Rojo',
        ),
        Coche(
          placa: 'JKL-012',
          marca: 'Hyundai ',
          modelo: 'Accent',
          kilometraje: '55,000 km',
          motor: '1.5L',
          imagen: '',
          vin: 'JA4JT21H4CP678901',
          anio: '2003',
          color: 'Blanco',
        ),
      ],
    ),
    Cliente(
      nombre: 'José Morales',
      domicilio: 'Calle Galeana # 123, Colonia Centro',
      telefono: '833-890-1234',
      coches: [
        Coche(
          placa: 'MNO-345',
          marca: 'Kia ',
          modelo: 'Rio',
          kilometraje: '70,000 km',
          motor: '2.4L',
          imagen: '',
          vin: '1C4RJFAG3FC234567',
          anio: '2005',
          color: 'Rojo',
        ),
        Coche(
          placa: 'PQR-678',
          marca: 'Renault ',
          modelo: 'Duster',
          kilometraje: '80,000 km',
          motor: '1.4L',
          imagen: '',
          vin: 'KMHDU4AD2AU901234',
          anio: '2006',
          color: 'Blanco',
        ),
      ],
    ),
    Cliente(
      nombre: 'Isabel Castro',
      domicilio: 'Calle Ignacio Allende # 345, Colonia Centro',
      telefono: '833-678-9012',
      coches: [
        Coche(
          placa: 'VWX-234',
          marca: 'Mitsubishi ',
          modelo: 'Lancer',
          kilometraje: '65,000 km',
          motor: '1.9L',
          imagen: '',
          vin: '1G1JC5442G7890123',
          anio: '2009',
          color: 'Rojo',
        ),
      ],
    ),
    Cliente(
      nombre: 'Miguel Vargas',
      domicilio: 'Avenida Madero # 654, Colonia Centro Histórico',
      telefono: '833-210-9876',
      coches: [
        Coche(
          placa: 'YZA-567',
          marca: 'Chevrolet ',
          modelo: 'Spark',
          kilometraje: '90,000 km',
          motor: '2.5L',
          imagen: '',
          vin: '1NXBR32E35Z567890',
          anio: '2010',
          color: 'Blanco',
        ),
        Coche(
          placa: 'BCD-890',
          marca: 'Volkswagen ',
          modelo: 'Jetta',
          kilometraje: '85,000 km',
          motor: '1.3L',
          imagen: '',
          vin: 'JA32U2FU1DU234567',
          anio: '2014',
          color: 'Rojo',
        ),
        Coche(
          placa: 'STU-901',
          marca: 'Seat ',
          modelo: 'Ibiza',
          kilometraje: '50,000 km',
          motor: '2.2L',
          imagen: '',
          vin: '5FNRL5H64EB456789',
          anio: '2008',
          color: 'Blanco',
        ),
      ],
    ),
  ];
}

reporte() {
  return Reporte(
    mapa: {},
    fecha: '',
    hora: '',
    nombreCliente: '',
    telefonoCliente: '',
    domicilioCliente: '',
    coche: '',
    imagenes: [],
    servicios: [
      Servicio(
        titulo: 'Afinacion Mayor Completa Cambio de',
        secciones: [
          Seccion(
            titulo: 'Cambio de Bujias',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['4', '5', '6'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
              Campo(
                tipo: 'radio',
                opciones: ['Normal', 'Platino', 'Iridium'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Cambio de Filtro',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Aire', 'Aceite', 'Gasolina'],
                entradas: ['done', 'close', 'f/s'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Cambio de Aceite',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Aire', 'Aceite', 'Gasolina'],
                entradas: ['done', 'close', 'f/s'],
                respuestas: {},
              ),
              Campo(
                tipo: 'check',
                opciones: ['5w/30', '10w/30', '15w/30', '15w/40', '20w/50'],
                entradas: ['done', 'close', 'f/s'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: '',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Cables'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: '',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Liq Inj'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: '',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Tapa/Dist'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: '',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Cables'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: '',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['PVC'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: '',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Rotor'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Observacion',
            campos: [
              Campo(
                tipo: 'text',
                opciones: ['Observaciones'],
                entradas: [],
                respuestas: {},
              ),
            ],
          ),
        ],
      ),
      Servicio(
        titulo: 'Servicio de Frenos Cambio de',
        secciones: [
          Seccion(
            titulo: 'Balatas delanteras',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['si', 'no'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
              Campo(
                tipo: 'radio',
                opciones: ['15%', '25%', '50%', '75%'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Zapatas o Balatas Traceras',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['si', 'no'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
              Campo(
                tipo: 'radio',
                opciones: ['15%', '25%', '50%', '75%'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
        ],
      ),
      Servicio(
        titulo: 'Servicio de Suspension Cambio de',
        secciones: [
          Seccion(
            titulo: 'Terminal interior',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Teiminal exterior',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Hules de la barra Est',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Rotula inferior',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Rotula superior',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Tornillos de la barra Est',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Amortiguadores delanteros',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Amortiguadores traceros',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Horquillas',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Izq', 'Der'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Gomas amort',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Tras', 'Dela'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Bujes de horquilla tras',
            campos: [
              Campo(
                tipo: 'check',
                opciones: ['Tras', 'Dela'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Observaciones',
            campos: [
              Campo(
                tipo: 'text',
                opciones: ['Observaciones'],
                entradas: [],
                respuestas: {},
              )
            ],
          ),
        ],
      ),
      Servicio(
        titulo: 'Servicio Direccion Hidraulica Reparacion de',
        secciones: [
          Seccion(
            titulo: 'Bomba de Direccion Hidraulica',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Fuga si', 'Fuga no'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
              Campo(
                tipo: 'radio',
                opciones: ['si', 'no'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Linea de Alta Precion',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Mangera Rota si', 'Manguera Rota no'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
              Campo(
                tipo: 'radio',
                opciones: ['Con Fuga de Aceite: si', 'Con Fuga de Aceite: no'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Linea de Retorno',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Mangera Rota: si', 'Manguera Rota: no'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
              Campo(
                tipo: 'radio',
                opciones: ['Con Fuga de Aceite: si', 'Con Fuga de Aceite: no'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(titulo: 'Cremallera de la direccion', campos: [
            Campo(
              tipo: 'check',
              opciones: ['Izq', 'Der'],
              entradas: ['done', 'close'],
              respuestas: {},
            )
          ]),
          Seccion(titulo: 'Observaciones', campos: [
            Campo(
              tipo: 'text',
              opciones: ['Observaciones'],
              entradas: [],
              respuestas: {},
            )
          ])
        ],
      ),
      Servicio(
        titulo: 'Condiciones del Motor',
        secciones: [
          Seccion(
            titulo: 'Banda de Alternador',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Tostada', 'Rota', 'Chilla'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Polea Tensora',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Tostada', 'Rota', 'Chilla'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Polea loca',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Tostada', 'Rota', 'Chilla'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
            ],
          ),
          Seccion(
            titulo: 'Fan Cluch',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Tostado', 'Roto', 'Chilla'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Bomba de agua',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Gotea', 'Chilla'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Presion bomba de aceite',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Nomarl', 'Alta', 'baja'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Tapa de punteria',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Tapa del Carter',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Registro del Monoblock',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Cadena de tiempo',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'reten de cigueñal',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Reten Arbol de Levas',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Observaciones',
            campos: [
              Campo(
                tipo: 'text',
                opciones: ['Observaciones'],
                entradas: [],
                respuestas: {},
              )
            ],
          ),
        ],
      ),
      Servicio(
        titulo: 'Condicion del Sistema de Enfriamento',
        secciones: [
          Seccion(
            titulo: 'Radiador Tapado',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              ),
              Campo(
                tipo: 'radio',
                opciones: ['Anticongelante', 'Agua'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Mangeras Rotas',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Tapon con Fuga',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Bomba de Agua con Fuga',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Abrazaderas Rotas',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Thermostato Roto',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Deposito Roto',
            campos: [
              Campo(
                tipo: 'radio',
                opciones: ['Si', 'No'],
                entradas: ['done', 'close'],
                respuestas: {},
              )
            ],
          ),
          Seccion(
            titulo: 'Observaciones',
            campos: [
              Campo(
                tipo: 'text',
                opciones: ['Observaciones'],
                entradas: [],
                respuestas: {},
              )
            ],
          )
        ],
      )
    ],
  );
}
// const MaterialColor(
//   0xff2c3e50,
//   <int, Color>{
//     50: Color(0xffe6a02e),
//     100: Color(0xffe6a02e),
//     200: Color(0xffe6a02e),
//     300: Color(0xffe6a02e),
//     400: Color(0xffe6a02e),
//     500: Color(0xffe6a02e),
//     600: Color(0xffe6a02e),
//     700: Color(0xffe6a02e),
//     800: Color(0xffe6a02e),
//     900: Color(0xffe6a02e),
//   },
// ),
