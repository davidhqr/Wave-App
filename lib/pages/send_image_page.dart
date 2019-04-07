import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:Wave/constants.dart';
import 'package:Wave/send_wave_request.dart';
import 'package:Wave/utils.dart';
import 'package:chirpsdk/chirpsdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class SendImagePage extends StatefulWidget {
  SendImagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SendImagePageState createState() => _SendImagePageState();
}

class _SendImagePageState extends State<SendImagePage> {
  final Logger log = new Logger('WaveRequest');

  String _imagePath;

  @override
  void initState() {
    super.initState();
    _initChirp();
    _configChirp();
    _setChirpCallbacks();
    _startAudioProcessing();
  }

  Future<void> _initChirp() async {
    await ChirpSDK.init(Constants.APP_KEY, Constants.APP_SECRET);
  }

  Future<void> _configChirp() async {
    await ChirpSDK.setConfig(Constants.APP_CONFIG);
  }

  Future<void> _startAudioProcessing() async {
    await ChirpSDK.start();
  }

  Future<void> _sendChirp(Uint8List data) async {
    ChirpSDK.send(data);
  }

  Future<void> _setChirpCallbacks() async {
    ChirpSDK.onError.listen((error) {
      log.severe(error.message);
    });
  }

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

  void _onSuccess(BuildContext context, Uint8List payload) {
    _sendChirp(payload);
    Utils.showSnackBar(context, "Wave sent successfully");
    log.info("Successfully sent offline file wave");
  }

  void _sendImage(BuildContext context) {
    if (_imagePath == null || _imagePath.isEmpty) {
      Utils.showSnackBar(context, "Select an image first");
      log.warning("No image selected");
      return;
    }

    String code = Utils.generateCode();
    SendWaveRequest request =
        new SendWaveRequest(context, code, null, _imagePath, false, _onSuccess);
    request.getPayload();
  }

  Widget _imageDisplay() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 280,
            width: 280,
            decoration: new BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(const Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFbfbfbf),
                    blurRadius: 20,
                    // has the effect of softening the shadow
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _imagePath == null
                  ? Center(child: Text('No image selected'))
                  : Image.file(new File(_imagePath)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sendImageButton(BuildContext context) {
    return RaisedButton(
      color: Color(0xFFfa7268),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(builder: (BuildContext context) {
        return Column(
          children: [
            _imageDisplay(),
            _sendImageButton(context),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFfa7268),
        onPressed: _pickImage,
        tooltip: 'Select Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
