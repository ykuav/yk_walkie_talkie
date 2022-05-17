import 'package:flutter/material.dart';
import 'package:opus_dart/opus_dart.dart';
import 'package:yk_walkie_talkie/componets/yk_devices.dart';
import 'package:yk_walkie_talkie/componets/yk_home.dart';
import 'package:yk_walkie_talkie/pages/device_megaphone_detail.dart';
import 'package:yk_walkie_talkie/pages/login.dart';
import 'package:yk_walkie_talkie/protocol/shout_protocol.dart';
import 'package:opus_flutter/opus_flutter.dart' as opus_flutter;

import 'componets/yk_account.dart';

Future<void> main() async {
  initOpus(await opus_flutter.load());
  ShoutProtocol.connect().then((value) => ShoutProtocol.appReg());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '易酷app',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: '易酷app'),
      routes: {
        // '/': (context) => const MyHomePage(
        //       title: '易酷app',
        //     ),
        '/login': (context) => const YkLoginPage(),
        '/device_megaphone_detail': (context) =>
            const DeviceMegaphoneDetailPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  int selectedIndex = 0;

  // Widget showWidget

  Widget getSelectedWidght() {
    if (selectedIndex == 0) {
      return const YkDevices();
    }
    if (selectedIndex == 1) {
      return const YkAccount();
    }
    return const YkDevices();
  }

  Widget? getFloatingActionButton() {
    if (selectedIndex == 0) {
      return FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '添加设备',
        child: const Icon(Icons.add),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: null,
      body: getSelectedWidght(),
      floatingActionButton: getFloatingActionButton(),
      bottomNavigationBar: BottomNavigationBar(
        /// 这个很重要
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   label: "首页",
          //   icon: Icon(Icons.home),
          // ),
          BottomNavigationBarItem(
            label: "设备",
            icon: Icon(Icons.device_hub),
          ),
          BottomNavigationBarItem(
            label: "我的",
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
