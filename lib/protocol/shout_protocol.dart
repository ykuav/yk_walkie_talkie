import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:yk_walkie_talkie/util/ByteUtil.dart';
import 'package:yk_walkie_talkie/util/api.dart';

late Socket socket;

class ShoutProtocol {
  // static const ip = "10.10.62.14";
  static const ip = "103.85.84.51";
  static const port = 9921;
  static var selectPayload = "";
  static const channel = MethodChannel("abc");
  static Function? callback;

  static Future<void> connect() async {
    socket = await Socket.connect(ip, port);
    socket.encoding = Encoding.getByName("utf-8")!;
    socket.listen((event) {
      var data = utf8.decode(event);
      if (data.substring(0, 3) == "GAF" && callback != null) {
        callback!(data.substring(3).split("|")[1]);
      }
    });
    // socket.
  }

  static Future<void> send(Object obj) async {
    // print('send msg:$obj');
    socket.write(obj);
    await socket.flush();
  }

  static Future<void> sendBytes1(List<int> obj) async {
    // print('send msg:$obj');
    print("send len:${obj.length}");
    socket.add(obj);
    await socket.flush();
  }

  static Future<void> sendBytes(List<int> bytes) async {
    socket.add(bytes);
    await socket.flush();
  }

  static void appReg() async {
    var token = await getToken();
    send("[25]${token}\r\n");
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

  static Future<void> getRecord(Function callback) async {
    ShoutProtocol.callback = callback;
    var token = await getToken();
    send("[22]$token\r\n");
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
    log("data.size1:${data.length}");
    print("=================================================================");
    // var header = utf8.encode();
    // var udata = String.fromCharCodes(Uint8List.fromList(header));
    await send(
        "[20]${utf8.decode(int16ToByteArray(utf8.encode(filename).length))}$filename\r\n");
    sleep(const Duration(milliseconds: 10));
    int i = 0;
    while (data.length >= i + 1020) {
      // print("package num:$i");
      List<int> sendData = utf8.encode("[21]");
      sendData += data.buffer.asUint8List(i, 1020);
      // sendData += utf8.encode("\r\n");
      await sendBytes1(sendData);
      i += 1020;
      callback(i.toDouble());
      sleep(const Duration(milliseconds: 100));
    }
    if (i < data.length) {
      var udata = utf8.encode("[21]") +
          data.buffer.asUint8List(i) +
          utf8.encode("\r\n");
      await sendBytes1(udata);
      sleep(const Duration(milliseconds: 80));
      callback((-1).toDouble());
    }
  }

  static Future<void> playAudio(String filename, int isLoop) async {
    await send("[12]$isLoop$filename");
  }

  static Future<void> stopAudio() async {
    await send("[13]");
  }

  static Future<void> delAudio(String filename) async {
    await send("[23]$filename");
  }
}
