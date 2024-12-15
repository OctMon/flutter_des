import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_des_platform_interface.dart';

const String _iv = '01234567';

/// An implementation of [FlutterDesPlatform] that uses method channels.
class MethodChannelFlutterDes extends FlutterDesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_des');

  @override
  Future<Uint8List?> encrypt(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return null;
    }
    final Uint8List? crypt =
        await methodChannel.invokeMethod('encrypt', [string, key, iv]);
    return crypt;
  }

  @override
  Future<String?> encryptToHex(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return '';
    }
    final String? crypt =
        await methodChannel.invokeMethod('encryptToHex', [string, key, iv]);
    return crypt;
  }

  @override
  Future<String> encryptToBase64(String string, String key,
      {String iv = _iv}) async {
    if (string.isEmpty) {
      return '';
    }
    final String crypt = base64Encode(
        await (encrypt(string, key, iv: iv)) ?? Uint8List.fromList([]));
    return crypt;
  }

  @override
  Future<String?> decrypt(Uint8List data, String key, {String iv = _iv}) async {
    final String? crypt =
        await methodChannel.invokeMethod('decrypt', [data, key, iv]);
    return crypt;
  }

  @override
  Future<String?> decryptFromHex(String? hex, String key,
      {String iv = _iv}) async {
    final String? crypt =
        await methodChannel.invokeMethod('decryptFromHex', [hex, key, iv]);
    return crypt;
  }

  @override
  Future<String?> decryptFromBase64(String base64, String key,
      {String iv = _iv}) async {
    final String? crypt = await decrypt(base64Decode(base64), key, iv: iv);
    return crypt;
  }
}
