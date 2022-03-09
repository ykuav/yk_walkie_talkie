import 'package:flutter/material.dart';

class YkAccount extends StatelessWidget {
  const YkAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        children: [
          Card(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.fromLTRB(12, 12, 8.0, 12),
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('images/header.png'),
                      radius: 30,
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "liuhaoran",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          margin: const EdgeInsets.only(top: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          // color: Colors.green,
                          child: const Text(
                            "设备数:10",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 3,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                    child: Text(
                  "版本信息",
                  style: TextStyle(fontSize: 16),
                )),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                    child: Text(
                  "隐私条款",
                  style: TextStyle(fontSize: 16),
                )),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                    child: Text(
                  "关于我们",
                  style: TextStyle(fontSize: 16),
                )),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: const Text("退出登录"),
            ),
          )
        ],
      ),
    );
  }
}
