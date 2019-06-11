import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_des/flutter_des.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

const _string =
    "Java, android, ios, get the same result by DES encryption and decryption.";

class _MyAppState extends State<MyApp> {
  static const _key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
  static const _iv = "12345678";
  TextEditingController _controller = TextEditingController();
  Uint8List _encrypt;
  String _decrypt = '';
  String _encryptHex = '';
  String _decryptHex = '';
  String _encryptBase64 = '';
  String _decryptBase64 = '';
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
      _decrypt = await FlutterDes.decrypt(_encrypt, _key, iv: _iv);
      _encryptHex = await FlutterDes.encryptToHex(_text, _key, iv: _iv);
      _decryptHex = await FlutterDes.decryptFromHex(_encryptHex, _key, iv: _iv);
      _encryptBase64 = await FlutterDes.encryptToBase64(_text, _key, iv: _iv);
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
          title: TextField(
            decoration: InputDecoration(
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
                Chip(
                  labelPadding: EdgeInsets.all(5),
                  avatar: CircleAvatar(
                    child: Text('key'),
                  ),
                  label: Text(_key),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text('iv'),
                  ),
                  label: Text(_iv),
                ),
                Divider(),
                _build('Data', _encrypt == null ? '' : _encrypt.toString(), _decrypt == null ? '' : _decrypt),
                Divider(),
                _build('Hex', _encryptHex, _decryptHex == null ? '' : _decryptHex),
                Divider(),
                _build('Base64', _encryptBase64, _decryptBase64 == null ? '' : _decryptBase64),
                Divider(),
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
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
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
              Divider(),
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
