import 'package:flutter/material.dart';

class YkShoutRealTime extends StatefulWidget {
  const YkShoutRealTime({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YkShoutRealTimeState();
}

class _YkShoutRealTimeState extends State<YkShoutRealTime> {
  double _sliderValue = 100;

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
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text("开始喊话"))
        ],
      ),
    );
  }
}
