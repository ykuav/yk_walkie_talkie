import 'package:flutter/material.dart';

class YkDevices extends StatelessWidget {
  const YkDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardLabelTextStyle = TextStyle(color: Colors.grey);
    return SafeArea(
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset("images/hanhuaqi.jpg"),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "易酷测试喊话器001",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "型号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS130"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "序列号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS00000001"),
                                  flex: 4,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "类型",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("喊话器"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "状态",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 2),
                                        child: Icon(
                                          Icons.radio_button_on,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text("离线")
                                    ],
                                  ),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset("images/hanhuaqi.jpg"),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "易酷测试喊话器002",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "型号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS130"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "序列号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS00000001"),
                                  flex: 4,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "类型",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("喊话器"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "状态",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 2),
                                        child: Icon(
                                          Icons.radio_button_on,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text("在线")
                                    ],
                                  ),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset("images/hanhuaqi.jpg"),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "易酷测试喊话器001",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "型号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS130"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "序列号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS00000001"),
                                  flex: 4,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "类型",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("喊话器"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "状态",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 2),
                                        child: Icon(
                                          Icons.radio_button_on,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text("在线")
                                    ],
                                  ),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset("images/hanhuaqi.jpg"),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "易酷测试喊话器001",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "型号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS130"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "序列号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS00000001"),
                                  flex: 4,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "类型",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("喊话器"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "状态",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 2),
                                        child: Icon(
                                          Icons.radio_button_on,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text("在线")
                                    ],
                                  ),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset("images/hanhuaqi.jpg"),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "易酷测试喊话器001",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "型号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS130"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "序列号",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("YS00000001"),
                                  flex: 4,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "类型",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text("喊话器"),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "状态",
                                    style: cardLabelTextStyle,
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 2),
                                        child: Icon(
                                          Icons.radio_button_on,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text("在线")
                                    ],
                                  ),
                                  flex: 4,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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
