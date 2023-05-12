import 'package:flutter/material.dart';

import '../../1-Modelo/Cliente.dart';

import 'dart:async';
import 'package:url_launcher/link.dart';
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
  Future<void>? _launched;
  String _phone = '';

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
        'body': mensaje.replaceAll('nombre', widget.cliente.nombre)
      },
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del Cliente'),
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
                            _launched = _makePhoneCall(widget.cliente.telefono);
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
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Enviar SMS'),
                                content: StatefulBuilder(
                                  builder: (context, snapshot) {
                                    return Container(
                                      height: 200,
                                      child: ListView(
                                        children: [
                                          ...Hive.box('mensajes')
                                              .values
                                              .map(
                                                (e) => TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _launched = _sendSms(
                                                        widget.cliente.telefono,
                                                        e,
                                                      );
                                                      // Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text(e.replaceAll(
                                                      'nombre',
                                                      widget.cliente.nombre)),
                                                ),
                                              )
                                              .toList(),
                                          TextButton(
                                            onPressed: () {
                                              //formulario para agregar un mensaje
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text(
                                                      'Agregar mensaje\nEscriba \'nombre\' para agregar el nombre del cliente'),
                                                  content: TextField(
                                                    controller: controller,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _phone = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Ingrese el mensaje'),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            Text('Cancelar')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Hive.box('mensajes')
                                                              .add(controller
                                                                  .text);
                                                          Navigator.pop(
                                                              context);
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
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        )
                    : null,
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
}
