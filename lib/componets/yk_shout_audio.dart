import 'package:flutter/material.dart';
import 'package:yk_walkie_talkie/protocol/shout_protocol.dart';

class YkShoutAudio extends StatefulWidget {
  const YkShoutAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YkShoutAudioState();
}

class _YkShoutAudioState extends State<YkShoutAudio> {
  final FocusNode focusNode = FocusNode();
  bool loopPlay = false;
  bool isDelModel = false; // 是否是删除模式，删除模式允许多选
  List<int> selectedList = [];
  List<String> audioFiles = [];
  ScrollController listViewController = ScrollController();
  List<String> selectFileName = [];

  @override
  void initState() {
    super.initState();
    ShoutProtocol.getRecord((String data) {
      print("data:${data}");
      var fs = data.split("\n");
      fs.remove(fs[fs.length - 1]);
      setState(() {
        audioFiles = fs;
      });
    });
  }

  String sizeText(double sizek) {
    if (sizek >= 1024) {
      return "${(sizek / 1024).toStringAsFixed(2)} MB";
    }
    return "$sizek KB";
  }

  Widget audioItem(int index, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isDelModel) {
            selectedList.add(index);
          } else {
            selectedList = [index];
          }
          selectFileName = [name];
        });
      },
      child: Row(
        children: [
          Checkbox(
              value: selectedList.contains(index),
              onChanged: (selected) {
                print(selected);
              }),
          Expanded(
              child: Text(
            name,
            overflow: TextOverflow.ellipsis,
          )),
          // Expanded(child: Text(sizeText(size)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              controller: listViewController,
              children: audioFiles
                  .map((e) => audioItem(audioFiles.indexOf(e), e))
                  .toList(),
            ),
            flex: 12,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          print("selectFileName:$selectFileName");
                          if (selectFileName.length == 1 &&
                              selectFileName[0] != "") {
                            ShoutProtocol.playAudio(selectFileName[0], 0);
                          }
                        },
                        child: const Text("播放"),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              print("selectFileName:$selectFileName");
                              if (selectFileName.length == 1 &&
                                  selectFileName[0] != "") {
                                ShoutProtocol.playAudio(selectFileName[0], 1);
                              }
                            },
                            child: const Text("循环播放"),
                          ),
                        )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          ShoutProtocol.stopAudio();
                        },
                        child: const Text("停止播放"),
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectFileName.length == 1 &&
                              selectFileName[0] != "") {
                            ShoutProtocol.delAudio(selectFileName[0]);
                          }
                        },
                        child: const Text("删除"),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/upload_audio");
                        },
                        child: const Text("上传"),
                      ),
                    )),
                  ],
                )
              ],
            ),
            flex: 3,
          )
        ],
      ),
    );
  }
}
