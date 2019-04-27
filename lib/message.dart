import 'package:flutter/material.dart';
import 'message.dart';

const String _student_name = "Student";
const String _student_avatar =
    "http://res.cloudinary.com/kennyy/image/upload/v1531317427/avatar_z1rc6f.png";

const String _chatbot_name = "LSHelpy";
const String _chatbot_avatar =
    "https://st4.depositphotos.com/4177785/21246/v/1600/depositphotos_212467612-stock-illustration-machine-learning-color-icon-teacher.jpg";

class Message extends StatelessWidget {
  final String text;
  final bool student;

// constructor to get text from textfield
  Message({this.text, this.student});

  @override
  Widget build(BuildContext context) {

    if (student) {
      return ListTile(
        leading: CircleAvatar(
            child: new Image.network(_student_avatar)
        ),
        title: Text(_student_name),
        subtitle: Text(text),
      );
    } else {

      return ListTile(
        trailing: CircleAvatar(child: new Icon(Icons.face)),
        title: Text(_chatbot_name, textAlign: TextAlign.end,),
        subtitle: Text(text, textAlign: TextAlign.end,),
      );

    }
  }
}
