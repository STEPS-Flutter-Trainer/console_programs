import 'package:flutter/material.dart';
import 'captcha_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAPTCHA Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Random CAPTCHA')),
        body: Center(child: CaptchaWidget()),
      ),
    );
  }
}
