import 'package:flutter/material.dart';

TextField customTextField({
  required CustomTextController controller,
  required FocusNode? nextFocus,
  required context,
  Function? onSubmitted,
}) {
  return TextField(
    focusNode: controller.focus,
    onSubmitted: (value) {
      if (nextFocus != null) {
        FocusScope.of(context).requestFocus(nextFocus);
      } else {
        FocusScope.of(context).unfocus();
      }
      if (onSubmitted != null) {
        onSubmitted();
      }
    },
    controller: controller.textController,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: controller.nombre,
    ),
  );
}

class CustomTextController {
  String nombre;
  TextEditingController textController = TextEditingController();
  FocusNode focus = FocusNode();

  CustomTextController(this.nombre);

  String getText() {
    return textController.text;
  }

  @override
  String toString() {
    return '$nombre: $getText()';
  }
}
