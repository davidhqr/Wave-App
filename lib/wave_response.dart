class WaveResponse {
  String _code;
  String _text;
  List<dynamic> _files;
  DateTime _date;

  WaveResponse(String code, String text, List<dynamic> files, DateTime date)
      : _code = code,
        _text = text,
        _files = files,
        _date = date;

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  List<dynamic> get files => _files;

  set files(List<dynamic> value) {
    _files = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }


}
