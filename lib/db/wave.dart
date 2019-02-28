import 'dart:convert';

Wave waveFromJson(String str) {
  final jsonData = json.decode(str);
  return Wave.fromJson(jsonData);
}

String waveToJson(Wave data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Wave {
  int id;
  String code;
  String type;
  String text;
  List<String> files;

  Wave({
    this.id,
    this.code,
    this.type,
    this.text,
    this.files,
  });

  factory Wave.fromJson(Map<String, dynamic> json) => new Wave(
    id: json["id"],
    code: json["code"],
    type: json["type"],
    text: json["text"],
    files: json["files"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "type": type,
    "text": text,
    "files": files,
  };
}
