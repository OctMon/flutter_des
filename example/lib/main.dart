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
  Uint8List _encryptData;
  String _decryptData;
  String _encryptHex = '';
  String _decryptHex = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      _encryptHex = await FlutterDes.encryptToHex(_string, _key, iv: _iv);
      _encryptData = await FlutterDes.encrypt(_string, _key, iv: _iv);
      _decryptHex = await FlutterDes.decryptFromHex(_encryptHex, _key, iv: _iv);
      _decryptData = await FlutterDes.decrypt(_encryptData, _key, iv: _iv);
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
                'string = $_string\nkey = $_key\niv = $_iv\nencryptData = $_encryptData\nencryptHex = $_encryptHex\ndecryptData = $_decryptData\ndecryptHex = $_decryptHex'),
          ),
        ),
      ),
    );
  }
}
