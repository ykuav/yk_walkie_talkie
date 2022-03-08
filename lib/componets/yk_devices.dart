import 'package:flutter/material.dart';

class YkDevices extends StatelessWidget {
  const YkDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Column(
            children: [Title(color: Colors.black, child: Text("测试"))],
          ),
        ),
      ],
    );
  }
}
