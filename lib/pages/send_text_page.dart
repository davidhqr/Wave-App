import 'package:flutter/material.dart';
import 'package:Wave/send_wave_request.dart';
import 'package:logging/logging.dart';
import 'package:Wave/utils.dart';

class SendTextPage extends StatefulWidget {
  SendTextPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SendTextPageState createState() {
    return _SendTextPageState();
  }
}

class _SendTextPageState extends State<SendTextPage> {
  final Logger log = new Logger('WaveRequest');
  final TextEditingController textController = new TextEditingController();

  bool _offline = false;

  void _sendText(BuildContext context) {
    String text = textController.text;

    if (_offline && text.length > 32) {
      Utils.showSnackBar(context, "Error sending offline Wave - text too long");
      log.warning(
          "Error saving offline wave request with text > 32 characters");
      return;
    }

    String code = Utils.generateCode();
    SendWaveRequest request =
        new SendWaveRequest(context, code, text, null, _offline);
    request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Switch(
            value: _offline,
            onChanged: (bool isOn) {
              setState(() {
                _offline = isOn;
              });
            },
            activeColor: Colors.greenAccent,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: TextField(
                  controller: textController,
                  maxLength: _offline ? 32 : 1000,
                  maxLines: _offline ? 2 : 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  _sendText(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _offline ? 'Send Offline Text Wave' : 'Send Text Wave',
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
