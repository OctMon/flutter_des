import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_des_method_channel.dart';

const String _iv = '01234567';

abstract class FlutterDesPlatform extends PlatformInterface {
  /// Constructs a FlutterDesPlatform.
  FlutterDesPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDesPlatform _instance = MethodChannelFlutterDes();

  /// The default instance of [FlutterDesPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDes].
  static FlutterDesPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDesPlatform] when
  /// they register themselves.
  static set instance(FlutterDesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Uint8List?> encrypt(String string, String key,
      {String iv = _iv}) async {
    throw UnimplementedError('encrypt() has not been implemented.');
  }

  Future<String?> encryptToHex(String string, String key,
      {String iv = _iv}) async {
    throw UnimplementedError('encryptToHex() has not been implemented.');
  }

  Future<String> encryptToBase64(String string, String key,
      {String iv = _iv}) async {
    throw UnimplementedError('encryptToBase64() has not been implemented.');
  }

  Future<String?> decrypt(Uint8List data, String key, {String iv = _iv}) async {
    throw UnimplementedError('decrypt() has not been implemented.');
  }

  Future<String?> decryptFromHex(String? hex, String key,
      {String iv = _iv}) async {
    throw UnimplementedError('decryptFromHex() has not been implemented.');
  }

  Future<String?> decryptFromBase64(String base64, String key,
      {String iv = _iv}) async {
    throw UnimplementedError('decryptFromBase64() has not been implemented.');
  }
}
