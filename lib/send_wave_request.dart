import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Wave/constants.dart';
import 'package:Wave/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class SendWaveRequest {
  BuildContext _context;
  String _code;
  String _text;
  String _filePath;
  bool _offline;
  Function _onSuccess;

  final Logger log = new Logger('WaveRequest');

  SendWaveRequest(BuildContext context, String code, String text,
      String filePath, bool offline, Function onSuccess)
      : _context = context,
        _code = code,
        _text = text,
        _filePath = filePath,
        _offline = offline,
        _onSuccess = onSuccess;

  void getPayload() async {
    if (_code == null || _code.isEmpty) {
      Utils.showSnackBar(_context, "Error sending Wave - please try again");
      log.warning("Error saving wave request with no code");
      return;
    }

    if (_text != null && _text.isNotEmpty) {
      if (_offline) {
        var payload = Uint8List.fromList(_text.codeUnits);
        _onSuccess(_context, payload);
      } else {
        log.info("Saving online text wave");
        _sendOnlineTextWave();
      }
    } else if (_filePath != null && _filePath.isNotEmpty) {
      log.info("Saving online file/image wave");
      _sendOnlineFileWave();
    } else {
      Utils.showSnackBar(_context, "Error sending Wave - please try again");
      log.warning("Error saving null wave request");
    }
  }

  void _sendOnlineTextWave() {
    String url = Constants.BASE_WAVE_URL;

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    String body = json.encode(
      {
        "code": _code,
        "text": _text,
      },
    );

    http.post(url, headers: headers, body: body).then((response) async {
      if (response.statusCode != 200) {
        Utils.showSnackBar(_context, "Failed to send Wave");
        log.severe(
            "Failed to save online text wave, responded with error code: " +
                response.statusCode.toString());
        return null;
      }
      log.info("Successfully saved online text wave");

      var payload = Uint8List.fromList(_code.codeUnits);
      _onSuccess(_context, payload);
    });
  }

  void _sendOnlineFileWave() async {
    Dio dio = new Dio();
    FormData formData = new FormData();

    formData.add("files[]", new UploadFileInfo(File(_filePath), "test.jpg"));
    formData.add("code", _code);

    await dio
        .post(Constants.BASE_WAVE_URL,
            data: formData,
            options: Options(method: 'POST', responseType: ResponseType.json))
        .then((response) async {
      log.info("Successfully saved online file wave");

      var payload = Uint8List.fromList(_code.codeUnits);
      _onSuccess(_context, payload);
    }).catchError((error) {
      Utils.showSnackBar(_context, "Failed to send Wave");
      log.severe(
          "Failed to save online text wave, responded with error code: " +
              error.toString());
    });
  }
}
