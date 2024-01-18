import 'package:amecanico/Componetizacion/CustomTextField.dart';
import 'package:flutter/material.dart';

List<Widget> getFormulario(
  BuildContext context,
  List<CustomTextController> controladores,
) {
  List<Widget> textFields = [];
  for (var i = 0; i < controladores.length - 1; i++) {
    textFields.add(customTextField(
      controller: controladores[i],
      nextFocus: controladores[i + 1].focus,
      context: context,
    ));
    textFields.add(const SizedBox(height: 20));
  }
  textFields.add(customTextField(
    controller: controladores[7],
    nextFocus: null,
    context: context,
  ));
  return textFields;
}
