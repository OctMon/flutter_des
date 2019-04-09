import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/services.dart';

const String _iv = '01234567';

class FlutterDes {
  static const MethodChannel _channel = const MethodChannel('flutter_des');

  static Future<Uint8List> encrypt(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return null;
    }
    final Uint8List crypt =
        await _channel.invokeMethod('encrypt', [string, key, iv]);
    return crypt;
  }

  static Future<String> encryptToHex(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return '';
    }
    final String crypt =
        await _channel.invokeMethod('encryptToHex', [string, key, iv]);
    return crypt;
  }

  static Future<String> encryptToBase64(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return '';
    }
    final String crypt = base64Encode(await encrypt(string, key, iv: iv));
    return crypt;
  }

  static Future<String> decrypt(Uint8List data, String key,
      {String iv = _iv}) async {
    final String crypt =
        await _channel.invokeMethod('decrypt', [data, key, iv]);
    return crypt;
  }

  static Future<String> decryptFromHex(String hex, String key,
      {String iv = _iv}) async {
    final String crypt =
        await _channel.invokeMethod('decryptFromHex', [hex, key, iv]);
    return crypt;
  }

  static Future<String> decryptFromBase64(String base64, String key,
      {String iv = _iv}) async {
    final String crypt = await decrypt(base64Decode(base64), key, iv: iv);
    return crypt;
  }
}
