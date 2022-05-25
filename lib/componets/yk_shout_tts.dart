import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yk_walkie_talkie/protocol/shout_protocol.dart';

class YkShoutTTS extends StatefulWidget {
  const YkShoutTTS({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YkShoutTTSState();
}

class _YkShoutTTSState extends State<YkShoutTTS> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  bool loopPlay = false;
  bool loopPlaying = false;
  TextEditingController ttsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: ttsController,
                  focusNode: focusNode,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: '请输入内容',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '请输入内容';
                    }
                    return null;
                  },
                  maxLines: 10,
                  minLines: 5,
                ),
                CheckboxListTile(
                  title: const Text("循环播放"),
                  value: loopPlay,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (val) {
                    setState(() {
                      loopPlay = val ?? false;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () {
                      if (loopPlaying) {
                        ShoutProtocol.sendBytes(utf8.encode("[17]"));
                        setState(() {
                          loopPlaying = false;
                        });
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        var text = ttsController.value.text;
                        if (loopPlay) {
                          ShoutProtocol.sendBytes(utf8.encode("[16]$text"));
                          setState(() {
                            loopPlaying = true;
                          });
                        } else {
                          ShoutProtocol.sendBytes(utf8.encode("[15]$text"));
                        }
                      }
                    },
                    child: Text(loopPlaying ? '停止播放' : '播放'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
