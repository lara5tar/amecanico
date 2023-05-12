import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgregarClientePage extends StatefulWidget {
  const AgregarClientePage({super.key});

  @override
  State<AgregarClientePage> createState() => _AgregarClientePageState();
}

class _AgregarClientePageState extends State<AgregarClientePage> {
  Ccliente cclientes = Ccliente();

  TextEditingController nombre = TextEditingController();
  TextEditingController domicilio = TextEditingController();
  TextEditingController telefono = TextEditingController();

  FocusNode nombreFocus = FocusNode();
  FocusNode domicilioFocus = FocusNode();
  FocusNode telefonoFocus = FocusNode();

  String _previousText = '';
  int x = 0;
  // List<Widget> coches = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Cliente'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            focusNode: nombreFocus,
            controller: nombre,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nombre',
            ),
            onSubmitted: (value) {
              nombreFocus.unfocus();
              FocusScope.of(context).requestFocus(telefonoFocus);
            },
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            focusNode: telefonoFocus,
            onSubmitted: (value) {
              telefonoFocus.unfocus();
              FocusScope.of(context).requestFocus(domicilioFocus);
            },
            controller: telefono,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Telefono',
            ),
            maxLength: 16,
            onChanged: (value) {
              x++;
              final currentText = value;
              if (currentText.length < _previousText.length) {
                //en esa parte evalua si esta borrando
              } else {
                //en esa parte evalua si esta escribiendo
                if (value.length == 3) {
                  telefono.text = '${telefono.text} - ';
                }
                if (value.length == 9) {
                  telefono.text = '${telefono.text} - ';
                }
              }
              _previousText = currentText;
              setState(() {});
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 5),
          TextField(
            focusNode: domicilioFocus,
            onSubmitted: (value) {
              domicilioFocus.unfocus();
            },
            controller: domicilio,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Domicilio',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                String respuesta =
                    cclientes.agregarCliente(nombre, domicilio, telefono);
                if (!respuesta.contains('agregado')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(respuesta),
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Agregar', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
