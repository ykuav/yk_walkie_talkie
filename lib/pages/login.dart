import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toast/toast.dart';

import '../componets/base/yk_form_field.dart';
import '../util/api.dart';
import '../util/shared_preferences.dart';

class YkLoginPage extends StatefulWidget {
  const YkLoginPage({Key? key}) : super(key: key);

  @override
  State<YkLoginPage> createState() => _YkLoginPageState();
}

class _YkLoginPageState extends State<YkLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle linkTextStyle = const TextStyle(color: Colors.blue);
  var dio = Dio();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      var response = await post('${baseUrl}account/login', {
        "phone": _phoneController.text,
        "password": _passwordController.text
      });
      print("tk:${response["tk"]}");
      PersistentStorage().setStorage("token", response["tk"]);
      showToast("登录成功", position: ToastPosition.bottom);
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 8, right: 8, top: 120, bottom: 20),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints.expand(width: 120, height: 120),
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
                      hintText: '手机号',
                      textEditingController: _phoneController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return '请输入用户名';
                        }
                        return null;
                      },
                    ),
                    YkFormField(
                      obscureText: true,
                      hintText: '密码',
                      textEditingController: _passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return '请输入密码';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Radio<bool>(
                            value: false,
                            groupValue: false,
                            onChanged: (val) {}),
                        const Text("我已阅读并同意"),
                        GestureDetector(
                          child: Text(
                            "《服务条款》",
                            style: linkTextStyle,
                          ), // TODO: 没有加链接
                        ),
                        GestureDetector(
                          child: Text(
                            "《隐私政策》",
                            style: linkTextStyle,
                          ), // TODO: 没有加链接
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: () async {
                          login();
                        },
                        child: const Text('登录'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Text(
                                "忘记密码",
                                style: linkTextStyle,
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: Text(
                                "注册账号",
                                textAlign: TextAlign.right,
                                style: linkTextStyle,
                              ),
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
