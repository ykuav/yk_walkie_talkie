import 'package:flutter/material.dart';

class YkAccount extends StatelessWidget {
  const YkAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            child: Column(
              children: [
                Title(color: Colors.black, child: Text("测试")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    child: const Text("登录"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
