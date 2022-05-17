import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:yk_walkie_talkie/util/opus_util.dart';

const token = '123456';
late Socket socket;

class ShoutProtocol {
  static const ip = "10.10.62.14";
  static const port = 9921;
  static var selectPayload = "";

  static Future<void> connect() async {
    socket = await Socket.connect(ip, port);
    socket.encoding = Encoding.getByName("utf-8")!;
    // socket.
  }

  static void send(Object obj) {
    socket.write(obj);
    socket.flush();
  }

  static void appReg() async {
    send("[25]$token\r\n");
  }

  static void selectWorkPayload(String payloadId) {
    send("[26]$payloadId\r\n");
  }

  static void setVolume(int vol) {
    String volStr = vol.toString();
    if (volStr.length <= 1) {
      volStr == "0" + volStr;
    }
    send("[14]$volStr\r\n");
  }

  static Future<void> realTimeShout(Uint8List data) async {
    var i = 0;
    var j = 0;
    var sendData = Uint8List(1024);
    while (i < data.length) {
      sendData[j] = data[i];
      if (i % 1023 - 44 == 0) {
        socket.add(utf8.encode("[10]"));
        // data = await encode(data);
        var wavh =
            wavHeader(sampleRate: 8000, channels: 1, fileSize: sendData.length);
        print("wavh:$wavh");
        socket.add(wavh);
        print("sendData:$sendData");
        socket.add(sendData);
        // socket.add(utf8.encode("\r\n"));
        await socket.flush();
        sendData = Uint8List(1024);
        j = 0;
        i++;
      } else {
        i++;
        j++;
      }
    }
    if (sendData.isNotEmpty) {
      socket.add(utf8.encode("[10]"));
      // data = await encode(data);
      var wavh =
          wavHeader(sampleRate: 8000, channels: 1, fileSize: sendData.length);
      print("wavh:$wavh");
      socket.add(wavh);
      print("sendData:$sendData");
      socket.add(sendData);
      // socket.add(utf8.encode("\r\n"));
      socket.flush();
    }

    // send();
  }
}
