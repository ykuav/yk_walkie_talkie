import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toast/toast.dart';
import 'package:yk_walkie_talkie/util/shared_preferences.dart';

import 'ErrorEntity.dart';

// const baseUrl = 'http://10.10.62.7:9981/';
const baseUrl = 'http://103.85.84.51:9981/';

Future getToken() async {
  print("getToken.......:${await PersistentStorage().getStorage("token")}");
  return await PersistentStorage().getStorage("token");
}

Future<Map<String, dynamic>> post(
  url,
  data, {
  Map<String, dynamic>? headers,
  bool resultStr = false,
  bool isForm = false,
  Function? processingData,
  String contentType = "application/x-www-form-urlencoded",
}) async {
  headers = headers ?? <String, dynamic>{};
  headers["versionType"] = 1;
  headers["user-agent"] = "erpPhone";
  headers["access-token"] = await getToken();
  BaseOptions options =
      BaseOptions(method: 'post', contentType: contentType, headers: headers);
  Dio dio = Dio(options);
  print("header:${headers}");
  if (isForm) {
    data = FormData.fromMap(data);
  }
  Response resp;
  resp = await dio.post(
    url,
    data: data,
  );
  Map<String, dynamic> respMap =
      resp.data is String ? json.decode(resp.data) : resp.data;
  print("url: $url \n请求返回代号:${respMap['code']}\n请求参数:$data \n请求结果:$resp");
  if (respMap['code'] == -20006 || respMap['code'] == 10003) {
    // // token失效退出登录.
    // eventBus.fire(UserQuitEvent());
    PersistentStorage().removeStorage("token");

    print("token 失效");
  }
  if (respMap['code'] != 0) {
    showToast(respMap['msg']);
    throw Exception(respMap['msg']);
  }
  return respMap["data"];
}

Future<Object> get(
  String url, {
  data,
  required Map<String, dynamic> headers,
  required bool resultStr,
}) async {
  headers = headers;
  headers["versionType"] = 1;
  headers["pid"] = 2;
  headers["user-agent"] = "erpPhone";
  BaseOptions options = BaseOptions(method: 'get', headers: headers);
  Dio dio = Dio(options);

  Response resp;
  resp = await dio.get(
    url,
    queryParameters: data,
  );

  print("url: $url\n请求参数:$data \n请求结果:$resp");
  Map<String, dynamic> respMap =
      resp.data is String ? json.decode(resp.data) : resp.data;
  print("url: $url \n请求返回代号:${respMap['code']}\n请求参数:$data \n请求结果:$resp");

  if (resultStr) {
    return respMap;
  }

  if (respMap['code'] != 0) {
    showToast(
      respMap['msg'],
      duration: const Duration(seconds: 3),
      position: ToastPosition.bottom,
    );
    throw Exception(respMap['msg']);
  }

  return respMap["data"] is String
      ? json.decode(respMap["data"])
      : respMap["data"];
}

Future<Object> postForm(
  url,
  formDate, {
  required Map<String, dynamic> headers,
  resultStr,
}) async {
  headers = headers;
  headers["versionType"] = 1;
  headers["pid"] = 2;
  headers["user-agent"] = "erpPhone";
  headers["token"] = await getToken();
  BaseOptions options = BaseOptions(method: 'post', headers: headers);
  Dio dio = new Dio(options);
  Response resp;
  resp = await dio.post(url, data: formDate);

  Map<String, dynamic> respMap =
      resp.data is String ? json.decode(resp.data) : resp.data;
  print("url: $url \n请求返回代号:${respMap['code']}\n请求参数:$formDate \n请求结果:$resp");

  if (respMap['code'] != 0) {
    Toast.show(respMap['msg']);
    throw Exception(respMap['msg']);
  }
  if (resultStr) {
    return respMap["data"];
  }
  try {
    return respMap["data"] is String
        ? json.decode(respMap["data"])
        : respMap["data"];
  } catch (e) {
    return respMap["data"];
  }
  ;
}

Future<List<dynamic>> postResultList(
  url,
  formDate, {
  required Map<String, dynamic> headers,
  resultStr,
}) async {
  headers = headers;
  headers["versionType"] = 1;
  headers["access-token"] = await getToken();

  BaseOptions options = BaseOptions(
      method: 'post',
      contentType: "application/x-www-form-urlencoded",
      headers: headers);
  Dio dio = Dio(options);
  Response resp;
  resp = await dio.post(url, data: formDate);
  List<dynamic> resultList = resp.data["data"];
  print("url: $url\n请求参数:$formDate \n请求结果:$resp");
  return resultList;
}
