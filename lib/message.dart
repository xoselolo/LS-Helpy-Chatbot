import 'package:flutter/material.dart';
import 'package:lshelpy_chatbot/classes/schedule.dart';
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

  static Widget buildSchedule(WeekSchedule studentSchedule){
    List<Container> subjects = new List<Container>();
    for(int i = 0; i < 5; i++){
      for(int j = 0; j < DaySchedule.MAX_HORES; j++){
        if(studentSchedule.dies[i].isFree(j)){
          // Creem el text buit
          subjects.add(new Container(
              color: Colors.grey,
              child: new Text("---"),
          ));
        }else{
          subjects.add(new Container(
              color: Colors.teal[200],
              child: new Text(studentSchedule.dies[i].elementAt(j).name),
          ));
        }
      }
    }

    return ListTile(
      trailing: CircleAvatar(child: new Icon(Icons.face)),
      title: Text(_chatbot_name, textAlign: TextAlign.end,),
      subtitle: GridView.count(
          crossAxisCount: 5,
          children: List<Widget>.generate(DaySchedule.MAX_HORES * 5, (index){
              return new GridTile(
                  child: subjects[index]
              );
          }),
      ),
    );
  }
}
