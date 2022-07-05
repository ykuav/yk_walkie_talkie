import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:yk_walkie_talkie/protocol/shout_protocol.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/shared_preferences.dart';

class YkShoutRealTime extends StatefulWidget {
  const YkShoutRealTime({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YkShoutRealTimeState();
}

class _YkShoutRealTimeState extends State<YkShoutRealTime> {
  double _sliderValue = 100;
  var isReacrd = false;
  Stream<Uint8List>? stream;
  StreamSubscription<List<int>>? listener;

  @override
  void initState() {
    super.initState();
    // PersistentStorage().getStorage("reacrd").then((value) => {
    //       if (value == 1)
    //         {
    //           setState(() {
    //             isReacrd = true;
    //           })
    //         }
    //     });
  }

  Future<void> stopRecorder() async {
    listener?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    stopRecorder();
  }

  Future<void> record() async {
// Init a new Stream
    var status = await Permission.microphone.request();
    MicStream.shouldRequestPermission(true);
    stream = await MicStream.microphone(
        audioSource: AudioSource.DEFAULT,
        sampleRate: 8000,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO,
        audioFormat: AudioFormat.ENCODING_PCM_16BIT);

// Start listening to the stream
    listener = stream!.listen((samples) {
      // log("samples:$samples");
      ShoutProtocol.realTimeShout(samples);
      sleep(const Duration(microseconds: 10));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 14, left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("音量调节"),
          Slider(
            value: _sliderValue,
            label: '$_sliderValue',
            min: 20,
            max: 100,
            // divisions: 4,
            onChanged: (v) {
              setState(() {
                _sliderValue = v;
              });
            },
            onChangeEnd: (v) {
              ShoutProtocol.setVolume(_sliderValue.toInt());
            },
          ),
          ElevatedButton(
              onPressed: () async {
                // var s = await PersistentStorage().getStorage("reacrd");
                // print("isReacrd:${s}");
                if (isReacrd) {
                  setState(() {
                    isReacrd = false;
                  });
                  // PersistentStorage().setStorage("reacrd", 0);
                  stopRecorder();
                } else {
                  setState(() {
                    isReacrd = true;
                  });
                  // PersistentStorage().setStorage("reacrd", 1);
                  record();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(isReacrd ? "停止喊话" : "开始喊话"))
        ],
      ),
    );
  }
}
