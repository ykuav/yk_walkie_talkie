import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:opus_flutter/opus_flutter.dart' as opus_flutter;
import 'package:opus_dart/opus_dart.dart';

const int wavHeaderSize = 44;

Uint8List wavHeader(
    {required int sampleRate, required int channels, required int fileSize}) {
  const int sampleBits = 16; //We know this since we used opus
  const Endian endian = Endian.little;
  final int frameSize = ((sampleBits + 7) ~/ 8) * channels;
  ByteData data = new ByteData(wavHeaderSize);
  data.setUint32(4, fileSize - 4, endian);
  data.setUint32(16, 16, endian);
  data.setUint16(20, 1, endian);
  data.setUint16(22, channels, endian);
  data.setUint32(24, sampleRate, endian);
  data.setUint32(28, sampleRate * frameSize, endian);
  data.setUint16(30, frameSize, endian);
  data.setUint16(34, sampleBits, endian);
  data.setUint32(40, fileSize - 44, endian);
  Uint8List bytes = data.buffer.asUint8List();
  bytes.setAll(0, ascii.encode('RIFF'));
  bytes.setAll(8, ascii.encode('WAVE'));
  bytes.setAll(12, ascii.encode('fmt '));
  bytes.setAll(36, ascii.encode('data'));
  return bytes;
}

/// This is mostly the same example as from the opus_dart package:
/// Get a stream, encode it and decode it, then share it.
/// Add a wav header, so it can be played by any sound app.
Future<Uint8List> encode(Uint8List input) async {
  const int sampleRate = 8000;
  const int channels = 1;
  print("input.len:${input.length} input:$input");
  //Encode and decode using opus
  var opusEncoder = SimpleOpusEncoder(
    sampleRate: sampleRate,
    channels: channels,
    application: Application.audio,
  );

  Uint8List result = opusEncoder.encode(
      input: Int16List.fromList(input), maxOutputSizeBytes: input.length ~/ 8);
  print("result.size:${result.length} result:$result");
  return result;
}
