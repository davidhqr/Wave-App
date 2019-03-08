import 'package:flutter/material.dart';
import 'package:wave/pages/send_text_page.dart';
import 'package:wave/pages/send_image_page.dart';
import 'package:wave/pages/send_file_page.dart';
import 'package:wave/widgets/pulsing_button.dart';
import 'package:chirpsdk/chirpsdk.dart';
import 'package:wave/constants.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wave/widgets/receive_dialog.dart';
import 'package:wave/wave_response.dart';
import 'package:wave/get_wave_request.dart';
import 'package:wave/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool listening = false;

  final Logger log = new Logger('HomePage');

  @override
  initState() {
    super.initState();
    _requestPermissions();
    _initChirp();
    _configChirp();
    _setChirpCallbacks();
    _startAudioProcessing();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus status = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);
    if (status != PermissionStatus.granted) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]);
    }
  }

  Future<void> _initChirp() async {
    await ChirpSDK.init(Constants.APP_KEY, Constants.APP_SECRET);
  }

  Future<void> _configChirp() async {
    await ChirpSDK.setConfig(Constants.APP_CONFIG);
  }

  void _setChirpCallbacks() {
    ChirpSDK.onReceived.listen((dataEvent) {
      String payload = new String.fromCharCodes(dataEvent.payload);
      log.info("Received payload: " + payload);
      if (listening) {
        if (payload.startsWith("wv")) {
          GetWaveRequest(payload).get().then((WaveResponse response) {
            setPrefs(response);
            showDialog(
                context: context,
                builder: ((BuildContext context) {
                  return ReceiveDialog(response);
                }));
          });
        } else {
          WaveResponse response = WaveResponse(null, payload, null, null)
          setPrefs(response);
          showDialog(
              context: context,
              builder: ((BuildContext context) {
                return ReceiveDialog(response);
              }));
        }
      }
    });

    ChirpSDK.onError.listen((errorEvent) {
      log.severe(errorEvent.message);
    });

    ChirpSDK.onReceiving.listen((dataEvent) {
      log.info("Receiving payload");
    });
  }

  Future<void> _startAudioProcessing() async {
    await ChirpSDK.start();
  }

  void setPrefs(WaveResponse waveResponse) async {
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

  void startListening(BuildContext context) {
    Utils.showSnackBar(context, "Started listening for Waves");
    setState(() {
      listening = !listening;
    });
  }

  Widget getListeningWidget(BuildContext context) {
    if (listening) {
      return Column(
        children: [
          SpinKitWave(
            color: Color(0xFFf29891),
            size: 100.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: RaisedButton(
              color: Color(0xFFfa7268),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                setState(() {
                  listening = false;
                  Utils.showSnackBar(context, "Stopped listening for Waves");
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  'Stop Listening',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return PulsingButton(() {
        startListening(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe8e8e8),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.text_fields),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SendTextPage(title: 'Send Text Wave')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SendImagePage(title: 'Send Image Wave')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SendFilePage(title: 'Send File Wave')),
              );
            },
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [getListeningWidget(context)],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 20, right: 20, bottom: 40),
                  child: Container(
                    height: 380,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        //new Color.fromRGBO(255, 0, 0, 0.0),
                        borderRadius: new BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFbfbfbf),
                            blurRadius: 20,
                            // has the effect of softening the shadow
                          )
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text("Past Waves",
                              style: TextStyle(fontSize: 20)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 8),
                            child: ListView(
                              physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.map),
                                  title: Text('Map'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo_album),
                                  title: Text('Album'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
