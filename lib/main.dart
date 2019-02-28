import 'package:flutter/material.dart';
import 'package:wave/pages/home_page.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint('${rec.time} [${rec.loggerName}] ${rec.level.name}: ${rec.message}');
  });
  runApp(WaveApp());
}

class WaveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFfa7268),
        fontFamily: 'Roboto',
      ),
      home: HomePage(title: 'Home'),
    );
  }
}
