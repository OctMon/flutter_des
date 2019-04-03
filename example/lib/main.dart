import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
  String _encrypt = '';
  String _decrypt = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      _encrypt = await FlutterDes.encryptToHex(_string, _key, iv: _iv);
      _decrypt = await FlutterDes.decryptFromHex(_encrypt, _key, iv: _iv);
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
                'string = $_string\nkey = $_key\niv = $_iv\nencrypt = $_encrypt\ndecrypt = $_decrypt'),
          ),
        ),
      ),
    );
  }
}
