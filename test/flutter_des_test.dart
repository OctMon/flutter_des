import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_des/flutter_des.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_des');

  final _string =
      "Java, android, ios, get the same result by DES encryption and decryption.";
  final _key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
  final _iv = "12345678";

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      String string = methodCall.arguments[0];
      String key = methodCall.arguments[1];
      String iv = methodCall.arguments[2];
      switch (methodCall.method) {
        case 'encryptToHex':
          return '0A7233FC34EA762B933F41AA27A3614113A1AB6DD91515847526EE339B91A8F07B4C662CA613BC21778316C68B4517C946FB0DDAF16CB56BCD062877736A0FC18B8E65E9E09DC35D9B4727F4CEB33958';
        case 'decryptFromHex':
          return _string;
        default:
          return '';
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('crypt', () async {
    final encrypt = await FlutterDes.encryptToHex(_string, _key, iv: _iv);
    final decrypt = await FlutterDes.decryptFromHex(encrypt, _key, iv: _iv);
    expect(decrypt, _string);
  });
}
