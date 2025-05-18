import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onCancel;
  VoidCallback onAdded;
  AddDialog(
      {required this.controller,
      required this.onAdded,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter une list"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
            hintText: " Entrer le nom de la nouvelle liste"),
      ),
      actions: [
        TextButton(onPressed: onAdded, child: const Text("Valider")),
        TextButton(onPressed: onCancel, child: const Text("Valider")),
      ],
    );
  }
}
