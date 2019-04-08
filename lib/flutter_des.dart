import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class FlutterDes {
  static const MethodChannel _channel = const MethodChannel('flutter_des');

  static Future<Uint8List> encrypt(String string, String key,
      {String iv = '01234567'}) async {
    if (string.isEmpty) {
      return null;
    }
    final Uint8List crypt =
        await _channel.invokeMethod('encrypt', [string, key, iv]);
    return crypt;
  }

  static Future<String> encryptToHex(String string, String key,
      {String iv = '01234567'}) async {
    if (string.isEmpty) {
      return '';
    }
    final String crypt =
        await _channel.invokeMethod('encryptToHex', [string, key, iv]);
    return crypt;
  }

  static Future<String> decrypt(Uint8List data, String key,
      {String iv = '01234567'}) async {
    final String crypt =
    await _channel.invokeMethod('decrypt', [data, key, iv]);
    return crypt;
  }

  static Future<String> decryptFromHex(String hex, String key,
      {String iv = '01234567'}) async {
    final String crypt =
        await _channel.invokeMethod('decryptFromHex', [hex, key, iv]);
    return crypt;
  }
}
