import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'flutter_des_platform_interface.dart';

const String _iv = '01234567';

class FlutterDes {
  static Future<Uint8List?> encrypt(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return null;
    }
    final Uint8List? crypt =
        await FlutterDesPlatform.instance.encrypt(string, key, iv: iv);
    return crypt;
  }

  static Future<String?> encryptToHex(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return '';
    }
    final String? crypt =
        await FlutterDesPlatform.instance.encryptToHex(string, key, iv: iv);
    return crypt;
  }

  static Future<String> encryptToBase64(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return '';
    }
    final String crypt = base64Encode(
        await (encrypt(string, key, iv: iv)) ?? Uint8List.fromList([]));
    return crypt;
  }

  static Future<String?> decrypt(Uint8List data, String key,
      {String iv = _iv}) async {
    final String? crypt =
        await FlutterDesPlatform.instance.decrypt(data, key, iv: iv);
    return crypt;
  }

  static Future<String?> decryptFromHex(String? hex, String key,
      {String iv = _iv}) async {
    final String? crypt =
        await FlutterDesPlatform.instance.decryptFromHex(hex, key, iv: iv);
    return crypt;
  }

  static Future<String?> decryptFromBase64(String base64, String key,
      {String iv = _iv}) async {
    final String? crypt = await decrypt(base64Decode(base64), key, iv: iv);
    return crypt;
  }
}
