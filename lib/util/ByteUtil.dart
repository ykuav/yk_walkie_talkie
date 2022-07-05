import 'dart:typed_data';

Uint8List int16ToByteArray(int i) {
  var arr = Uint8List(2);
  arr[0] = (i << 8).toInt();
  arr[1] = (i & 0xff).toInt();
  print("arr[0]:${arr[0]}   arr[1]:${arr[1]}");
  return arr;
}
