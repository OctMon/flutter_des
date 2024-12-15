import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_des/flutter_des_platform_interface.dart';
import 'package:flutter_des/flutter_des_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String _iv = '01234567';

class MockFlutterDesPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDesPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> decrypt(Uint8List data, String key, {String iv = _iv}) {
    // TODO: implement decrypt
    throw UnimplementedError();
  }

  @override
  Future<String?> decryptFromBase64(String base64, String key,
      {String iv = _iv}) {
    // TODO: implement decryptFromBase64
    throw UnimplementedError();
  }

  @override
  Future<String?> decryptFromHex(String? hex, String key, {String iv = _iv}) {
    // TODO: implement decryptFromHex
    throw UnimplementedError();
  }

  @override
  Future<Uint8List?> encrypt(String string, String key, {String iv = _iv}) {
    // TODO: implement encrypt
    throw UnimplementedError();
  }

  @override
  Future<String> encryptToBase64(String string, String key, {String iv = _iv}) {
    // TODO: implement encryptToBase64
    throw UnimplementedError();
  }

  @override
  Future<String?> encryptToHex(String string, String key, {String iv = _iv}) {
    // TODO: implement encryptToHex
    throw UnimplementedError();
  }
}

void main() {
  final FlutterDesPlatform initialPlatform = FlutterDesPlatform.instance;

  test('$MethodChannelFlutterDes is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDes>());
  });
}
