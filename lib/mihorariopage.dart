import 'package:flutter/material.dart';
import 'package:lshelpy_chatbot/classes/schedule.dart';
import 'package:lshelpy_chatbot/message.dart';

class MiHorarioPage extends StatelessWidget{
  static const String TITLE = "Tu Horario";
  static WeekSchedule studentSchedule;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(TITLE),
        ),
        body: Message.buildSchedule(studentSchedule)
    );

  }
}

