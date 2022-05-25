import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:opus_dart/opus_dart.dart';
import 'package:yk_walkie_talkie/util/opus_util.dart';

const token = '123456';
late Socket socket;

class ShoutProtocol {
  // static const ip = "10.10.62.14";
  static const ip = "103.85.84.51";
  static const port = 9921;
  static var selectPayload = "";
  static const channel = MethodChannel("abc");

  static Future<void> connect() async {
    socket = await Socket.connect(ip, port);
    socket.encoding = Encoding.getByName("utf-8")!;
    // socket.
  }

  static void send(Object obj) {
    socket.write(obj);
    socket.flush();
  }

  static void sendBytes(List<int> bytes) {
    socket.add(bytes);
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
    print("=================================================================");
    var header = utf8.encode("[10]");
    channel.invokeMethod("opusEncode", {"data": data}).then((value) {
      log("opusEncode:$value");
      log("opusEncode:${data.length}");
      log("opusEncode len:${value.length}");
      socket.add(header + value);
      socket.flush();
      print("****************************************************************");
    });
    //
    // if (data.length <= (1023 - 5)) {
    //   // var wavh =
    //   //     wavHeader(sampleRate: 8000, channels: 1, fileSize: data.length);
    //   socket.add(header + data);
    //   // socket.add(utf8.encode("\r\n"));
    //   socket.flush();
    //
    //   return;
    // }
    //
    // // log("data:$data");
    // var i = 0;
    // var j = 0;
    // var sendData = Uint8List(1024);
    // while (i < data.length) {
    //   sendData[j] = data[i];
    //   if (i > 0 && i % (1023 - 4) == 0) {
    //     // data = await encode(data);
    //     // var wavh =
    //     //     wavHeader(sampleRate: 8000, channels: 1, fileSize: sendData.length);
    //     socket.add(header + sendData);
    //     // socket.add(utf8.encode("\r\n"));
    //     await socket.flush();
    //     print('send:${header + sendData}');
    //     if (data.length - i - (1023 - 4) >= 0) {
    //       sendData = Uint8List(1024);
    //     } else {
    //       sendData = Uint8List(data.length - i - 1);
    //     }
    //     j = 0;
    //     i++;
    //   } else {
    //     i++;
    //     j++;
    //   }
    // }
    // if (sendData.isNotEmpty) {
    //   // data = await encode(data);
    //   // var wavh =
    //   //     wavHeader(sampleRate: 8000, channels: 1, fileSize: sendData.length);
    //   socket.add(header + sendData);
    //   // socket.add(utf8.encode("\r\n"));
    //   print('send2:${header + sendData}');
    //   await socket.flush();
    // }
    // print("****************************************************************");
  }
}
