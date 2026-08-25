import 'package:flutter/material.dart';

class AddUserTextField extends StatelessWidget {
  const AddUserTextField({
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        validator: validator,
      ),
    );
  }
}
