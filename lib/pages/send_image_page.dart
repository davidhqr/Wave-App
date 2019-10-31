import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:Wave/constants.dart';
import 'package:Wave/send_wave_request.dart';
import 'package:Wave/sending_state.dart';
import 'package:Wave/utils.dart';
import 'package:chirp_flutter/chirp_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _initChirp();
    _configChirp();
    _setChirpCallbacks();
    _startAudioProcessing();
  }

  @override
  void dispose() {
    _stopAudioProcessing();
    super.dispose();
  }

  Future<void> _initChirp() async {
    var state = await ChirpSDK.state;
    if (state != ChirpState.running)
      await ChirpSDK.init(Constants.APP_KEY, Constants.APP_SECRET);
  }

  Future<void> _configChirp() async {
    var state = await ChirpSDK.state;
    if (state != ChirpState.running)
      await ChirpSDK.setConfig(Constants.APP_CONFIG);
  }

  Future<void> _startAudioProcessing() async {
    var state = await ChirpSDK.state;
    if (state != ChirpState.running) await ChirpSDK.start();
  }

  Future<void> _stopAudioProcessing() async {
    await ChirpSDK.stop();
  }

  Future<void> _sendChirp(Uint8List data) async {
    ChirpSDK.send(data);
  }

  Future<void> _setChirpCallbacks() async {
    ChirpSDK.onSent.listen((sent) {
      SendingState().sending = false;
      setState(() {
        _sending = false;
      });
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
    log.info("Successfully sent online file wave");
  }

  void _sendImage(BuildContext context) {
    if (_imagePath == null || _imagePath.isEmpty) {
      Utils.showSnackBar(context, "Select an image first");
      log.warning("No image selected");
      return;
    }

    if (SendingState().sending) {
      Utils.showSnackBar(context, "Another Wave is already being sent");
      log.info("Another wave is already being sent");
      return;
    }

    SendingState().sending = true;
    SendingState().time = DateTime.now();

    setState(() {
      _sending = true;
    });

    Future.delayed(const Duration(seconds: 20), () {
      if (SendingState().sending &&
          DateTime.now()
              .subtract(Duration(seconds: 19))
              .isAfter(SendingState().time)) {
        SendingState().sending = false;
        setState(() {
          _sending = false;
        });
        Utils.showSnackBar(context,
            "Sending Wave timed out. Check your internet connection and try again.");
        log.warning("Sending wave timed out");
      }
    });

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
              padding: const EdgeInsets.all(12),
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
    return _sending
        ? SpinKitWave(
            color: Color(0xFFfa7268),
          )
        : RaisedButton(
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
