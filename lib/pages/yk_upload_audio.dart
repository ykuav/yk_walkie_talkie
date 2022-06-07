import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yk_walkie_talkie/protocol/shout_protocol.dart';
import 'package:toast/toast.dart';

class YkUploadAudio extends StatefulWidget {
  const YkUploadAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _YkUploadAudioState();
}

class _YkUploadAudioState extends State<YkUploadAudio> {
  String filename = "请选择文件";
  late File file;
  bool uploading = false;
  double uploadProgress = 0.0;

  void uploadFile(String filename, Uint8List data) {
    ShoutProtocol.uploadFile(filename, data, (i) {
      if (i == -1) {
        setState(() {
          uploading = false;
        });
        Toast.show("上传完成", duration: Toast.lengthShort, gravity: Toast.bottom);
        return;
      }
      setState(() {
        uploadProgress = i;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // shadowColor: Colors.red,
        foregroundColor: Theme.of(context).primaryColor,
        title: const Text("上传文件"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(filename),
                  flex: 1,
                ),
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            withData: true,
                            type: FileType.custom,
                            allowedExtensions: ['mp3', 'wav', 'aac', 'm4a']);
                    if (result != null) {
                      setState(() {
                        file = File(result.files.first.path!);
                        filename = result.files.first.name;
                      });
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: const Text("选择文件"),
                ),
              ],
            ),
            uploading
                ? CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                    value: uploadProgress,
                  )
                : Container(),
            ElevatedButton(
              onPressed: () {
                final completer = Completer<Uint8List>();

                log("开始上传文件");
                log("filename:$filename");
                file.readAsBytes().then((value) {
                  log("value:$value");
                  completer.complete(value);
                });
                setState(() {
                  uploading = true;
                  uploadProgress = 0.0;
                });
                completer.future.then((Uint8List data) {
                  log("readAsBytes:$data");
                  uploadFile(filename, data);
                });
              },
              child: const Text("上传"),
            ),
          ],
        ),
      ),
    );
  }
}
