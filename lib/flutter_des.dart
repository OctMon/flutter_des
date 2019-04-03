import 'dart:async';

import 'package:flutter/services.dart';

class FlutterDes {
  static const MethodChannel _channel = const MethodChannel('flutter_des');

  static Future<String> encryptToHex(String string, String key,
      {String iv = '01234567'}) async {
    final String crypt =
        await _channel.invokeMethod('encrypt', [string, key, iv]);
    return crypt;
  }

  static Future<String> decryptFromHex(String hex, String key,
      {String iv = '01234567'}) async {
    final String crypt =
        await _channel.invokeMethod('decrypt', [hex, key, iv]);
    return crypt;
  }
}
