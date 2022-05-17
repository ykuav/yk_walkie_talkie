import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:yk_walkie_talkie/protocol/shout_protocol.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';


class YkShoutRealTime extends StatefulWidget {
  const YkShoutRealTime({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YkShoutRealTimeState();
}

class _YkShoutRealTimeState extends State<YkShoutRealTime> {
  double _sliderValue = 100;
  final FlutterSoundPlayer? _mPlayer =
      FlutterSoundPlayer(logLevel: Level.warning);
  final FlutterSoundRecorder? _mRecorder =
      FlutterSoundRecorder(logLevel: Level.warning);
  var _mRecorderIsInited = false;
  var _mPlayerIsInited = false;
  bool _mplaybackReady = false;
  StreamSubscription? _mRecordingDataSubscription;
  var isReacrd = false;

  @override
  void initState() {
    super.initState();
    // Be careful : openAudioSession return a Future.
    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
  }

  Future<void> _openRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _mRecorder!.openRecorder();
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    setState(() {
      _mRecorderIsInited = true;
    });
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    if (_mRecordingDataSubscription != null) {
      await _mRecordingDataSubscription!.cancel();
      _mRecordingDataSubscription = null;
    }
    _mplaybackReady = true;
  }

  Future<void> record() async {
    await _openRecorder();

    assert(_mRecorderIsInited);
    // var sink = await createFile();
    var recordingDataController = StreamController<Food>();
    _mRecordingDataSubscription =
        recordingDataController.stream.listen((buffer) {
      if (buffer is FoodData) {
        ShoutProtocol.realTimeShout(buffer.data!);
      }
    });

    await _mRecorder!.startRecorder(
      toStream: recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: 8000,
      audioSource: AudioSource.microphone,
      bitRate: 8000
    );
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
                if (isReacrd) {
                  setState(() {
                    isReacrd = false;
                  });
                  stopRecorder();
                } else {
                  setState(() {
                    isReacrd = true;
                  });
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
