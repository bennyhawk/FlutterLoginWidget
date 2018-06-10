import 'package:flutter/material.dart';
import 'package:login_button/login_button.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Login Button example app'),
        ),
        body: new Center(child: new LoginButton()),
      ),
    );
  }
}
