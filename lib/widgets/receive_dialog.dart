import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:Wave/wave_response.dart';
import 'package:Wave/widgets/selectable_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceiveDialog extends StatefulWidget {
  final WaveResponse waveResponse;

  ReceiveDialog(this.waveResponse);

  @override
  _ReceiveDialogState createState() => _ReceiveDialogState();
}

class _ReceiveDialogState extends State<ReceiveDialog> {
  SharedPreferences prefs;
  TextEditingController _textController = TextEditingController();

  bool preview = false;

  @override
  void initState() {
    super.initState();
    _textController.text = widget.waveResponse.text;
    _initializeSharedPreferences();
  }

  void _initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.waveResponse.text != null &&
        widget.waveResponse.text.isNotEmpty) {
      return buildTextWaveDialog(widget.waveResponse);
    } else {
      return buildFileWaveDialog(widget.waveResponse);
    }
  }

  void saveWaveResponse(WaveResponse waveResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList("waves");
    if (list == null) {
      list = new List<String>();
    }
    if (waveResponse.text != null) {
      list.add(waveResponse.text);
    } else {
      list.add(waveResponse.files[0].toString());
    }
    prefs.setStringList("waves", list);
  }

  void saveFile(WaveResponse waveResponse) async {
    try {
      var imageId = await ImageDownloader.downloadImage(waveResponse.files[0]);
      if (imageId == null) {
        return;
      }
    } on Exception catch (error) {
      print(error);
    }
    saveWaveResponse(waveResponse);
  }

  Widget buildTextWaveDialog(WaveResponse waveResponse) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: Container(
        width: 300,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // dialog top
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(
                    'Incoming Wave',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Divider(
                color: Colors.grey,
                height: 4,
              ),
            ),

            // dialog center
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: SelectableField(
                controller: _textController,
                maxLines: 7,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Color(0xFFef5350),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Discard',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: RaisedButton(
                      color: Color(0xFF66BB6A),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        saveWaveResponse(waveResponse);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '  Save  ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFileWaveDialog(WaveResponse waveResponse) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: Container(
        width: 300,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // dialog top
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(
                    'Incoming Wave',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Divider(
                color: Colors.grey,
                height: 4,
              ),
            ),

            // dialog center
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 22),
                child:
                    Image.network(waveResponse.files[0], fit: BoxFit.contain),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Color(0xFFef5350),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Discard',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: RaisedButton(
                      color: Color(0xFF66BB6A),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        saveFile(waveResponse);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '  Save  ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
