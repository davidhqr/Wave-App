import 'package:flutter/material.dart';

class SendFilePage extends StatefulWidget {
  SendFilePage({Key key, this.title}) : super(key: key);

  final String title;
  bool offlineMode = false;

  @override
  _SendFilePageState createState() => _SendFilePageState();
}

class _SendFilePageState extends State<SendFilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
