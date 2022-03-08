import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../componets/base/yk_form_field.dart';

class YkLoginPage extends StatefulWidget {
  const YkLoginPage({Key? key}) : super(key: key);

  @override
  State<YkLoginPage> createState() => _YkLoginPageState();
}

class _YkLoginPageState extends State<YkLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 120, bottom: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(width: 120, height: 120),
              child: const Image(
                image: AssetImage('images/logo.jpg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  YkFormField(
                    hintText: '用户名/手机号',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '请输入用户名';
                      }
                      return null;
                    },
                  ),
                  YkFormField(
                    hintText: '密码',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '请输入密码';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // Process data.
                        }
                      },
                      child: const Text('登录'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
