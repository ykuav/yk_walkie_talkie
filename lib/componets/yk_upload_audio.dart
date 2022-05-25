import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yk_walkie_talkie/protocol/shout_protocol.dart';

class YkUploadAudio extends StatefulWidget {
  const YkUploadAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YkUploadAudioState();
}

class _YkUploadAudioState extends State<YkUploadAudio> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("请选择文件"),
              ElevatedButton(
                onPressed: () {},
                child: const Text("选择文件"),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("上传"),
          ),
        ],
      ),
    );
  }
}
