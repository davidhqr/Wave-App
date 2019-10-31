import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class PulsingButton extends StatefulWidget {
  final Function _onPressed;

  PulsingButton(this._onPressed);

  @override
  _PulsingButtonState createState() => _PulsingButtonState(_onPressed);
}

class _PulsingButtonState extends State<PulsingButton>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;
  Function _onPressed;

  _PulsingButtonState(this._onPressed);

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = ColorTween(begin: Color(0xFFf29891), end: Color(0xFFfa7268))
        .animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return new Container(
          child: new ButtonTheme(
            minWidth: 200,
            height: 200,
            child: new RaisedButton(
              color: animation.value,
              elevation: 10,
              shape: new CircleBorder(),
              onPressed: () {
                controller.forward();
                _onPressed();
              },
              child: Text(
                'Listen for\nWaves',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
