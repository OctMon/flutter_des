[![Pub](https://img.shields.io/pub/v/flutter_des.svg)](https://pub.dartlang.org/packages/flutter_des)
[![support](https://img.shields.io/badge/platform-flutter-ff69b4.svg)](https://github.com/OctMon/flutter_des)
[![build](https://github.com/OctMon/flutter_des/workflows/build/badge.svg)](https://github.com/OctMon/flutter_des/actions)

# flutter_des

Java, Android, iOS, macOS, get the same result by DES encryption and decryption.

<div >
  <p>
    <img src="https://github.com/OctMon/flutter_des/blob/assets/android.png?raw=true" width = 37% />
    <img src="https://github.com/OctMon/flutter_des/blob/assets/ios.png?raw=true" width = 30.5% />
  </>
  <p>
    <img src="https://github.com/OctMon/flutter_des/blob/assets/macos.jpg?raw=true" width = 70.5% />
  </>
</div>

DES 
Algorithm: CBC
Operation: (android)PKCS5Padding (ios)kCCOptionPKCS7Padding
http://tool.chacuo.net/cryptdes

## Getting Started

### Add dependency

```yaml
dependencies:
  flutter_des: #latest version
```

### Example

```dart
import 'package:flutter_des/flutter_des.dart';

void example() async {
  const string = "Java, Android, iOS, macOS, get the same result by DES encryption and decryption.";
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
