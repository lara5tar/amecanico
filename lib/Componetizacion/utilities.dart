import 'package:flutter/material.dart';

scaffoldMessenger(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensaje),
      duration: const Duration(seconds: 1),
    ),
  );
}
