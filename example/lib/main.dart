import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_des/flutter_des.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _string =
      "Java, android, ios, get the same result by DES encryption and decryption.";
  final _key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
  final _iv = "12345678";
  Uint8List _encrypt;
  String _decrypt;
  String _encryptHex = '';
  String _decryptHex = '';
  String _encryptBase64 = '';
  String _decryptBase64 = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      _encrypt = await FlutterDes.encrypt(_string, _key, iv: _iv);
      _decrypt = await FlutterDes.decrypt(_encrypt, _key, iv: _iv);
      _encryptHex = await FlutterDes.encryptToHex(_string, _key, iv: _iv);
      _decryptHex = await FlutterDes.decryptFromHex(_encryptHex, _key, iv: _iv);
      _encryptBase64 = await FlutterDes.encryptToBase64(_string, _key, iv: _iv);
      _decryptBase64 =
          await FlutterDes.decryptFromBase64(_encryptBase64, _key, iv: _iv);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DES example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text(
                'string = $_string\nkey = $_key\niv = $_iv\nencrypt = $_encrypt\nencryptToHex = $_encryptHex\nencryptToBase64 = $_encryptBase64\ndecrypt = $_decrypt\ndecryptFromHex = $_decryptHex\ndecryptFromBase64 = $_decryptBase64'),
          ),
        ),
      ),
    );
  }
}
