// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter/foundation.dart';
import 'package:flutter_des/flutter_des.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const kText =
      'Java, Android, iOS, macOS, get the same result by DES encryption and decryption.';
  const kKey = 'u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX';
  const kIV = "12345678";
  const kEncryptHex =
      '1BB1ECAA9F1BE8062740DD5EA56AB99E13D244B3F2BD4907C89D5AA79F3E9EC124295662B2FA1BE5C0F0AE7B3722217D335C839C7574EC5A573F75A75816082E878FAC50CBCA89E5380C27F5FBFE3429F63709BA7A134578';
  const kEncryptBase64 =
      'G7Hsqp8b6AYnQN1epWq5nhPSRLPyvUkHyJ1ap58+nsEkKVZisvob5cDwrns3IiF9M1yDnHV07FpXP3WnWBYILoePrFDLyonlOAwn9fv+NCn2Nwm6ehNFeA==';

  testWidgets('encryptToHex test', (WidgetTester tester) async {
    final encrypt = await FlutterDes.encryptToHex(kText, kKey, iv: kIV);
    debugPrint("encryptToHex: $encrypt");
    expect(encrypt, kEncryptHex);
  });

  testWidgets('encryptToBase64 test', (WidgetTester tester) async {
    final encrypt = await FlutterDes.encryptToBase64(kText, kKey, iv: kIV);
    debugPrint("encryptToBase64: $encrypt");
    expect(encrypt, kEncryptBase64);
  });

  testWidgets('decryptFromHex test', (WidgetTester tester) async {
    final decrypt = await FlutterDes.decryptFromHex(kEncryptHex, kKey, iv: kIV);
    debugPrint("decryptFromHex: $decrypt");
    expect(decrypt, kText);
  });

  testWidgets('decryptFromBase64 test', (WidgetTester tester) async {
    final decrypt =
        await FlutterDes.decryptFromBase64(kEncryptBase64, kKey, iv: kIV);
    debugPrint("decryptFromBase64: $decrypt");
    expect(decrypt, kText);
  });
}
