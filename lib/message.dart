import 'package:flutter/material.dart';
import 'message.dart';

const String _student_name = "Student";
const String _student_avatar = "http://res.cloudinary.com/kennyy/image/upload/v1531317427/avatar_z1rc6f.png";

const String _chatbot_name = "LSHelpy";
const String _chatbot_avatar = "https://st4.depositphotos.com/4177785/21246/v/1600/depositphotos_212467612-stock-illustration-machine-learning-color-icon-teacher.jpg";

class Message extends ListTile{
  final String text;
  final bool student;

// constructor to get text from textfield
  Message(
      {
        this.text,
        this.student
      }
      );

  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment crossAxisAlignment;

    if(student){
      crossAxisAlignment = CrossAxisAlignment.start;
      return new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: crossAxisAlignment,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(
                  child: new Image.network(_student_avatar)
              )
            ),
            new Column(
              crossAxisAlignment: crossAxisAlignment,
              children: <Widget>[
                new Text(_student_name, style: Theme.of(context).textTheme.subhead),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(text),
                )
              ],
            )
          ],
        ),
      );
    }else{
      crossAxisAlignment = CrossAxisAlignment.end;
      return new Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
            crossAxisAlignment: crossAxisAlignment,
            children: <Widget>[
              new Column(
                crossAxisAlignment: crossAxisAlignment,
                children: <Widget>[
                  new Text(_chatbot_name, style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              new Container(
                margin: const EdgeInsets.only(left: 16.0),
                //child: new CircleAvatar(
                child: new Icon(Icons.face)
              ),
            ],
      ),
      );
    }
  }
}