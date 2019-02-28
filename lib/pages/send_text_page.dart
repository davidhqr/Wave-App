import 'package:flutter/material.dart';
import 'package:wave/wave_request.dart';
import 'package:logging/logging.dart';
import 'package:wave/utils.dart';

class SendTextPage extends StatefulWidget {
  SendTextPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SendTextPageState createState() {
    return _SendTextPageState();
  }
}

class _SendTextPageState extends State<SendTextPage> {
  TextEditingController textController = new TextEditingController();
  bool offline = false;

  final Logger log = new Logger('WaveRequest');

  void _sendText(BuildContext context) {
    String text = textController.text;

    if (offline && text.length > 32) {
      Utils.showSnackBar(context, "Error sending offline Wave - text too long");
      log.warning(
          "Error saving offline wave request with text > 32 characters");
      return;
    }

    String code = Utils.generateCode();
    WaveRequest request = new WaveRequest(context, code, text, null, offline);
    request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Switch(
            value: offline,
            onChanged: (bool isOn) {
              setState(() {
                offline = isOn;
              });
            },
            activeColor: Colors.greenAccent,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
      body: Builder (
        builder: (BuildContext context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: TextField(
                  controller: textController,
                  maxLength: offline ? 32 : 1000,
                  maxLines: offline ? 2 : 10,
                  decoration: InputDecoration(
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
              RaisedButton(
                color: Color(0xFFfa7268),
                elevation: 2,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  _sendText(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    offline ? 'Send Offline Text Wave' : 'Send Text Wave',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
