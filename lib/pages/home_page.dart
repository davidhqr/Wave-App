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
    ChirpSDK.init(Constants.APP_KEY, Constants.APP_SECRET);
  }

  Future<void> _configChirp() async {
    ChirpSDK.setConfig(Constants.APP_CONFIG);
  }

  Future<void> _setChirpCallbacks() async {
    ChirpSDK.onReceived.listen((dataEvent) {
      log.info("Received payload: " + dataEvent.payload.toString());
    });

    ChirpSDK.onError.listen((errorEvent) {
      log.severe(errorEvent.message);
    });
  }

  void startListening() {
    showDialog(
        context: context,
        builder: ((BuildContext context) {
          return ReceiveDialog(WaveResponse("1234", "testtest", null, null));
        }));
//    setState(() {
//      listening = true;
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.text_fields),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SendTextPage(title: 'Send Text Wave')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SendImagePage(title: 'Send Image Wave')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SendFilePage(title: 'Send File Wave')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [PulsingButton(startListening)],
            ),
          ),
        ],
      ),
    );
  }
}
