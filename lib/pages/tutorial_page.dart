import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage({Key key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageIndicatorContainer(
      pageView: PageView(
        children: [
          Container(
            color: Color(0xFFfa7268),
            child: Column(
              children: [
                Text("Tutorial 1",
                    style: TextStyle(color: Colors.white, fontSize: 14))
              ],
            ),
          ),
          Container(
            color: Color(0xFFfa7268),
            child: Column(
              children: [Text("Tutorial 2")],
            ),
          ),
          Container(
            color: Color(0xFFfa7268),
            child: Column(
              children: [Text("Tutorial 3")],
            ),
          ),
        ],
      ),
      align: IndicatorAlign.bottom,
      length: 3,
      indicatorColor: Colors.white,
      indicatorSelectorColor: Colors.grey,
      padding: EdgeInsets.only(bottom: 10.0),
      size: 7.0,
      indicatorSpace: 10.0,
    ));
  }
}
