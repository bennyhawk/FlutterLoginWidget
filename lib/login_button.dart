import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  bool _isTweenComplete = true;
  bool _isCircularProgressRequired = false;

  //Tween Circular
  //true  true      Widget is a circular progress indicating currently processing/authenticating
  //false  true     There was a circular progress but an error occurred so widget returns to normal sign in button
  //true  false     Widget is a normal signin button
  //false  false    Widget was a sign in button and going to convert to become circular progress

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _animation = new Tween(begin: 200.0, end: 50.0).animate(
        new CurvedAnimation(parent: _controller, curve: Curves.decelerate))
      ..addListener(() {
        setState(() {
          _isTweenComplete = false;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isTweenComplete = true;
            _isCircularProgressRequired = !_isCircularProgressRequired;
          });
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _animation.value,
      height: 50.0,
      child: (_isCircularProgressRequired && _isTweenComplete)
          ? new Padding(
              padding: new EdgeInsets.all(4.0),
              child: new CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: new AlwaysStoppedAnimation<Color>(
                    new Color.fromARGB(255, 0, 0, 0)),
              ),
            )
          : new OutlineButton.icon(
              borderSide: new BorderSide(width: 4.0),
              onPressed: () {
                _controller.forward();
              },
              shape: new StadiumBorder(side: new BorderSide()),
              icon: _isTweenComplete
                  ? const Icon(Icons.exit_to_app)
                  : const Icon(null),
              label: new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _isTweenComplete ? new Text("Sign in") : new Text("")),
            ),
    );
  }
}
