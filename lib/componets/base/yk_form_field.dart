import 'package:flutter/material.dart';

class YkFormField extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? textEditingController;

  final bool? obscureText;

  const YkFormField(
      {Key? key,
      required this.hintText,
      this.validator,
      this.obscureText,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText ?? false,
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
