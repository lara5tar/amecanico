import 'package:amecanico/2-Vista/Reporte/NewSeleccionarCoche.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import '../../1-Modelo/Cliente.dart';
import '../../3-Controlador/clientesC.dart';

class NewSeleccionarCliente extends StatefulWidget {
  const NewSeleccionarCliente({super.key});

  @override
  State<NewSeleccionarCliente> createState() => _NewSeleccionarClienteState();
}

class _NewSeleccionarClienteState extends State<NewSeleccionarCliente> {
  Ccliente cclientes = Ccliente();
  Cliente? seleccionado;
  String opcion = 'Buscar';
  int x = 0;

  bool estaBorrando = false;

  TextEditingController cNombreBuscar = TextEditingController();
  TextEditingController cDomicilioBuscar = TextEditingController();
  TextEditingController cTelefonoBuscar = TextEditingController();

  TextEditingController cNombreNuevo = TextEditingController();
  TextEditingController cDomicilioNuevo = TextEditingController();
  TextEditingController cTelefonoNuevo = TextEditingController();

  String _previousText = '';

  @override
  void initState() {
    super.initState();
    // cNombreBuscar.addListener(() {
    //   final currentText = cNombreBuscar.text;
    //   if (currentText.length < _previousText.length) {}
    //   _previousText = currentText;
    //   setState(() {});
    // });

    // cTelefonoNuevo.addListener(() {
    //   final currentText = cTelefonoBuscar.text;
    //   if (currentText.length < _previousText.length) {
    //     estaBorrando = true;
    //     print('entro');
    //   } else {
    //     print('object');
    //     if (cTelefonoNuevo.text.length == 3) {
    //       cTelefonoNuevo.text = '${cTelefonoNuevo.text} - ';
    //     }
    //     if (cTelefonoNuevo.text.length == 9) {
    //       cTelefonoNuevo.text = '${cTelefonoNuevo.text} - ';
    //     }
    //   }
    //   print(estaBorrando.toString());
    //   _previousText = currentText;
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Seleccionar cliente',
          style: TextStyle(
            overflow: TextOverflow.visible,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            CustomRadioButton(
              height: 50,
              width: MediaQuery.of(context).size.width / 2.3,
              selectedBorderColor: Theme.of(context).colorScheme.secondary,
              unSelectedBorderColor: Theme.of(context).colorScheme.secondary,
              enableShape: true,
              defaultSelected: opcion,
              elevation: 0,
              absoluteZeroSpacing: false,
              unSelectedColor: Colors.transparent,
              buttonLables: const [
                'Buscar',
                'Nuevo',
              ],
              buttonValues: const [
                'Buscar',
                'Nuevo',
              ],
              buttonTextStyle: const ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.deepOrangeAccent,
                textStyle: TextStyle(fontSize: 20),
              ),
              radioButtonValue: (value) {
                setState(() {
                  opcion = value.toString();
                });
              },
              selectedColor: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 20),
            opcion == 'Buscar'
                ? Row(
                    children: [
                      Expanded(
                        child: Autocomplete(
                          optionsMaxHeight: 100,
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            return TextField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              onSubmitted: (value) {},
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                ),
                                hintText: 'Buscar por nombre/telefono',
                              ),
                            );
                          },
                          displayStringForOption: (Cliente option) {
                            seleccionado = option;

                            return '${option.nombre} | ${option.telefono}';
                          },
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<Cliente>.empty();
                            }
                            return cclientes.listClientes.where(
                              (Cliente option) {
                                return option.nombre.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase()) ||
                                    option.telefono
                                        .replaceAll(' - ', '')
                                        .toLowerCase()
                                        .contains(
                                          textEditingValue.text.toLowerCase(),
                                        );
                              },
                            );
                          },
                          onSelected: (Cliente selection) {
                            cNombreBuscar.text = selection.nombre;
                            cTelefonoBuscar.text = selection.telefono;
                            cDomicilioBuscar.text = selection.domicilio;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 56,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.secondary),
                          ),
                          onPressed: () {},
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
            opcion == 'Buscar' ? const SizedBox(height: 20) : const SizedBox(),
            TextField(
              readOnly: opcion == 'Buscar' ? true : false,
              controller: opcion == 'Buscar' ? cNombreBuscar : cNombreNuevo,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                labelText: opcion == 'Buscar' ? 'Nombre' : 'Nombre*',
              ),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 20),
            TextField(
              maxLength: 16,
              keyboardType: TextInputType.number,
              readOnly: opcion == 'Buscar' ? true : false,
              controller: opcion == 'Buscar' ? cTelefonoBuscar : cTelefonoNuevo,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: const OutlineInputBorder(),
                labelText: opcion == 'Buscar' ? 'Telefono' : 'Telefono*',
              ),
              onChanged: (value) {
                x++;
                final currentText = value;
                if (currentText.length < _previousText.length) {
                  //en esa parte evalua si esta borrando
                } else {
                  //en esa parte evalua si esta escribiendo
                  if (value.length == 3) {
                    cTelefonoNuevo.text = '${cTelefonoNuevo.text} - ';
                  }
                  if (value.length == 9) {
                    cTelefonoNuevo.text = '${cTelefonoNuevo.text} - ';
                  }
                }
                _previousText = currentText;
                setState(() {});
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),
            TextField(
              readOnly: opcion == 'Buscar' ? true : false,
              controller:
                  opcion == 'Buscar' ? cDomicilioBuscar : cDomicilioNuevo,
              decoration: const InputDecoration(
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
                labelText: 'Domicilio',
              ),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            if (opcion == 'Nuevo') {
              if (cNombreNuevo.text.isNotEmpty ||
                  cTelefonoNuevo.text.isNotEmpty) {
                dialogo(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Por favor ingrese el nombre y el telefono del cliente.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } else {
              if (seleccionado == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'No se ha seleccionado ningun cliente, por favor seleccione uno o cree uno nuevo.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewSeleccionarCoche(
                      cliente: seleccionado!,
                      seGuardara: true,
                    ),
                  ),
                );
              }
            }
          },
          label: const Row(
            children: [
              Text(
                'Seguir',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_forward,
                size: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> dialogo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const SizedBox(width: 10),
            const Text('Guardar cliente'),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            )
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '¿Desea guardar el cliente ${cNombreNuevo.text} con numero de telefono ${cTelefonoNuevo.text}?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                //aqui no se guarda el cliente en hive, pero se guarda el nombre y telefono en el formulario

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewSeleccionarCoche(
                      cliente: Cliente(
                        coches: [],
                        nombre: cNombreNuevo.text,
                        domicilio: cDomicilioNuevo.text,
                        telefono: cTelefonoNuevo.text,
                      ),
                      seGuardara: false,
                    ),
                  ),
                );
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('No guardar'), Text('y continuar')],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                //aqui se guarda el cliente en hive, y se guarda el nombre y telefono en el formulario
                String respuesta = cclientes.agregarCliente(
                    cNombreNuevo, cDomicilioNuevo, cTelefonoNuevo);
                if (!respuesta.contains('agregado')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(respuesta),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewSeleccionarCoche(
                        cliente: cclientes.listClientes.last,
                        seGuardara: true,
                      ),
                    ),
                  );
                }
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Guardar'), Text('y continuar')],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
