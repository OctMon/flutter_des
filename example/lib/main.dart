import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_des/flutter_des.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

const _string =
    "Java, Android, iOS, macOS, get the same result by DES encryption and decryption.";

class _MyAppState extends State<MyApp> {
  static const _key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
  static const _iv = "12345678";
  final _controller = TextEditingController();
  Uint8List? _encrypt;
  String? _decrypt = '';
  String? _encryptHex = '';
  String? _decryptHex = '';
  String _encryptBase64 = '';
  String? _decryptBase64 = '';
  String _text = _string;

  @override
  void initState() {
    super.initState();

    crypt();

    _controller.addListener(() {
      _text = _controller.text;
      crypt();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> crypt() async {
    if (_text.isEmpty) {
      _text = _string;
    }
    try {
      _encrypt = await FlutterDes.encrypt(_text, _key, iv: _iv);
      _decrypt = await FlutterDes.decrypt(
          _encrypt ?? Uint8List.fromList([]), _key,
          iv: _iv);
      _encryptHex = await FlutterDes.encryptToHex(_text, _key, iv: _iv);
      _decryptHex = await FlutterDes.decryptFromHex(_encryptHex, _key, iv: _iv);
      _encryptBase64 = await FlutterDes.encryptToBase64(_text, _key, iv: _iv);
      _decryptBase64 =
          await FlutterDes.decryptFromBase64(_encryptBase64, _key, iv: _iv);
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: const InputDecoration(
              labelText: _string,
            ),
            controller: _controller,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                const Chip(
                  labelPadding: EdgeInsets.all(5),
                  avatar: CircleAvatar(
                    child: Text('key'),
                  ),
                  label: Text(_key),
                ),
                const Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text('iv'),
                  ),
                  label: Text(_iv),
                ),
                const Divider(),
                _build('Data', _encrypt?.toString() ?? '', _decrypt ?? ''),
                const Divider(),
                _build('Hex', _encryptHex ?? '', _decryptHex ?? ''),
                const Divider(),
                _build('Base64', _encryptBase64, _decryptBase64 ?? ''),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _build(String tag, String string, String result) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: 60,
            padding: const EdgeInsets.all(3.0),
            color: Colors.grey.shade800,
            child: Text(
              tag,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                string,
                softWrap: true,
                maxLines: 100,
              ),
              const Divider(),
              Text(
                result,
                softWrap: true,
                maxLines: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
