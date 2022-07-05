import 'package:flutter/material.dart';
import 'package:yk_walkie_talkie/protocol/shout_protocol.dart';
import 'package:yk_walkie_talkie/util/api.dart';

class YkDevices extends StatefulWidget {
  const YkDevices({Key? key}) : super(key: key);

  @override
  _YkDevicesState createState() => _YkDevicesState();
}

class _YkDevicesState extends State<YkDevices> {
  var data = [];

  @override
  void initState() {
    super.initState();
    getPayload();
  }

  void getPayload() async {
    var response = await postResultList(
        "${baseUrl}payload/user_get_payload_list", {},
        headers: {});
    print("response:${response}");
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        // deviceCard(context, 1, "易酷测试0001", "YKS130", "000000000001", 0, 0),
        children: data
            .map((e) => deviceCard(
                context,
                1,
                e["payload_alias"],
                e["payload_device_model"],
                e["payload_serial_num"],
                e["payload_device_type"],
                0))
            .toList(),
      ),
    );
  }

  String getDeviceTypeName(int deviceType) {
    if (deviceType == 1) {
      return "喊话器";
    }
    if (deviceType == 2) {
      return "照明";
    }
    if (deviceType == 3) {
      return "抛投";
    }
    return "未知";
  }

  Widget deviceCard(
      BuildContext context,
      int deviceId,
      String deviceName, //设备名
      String deviceModel, // 设备型号
      String deviceSN, // 设备序列号
      int deviceType, // 设备类型
      int deviceStatus // 设备状态
      ) {
    const cardLabelTextStyle = TextStyle(color: Colors.grey);

    return GestureDetector(
        onTap: () {
          ShoutProtocol.selectPayload = deviceSN;
          ShoutProtocol.selectWorkPayload(deviceSN);
          Navigator.pushNamed(context, "/device_megaphone_detail");
        },
        child: Card(
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            deviceName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "型号",
                                  style: cardLabelTextStyle,
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text(deviceModel),
                                flex: 4,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "序列号",
                                  style: cardLabelTextStyle,
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text(deviceSN),
                                flex: 4,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "类型",
                                  style: cardLabelTextStyle,
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Text(getDeviceTypeName(deviceType)),
                                flex: 4,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              const Expanded(
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
                                      padding: const EdgeInsets.only(right: 2),
                                      child: Icon(
                                        Icons.radio_button_on,
                                        color: deviceStatus == 0
                                            ? Colors.red
                                            : Colors.blue,
                                      ),
                                    ),
                                    Text(deviceStatus == 0 ? "离线" : "在线")
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
        ));
  }
}
