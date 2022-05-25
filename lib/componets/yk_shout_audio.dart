import 'package:flutter/material.dart';

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

  String sizeText(double sizek) {
    if (sizek >= 1024) {
      return "${(sizek / 1024).toStringAsFixed(2)} MB";
    }
    return "$sizek KB";
  }

  Widget audioItem(int index, String name, double size) {
    return GestureDetector(
      onTap: () {
        if (isDelModel) {
          selectedList.add(index);
        } else {
          selectedList = [index];
        }
        setState(() {});
      },
      child: Row(
        children: [
          Checkbox(
              value: selectedList.contains(index),
              onChanged: (selected) {
                if (isDelModel) {
                  selectedList.add(index);
                } else {
                  selectedList = [index];
                }
                setState(() {});
              }),
          Expanded(
              child: Text(
            name,
            overflow: TextOverflow.ellipsis,
          )),
          Expanded(child: Text(sizeText(size)))
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
              children: [
                audioItem(0, "录音1", 1024),
                audioItem(1, "录音2录音2录音2录音2录音2录音2录音2录音2录音2录音2录音2录音2", 23334),
                audioItem(2, "录音3", 33302),
                audioItem(3, "录音4", 31234),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
                audioItem(4, "录音5", 128),
              ],
            ),
            flex: 12,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("播放"),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text("上传"),
                  ),
                ))
              ],
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
