import 'package:flutter/material.dart';
import 'package:lshelpy_chatbot/message.dart';

class HomePage extends StatelessWidget{
  static const String TITLE = "LSHelpy";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(TITLE),
        ),
        body: new ChatScreen()
    );
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

  void waitChatbotResponse(String userMessage) {
    // TODO: Controlar la entrada del usuario y dar respuesta en función a esta

    _chatController.clear();
    Message message = new Message(
        text: "soy un chatbot",
        student: false,
    );

    setState(() {
      _messages.insert(0, message);
    });

  }
}
