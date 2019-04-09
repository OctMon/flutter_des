[![build status](https://img.shields.io/travis/OctMon/flutter_des/vm.svg?style=flat-square)](https://travis-ci.org/OctMon/flutter_des)
[![Pub](https://img.shields.io/pub/v/flutter_des.svg?style=flat-square)](https://pub.dartlang.org/packages/flutter_des)
[![support](https://img.shields.io/badge/platform-flutter-ff69b4.svg?style=flat-square)](https://github.com/OctMon/flutter_des)

# flutter_des

Java, android, ios, get the same result by DES encryption and decryption.

<div align="center">
  <p>
    <img src="https://github.com/OctMon/flutter_des/blob/assets/android.png" width = 30% height = 30% />
    <img src="https://github.com/OctMon/flutter_des/blob/assets/ios.png" width = 30% height = 30% />
  </>
</div>

## Getting Started

### Add dependency

```yaml
dependencies:
  dio: 1.0.0  #latest version
```

### Example

```dart
import 'package:flutter_des/flutter_des.dart';

void example() async {
  const string = "Java, android, ios, get the same result by DES encryption and decryption.";
  const key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
  const iv = "12345678";

  var encrypt = await FlutterDes.encrypt(string, key, iv: iv);
  var decrypt = await FlutterDes.decrypt(encrypt, key, iv: iv);
  var encryptHex = await FlutterDes.encryptToHex(string, key, iv: iv);
  var decryptHex = await FlutterDes.decryptFromHex(encryptHex, key, iv: iv);
  var encryptBase64 = await FlutterDes.encryptToBase64(string, key, iv: iv);
  var decryptBase64 = await FlutterDes.decryptFromBase64(encryptBase64, key, iv: iv);
}
```
