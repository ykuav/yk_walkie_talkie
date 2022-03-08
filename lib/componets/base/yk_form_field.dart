import 'package:flutter/material.dart';

class YkFormField extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;

  const YkFormField({Key? key, required this.hintText, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
