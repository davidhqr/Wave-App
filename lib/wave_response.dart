class WaveResponse {
  String code;
  String text;
  List<dynamic> files;
  DateTime date;

  WaveResponse(String code, String text, List<dynamic> files, DateTime date)
      : code = code,
        text = text,
        files = files,
        date = date;

}
