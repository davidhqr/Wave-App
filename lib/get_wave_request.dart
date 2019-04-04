import 'package:logging/logging.dart';
import 'package:Wave/constants.dart';
import 'package:Wave/wave_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetWaveRequest {
  String _code;

  final Logger log = new Logger('WaveRequest');

  GetWaveRequest(String code) : _code = code;

  Future<WaveResponse> get() async {
    final response = await http.get(Constants.BASE_WAVE_URL + "/" + _code);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return WaveResponse(body["code"], body["text"], body["files"], body["date"]);
    } else {
      throw Exception("Failed to get wave with code " + _code);
    }
  }
}
