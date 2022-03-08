import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yk_walkie_talkie/devices/device_management.dart';

import 'account/account.dart';

/// app类，管理全局变量和常用公共方法
class App {
  Account account = Account();
  DeviceManagement deviceManagement = DeviceManagement();

  Future<void> initAccount() async {
    var prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print("初始化账号管理...");
    }

    account.token = prefs.getString("access_token") ?? "";
  }
}
