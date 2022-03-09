import 'package:flutter/material.dart';

import '../componets/yk_shout_audio.dart';
import '../componets/yk_shout_real_time.dart';
import '../componets/yk_shout_tts.dart';

class DeviceMegaphoneDetailPage extends StatefulWidget {
  const DeviceMegaphoneDetailPage({Key? key}) : super(key: key);

  @override
  State<DeviceMegaphoneDetailPage> createState() =>
      _DeviceMegaphoneDetailPageState();
}

class _DeviceMegaphoneDetailPageState extends State<DeviceMegaphoneDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // shadowColor: Colors.red,
        foregroundColor: Theme.of(context).primaryColor,
        title: const Text('喊话器'),
        bottom: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          labelColor: Theme.of(context).primaryColor,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.volume_up),
            ),
            Tab(
              icon: Icon(Icons.font_download_sharp),
            ),
            Tab(
              icon: Icon(Icons.audiotrack),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          YkShoutRealTime(),
          YkShoutTTS(),
          YkShoutAudio(),
        ],
      ),
    );
  }
}
