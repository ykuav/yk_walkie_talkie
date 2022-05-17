import 'package:flutter/material.dart';

class YkFormField extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;

  const YkFormField({Key? key, required this.hintText, this.validator, required TextEditingController controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          hintText: hintText,
          // border: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //   borderSide: BorderSide(color: Colors.grey),
          // ),
          // enabledBorder: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //   borderSide: BorderSide(color: Colors.grey),
          // ),
        ),
        validator: validator,
      ),
    );
  }
}
