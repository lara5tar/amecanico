import 'package:flutter/material.dart';

import '../../1-Modelo/Cliente.dart';

import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive_flutter/adapters.dart';

class VerCliente extends StatefulWidget {
  Cliente cliente;
  VerCliente({super.key, required this.cliente});

  @override
  State<VerCliente> createState() => _VerClienteState();
}

class _VerClienteState extends State<VerCliente> {
  TextEditingController controller = TextEditingController();
  bool _hasCallSupport = false;
  Future<void>? launched;
  String phone = '';

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
        if (widget.cliente.telefono == 'Sin telefono') {
          _hasCallSupport = false;
        }
      });
    });
  }

  void sendWhatsAppMessage(String phoneNumber) async {
    // String phoneNumber =
    //     '+52 1 833 382 0929'; // Número de teléfono del destinatario
    // String message = 'Hola, ¿cómo estás?'; // Mensaje a enviar

    var url =
        'https://wa.me/${phoneNumber.replaceAll(' - ', '')}?text=HelloWorld';
    print('https://wa.me/${phoneNumber.replaceAll(' - ', '')}?text=HelloWorld');

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }

  // void sendWhatsAppMessage(String phoneNumber, String mensaje) async {
  //   var url = 'https://wa.me/$phoneNumber?text=$mensaje}';
  //   final link = Uri(
  //     scheme: 'https',
  //     path: 'wa.me/$phoneNumber',
  //     queryParameters: <String, String>{
  //       'text': mensaje.replaceAll('cliente', widget.cliente.nombre)
  //     },
  //   );

  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'No se pudo abrir la URL: $url';
  //   }
  // }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendSms(String phoneNumber, String mensaje) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': mensaje.replaceAll('cliente', widget.cliente.nombre)
      },
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del Cliente ${widget.cliente.id}'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  widget.cliente.nombre,
                  style: const TextStyle(
                    fontSize: 30,
                    overflow: TextOverflow.visible,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  widget.cliente.telefono,
                  style: const TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.visible,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  widget.cliente.domicilio,
                  style: const TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.visible,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: _hasCallSupport
                    ? () => setState(
                          () {
                            launched = _makePhoneCall(widget.cliente.telefono);
                          },
                        )
                    : null,
                icon: const Icon(
                  Icons.call,
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: _hasCallSupport
                    ? () => setState(
                          () {
                            // _launched = _sendSms(widget.cliente.telefono);
                            dialogosms(context, 'whatsapp');
                          },
                        )
                    : null,
                icon: ImageIcon(
                  AssetImage('assets/was.png'),
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: () {
                  // sendWhatsAppMessage(widget.cliente.telefono, 'hola');
                  dialogosms(context, 'sms');
                },
                icon: const Icon(
                  Icons.message,
                  size: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ...widget.cliente.coches.map(
                  (e) => ListTile(
                    title: Text(e.marca),
                    subtitle: Text(e.modelo),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.car_repair,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialogosms(BuildContext context, String tipo) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enviar SMS'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
        ],
        content: StatefulBuilder(
          builder: (context, snapshot) {
            return Container(
              height: 100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...Hive.box('mensajes')
                        .values
                        .map(
                          (e) => TextButton(
                            onPressed: () {
                              setState(() {
                                if (tipo == 'sms') {
                                  launched = _sendSms(
                                    widget.cliente.telefono,
                                    e,
                                  );
                                } else if (tipo == 'whatsapp') {
                                  sendWhatsAppMessage(widget.cliente.telefono);
                                }
                              });
                            },
                            child: Text(
                                e.replaceAll('cliente', widget.cliente.nombre)),
                          ),
                        )
                        .toList(),
                    TextButton(
                      onPressed: () {
                        //formulario para agregar un mensaje
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Agregar mensaje'),
                            content: TextField(
                              controller: controller,
                              onChanged: (value) {
                                setState(() {
                                  phone = value;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'Ingrese el mensaje'),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancelar')),
                              TextButton(
                                  onPressed: () {
                                    Hive.box('mensajes').add(controller.text);
                                    Navigator.pop(context);

                                    Navigator.pop(context);
                                    controller.clear();
                                  },
                                  child: Text('Aceptar')),
                            ],
                          ),
                        ).then(
                          (value) => setState(
                            () => controller.clear(),
                          ),
                        );
                      },
                      child: Text('Agregar mensaje'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
