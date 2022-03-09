import 'package:flutter/material.dart';

class YkDevices extends StatelessWidget {
  const YkDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          deviceCard(context, 1, "易酷测试0001", "YKS130", "YKS0000001", 0, 0),
          deviceCard(context, 2, "易酷测试0002", "YKS130", "YKS0000002", 0, 1),
          deviceCard(context, 3, "易酷测试0003", "YKS130", "YKS0000003", 0, 0),
          deviceCard(context, 4, "易酷测试0004", "YKS130", "YKS0000004", 0, 1),
          deviceCard(context, 5, "易酷测试0005", "YKS130", "YKS0000005", 0, 0),
          deviceCard(context, 6, "易酷测试0006", "YKS130", "YKS0000006", 0, 1),
          deviceCard(context, 7, "易酷测试0007", "YKS130", "YKS0000007", 0, 0),
          deviceCard(context, 8, "易酷测试0008", "YKS130", "YKS0000008", 0, 1),
        ],
      ),
    );
  }

  String getDeviceTypeName(int deviceType) {
    if (deviceType == 0) {
      return "喊话器";
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
        onTap: () => {
              if (deviceType == 0)
                {Navigator.pushNamed(context, "/device_megaphone_detail")}
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
                          padding: EdgeInsets.only(bottom: 4),
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
                                      padding: EdgeInsets.only(right: 2),
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
