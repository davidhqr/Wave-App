import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:logging/logging.dart';
import 'package:wave/utils.dart';
import 'package:wave/wave_request.dart';

class SendImagePage extends StatefulWidget {
  SendImagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SendImagePageState createState() => _SendImagePageState();
}

class _SendImagePageState extends State<SendImagePage> {
  String _imagePath;

  final Logger log = new Logger('WaveRequest');

  void _pickImage() async {
    try {
      String imagePath = await FilePicker.getFilePath(type: FileType.IMAGE);
      if (imagePath == '') {
        return;
      }
      setState(() {
        this._imagePath = imagePath;
      });
    } on Exception catch (e) {
      log.severe("Error while picking image: " + e.toString());
    }
  }

  void _sendImage(BuildContext context) {
    if (_imagePath == null || _imagePath.isEmpty) {
      Utils.showSnackBar(context, "Select an image first");
      log.warning("No image selected");
      return;
    }

    String code = Utils.generateCode();
    WaveRequest request = new WaveRequest(context, code, null, _imagePath, false);
    request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 280,
                  width: 280,
                  decoration: new BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(const Radius.circular(15)),
                    border: Border.all(
                        color: _imagePath == null
                            ? Colors.black87
                            : Color(0xFFfa7268)),
                  ),
                  child: _imagePath == null
                      ? Center(child: Text('No image selected.'))
                      : Image.file(new File(_imagePath)),
                ),
              ],
            ),
          ),
          RaisedButton(
            color: Color(0xFFfa7268),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: () {
              _sendImage(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Send Image Wave',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFfa7268),
        onPressed: _pickImage,
        tooltip: 'Select Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
