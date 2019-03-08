import 'package:flutter/material.dart';
import 'package:wave/wave_response.dart';
import 'package:wave/widgets/selectable_field.dart';

class ReceiveDialog extends StatefulWidget {
  final WaveResponse waveResponse;

  ReceiveDialog(this.waveResponse);

  @override
  _ReceiveDialogState createState() => _ReceiveDialogState();
}

class _ReceiveDialogState extends State<ReceiveDialog> {
  TextEditingController _textController = TextEditingController();

  bool preview = false;

  @override
  void initState() {
    _textController.text = widget.waveResponse.text;
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.waveResponse.text != null && widget.waveResponse.text.isNotEmpty) {
      return buildTextWaveDialog(widget.waveResponse);
    } else {
      return buildFileWaveDialog(widget.waveResponse);
    }
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
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Image.network(waveResponse.files[0]),
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
