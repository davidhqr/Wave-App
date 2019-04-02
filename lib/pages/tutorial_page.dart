import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:wave/pages/home_page.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage({Key key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  PageController _pageController =
      PageController(initialPage: 0, keepPage: false);

  void _advancePage() {
    if (_pageController.page != 4) {
      _pageController.animateToPage(_pageController.page.toInt() + 1,
          duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(title: 'Home')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageIndicatorContainer(
        pageView: PageView(
          controller: _pageController,
          children: [
            Container(
              color: Color(0xFFfa7268),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to Wave",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFfa7268),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Icon(
                              Icons.volume_up,
                              color: Colors.white,
                              size: 150,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Text(
                                "Transfer data using sound",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Send text and images to other people through sound Waves.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFfa7268),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Icon(
                              Icons.cloud_download,
                              color: Colors.white,
                              size: 150,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Text(
                                "Receive data using sound",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Receive sound Waves from other iOS and Android devices.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFfa7268),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Icon(
                              Icons.group,
                              color: Colors.white,
                              size: 150,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Text(
                                "Multiple devices at once",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Send Waves to an unlimited amount of devices at once.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFfa7268),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's get started",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              "Never send private data using Wave",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        align: IndicatorAlign.bottom,
        length: 5,
        indicatorColor: Colors.white,
        indicatorSelectorColor: Colors.grey,
        padding: EdgeInsets.only(bottom: 10.0),
        size: 7.0,
        indicatorSpace: 10.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Get Started',
        onPressed: _advancePage,
        child: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFFfa7268),
        ),
      ),
    );
  }
}
