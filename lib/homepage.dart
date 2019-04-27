import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:lshelpy_chatbot/message.dart';
// Our dart classes
import 'package:lshelpy_chatbot/classes/schedule.dart';
// Flutter library
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class HomePage extends StatelessWidget{
  static const String TITLE = "LSHelpy";
  static AuthGoogle authGoogle;
  static Dialogflow dialogflow;
  static Map<String, Subject> dataBase;
  static WeekSchedule studentSchedule;
  //static List<Schedule> studentSchedule;

  @override
  Widget build(BuildContext context) {
    initGoogle();
    initStructs();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(TITLE),
        ),
        body: new ChatScreen()
    );
  }

  Future initGoogle() async {
    authGoogle = await AuthGoogle(fileJson: "assets/credentials.json").build();
    dialogflow = Dialogflow(authGoogle: authGoogle,language: Language.spanishSpain);
  }

  void initStructs() {
    HomePage.dataBase = new Map<String, Subject>();
    initSubjects();

    WeekSchedule studentSchedule = WeekSchedule();
  }

  void initSubjects() {
    List<MapEntry<String, Subject>> subjects = new List<MapEntry<String, Subject>>();

    // ----------
    final String name = "Metodología y tecnología de la programación";
    Map<String, Object> map = new Map();
    map[Subject.CREDITOS] = 10;

    //Iterable<MapEntry> entries = new Iterable.empty();
    //MapEntry<String, Object> entry = new MapEntry(Subject.CREDITOS, 10);
    //map.addEntries(entries);

    Subject subject = new Subject(name);
    subject.data = map;

    HomePage.dataBase[name] = subject;
    // ----------

    //HomePage.dataBase
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = new TextEditingController();
  final List<Message> _messages = <Message>[];

  void _handleSubmit(String text) {
    if(text!=null){
      if(text.length != 0){
        _chatController.clear();
        Message message = new Message(
            text: text,
            student: true
        );

        setState(() {
          _messages.insert(0, message);
        });

        waitChatbotResponse(message.text);
      }
    }

  }

  Widget _chatEnvironment (){
    return IconTheme(
      data: new IconThemeData(color: Colors.pink),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal:8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(hintText: "Start typing ..."),
                controller: _chatController,
                onSubmitted: _handleSubmit,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),

                onPressed: ()=> _handleSubmit(_chatController.text),

              ),
            )
          ],
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Flexible(
          child: ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
          child: _chatEnvironment(),)
      ],
    );
  }

  Future<void> waitChatbotResponse(String userMessage) async {
    // TODO: Controlar la entrada del usuario y dar respuesta en función a esta
    //print("LOLO");
    //print(HomePage.authGoogle.getProjectId);
    //print(HomePage.authGoogle.getSessionId);
    //print(HomePage.authGoogle.getToken);

    AIResponse response = await HomePage.dialogflow.detectIntent(userMessage);
    String chatbotResponseMessage = "No results";
    if(response.getMessage() != null){
        // TODO: Comprovar mensaje incorrecto
        // TODO: Comprovar tipo de mensaje
        // TODO: Tratar cadaa tipo de mensaje
        chatbotResponseMessage = response.getMessage();
    }

    _chatController.clear();
    Message message = new Message(
        text: chatbotResponseMessage,
        student: false,
    );

    setState(() {
      _messages.insert(0, message);
    });

  }
}
