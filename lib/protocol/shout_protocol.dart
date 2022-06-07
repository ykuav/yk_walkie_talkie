import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:developer';
import 'package:flutter/services.dart';

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
  }

  static Future<void> uploadFile(
      String filename, Uint8List data, Function callback) async {
    print("=================================================================");
    var header = utf8.encode("[20]${filename.length}$filename");
    socket.add(header);
    await socket.flush();
    int i = 0;
    while (data.length <= i + 1020) {
      socket.add(utf8.encode("[21]") + data.buffer.asUint8List(i, 1020));
      await socket.flush();
      i += 1020;
      callback(i);
    }
    if (i < data.length) {
      socket.add(utf8.encode("[21]") + data.buffer.asUint8List(i));
      await socket.flush();
      callback(-1);
    }
  }
}
