import 'package:flutter/material.dart';
import 'homepage.dart';
// Flutter library
import 'package:flutter_dialogflow/dialogflow_v2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String TITLE = "LSHelpy";
  @override
  Widget build(BuildContext context) {
    initGoogle();
    return MaterialApp(
      title: TITLE,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new HomePage(),
    );
  }

  Future initGoogle() async {
    AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/credentials.json").build();
  }

}
