import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:lshelpy_chatbot/message.dart';
// Our dart classes
import 'package:lshelpy_chatbot/classes/schedule.dart';
import 'package:lshelpy_chatbot/classes/constValues.dart';
// Flutter library
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:path/path.dart';

class HomePage extends StatelessWidget{
  static const String TITLE = "LSHelpy";
  static AuthGoogle authGoogle;
  static Dialogflow dialogflow;

  static String studentName;
  static int studentCourse;

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

    studentSchedule = WeekSchedule();
  }

  void initSubjects() {
    // ---------- 2.PAED
    String name = ConstValues.PAED;
    Map<String, Object> map = new Map();
    map[ConstValues.SEMESTRE] = "Anual"; // Tipus d'assignatura
    map[ConstValues.CURS] = 2; // Curs
    map[ConstValues.CREDITOS] = 8; // Num de credits

    Map<String, List<int>> horario = new Map<String, List<int>>(); // horario
    List<int> horesDeClasseDilluns = new List<int>();// Dilluns
    horario[ConstValues.DAY_L] = horesDeClasseDilluns;
    List<int> horesDeClasseDimarts = new List<int>(); // Dimarts
    horario[ConstValues.DAY_M] = horesDeClasseDimarts;
    List<int> horesDeClasseDimecres = new List<int>(); // DImecres
    horesDeClasseDimecres.add(4);
    horario[ConstValues.DAY_X] = horesDeClasseDimecres;
    List<int> horesDeClasseDijous = new List<int>(); // Dijous
    horesDeClasseDijous.add(4);
    horario[ConstValues.DAY_J] = horesDeClasseDijous;
    List<int> horesDeClasseDivendres = new List<int>(); // Divendres
    horesDeClasseDivendres.add(4);
    horario[ConstValues.DAY_V] = horesDeClasseDivendres;
    map[ConstValues.HORARIO] = horario;

    Subject subject = new Subject(name);
    subject.data = map;

    HomePage.dataBase[name] = subject;
    // ---------- 2.MATES
    name = ConstValues.MATES;
    map = new Map();
    map[ConstValues.SEMESTRE] = "Anual";
    map[ConstValues.CURS] = 2;
    map[ConstValues.CREDITOS] = 8;

    horario = new Map<String, List<int>>(); // horario
    horesDeClasseDilluns = new List<int>();// Dilluns
    horesDeClasseDilluns.add(3);
    horario[ConstValues.DAY_L] = horesDeClasseDilluns;
    horesDeClasseDimarts = new List<int>(); // Dimarts
    horario[ConstValues.DAY_M] = horesDeClasseDimarts;
    horesDeClasseDimecres = new List<int>(); // Dimecres
    horesDeClasseDimecres.add(3);
    horario[ConstValues.DAY_X] = horesDeClasseDimecres;
    horesDeClasseDijous = new List<int>(); // Dijous
    horesDeClasseDijous.add(2);
    horario[ConstValues.DAY_J] = horesDeClasseDijous;
    horesDeClasseDivendres = new List<int>(); // Divendres
    horario[ConstValues.DAY_V] = horesDeClasseDivendres;
    map[ConstValues.HORARIO] = horario;

    subject = new Subject(name);
    subject.data = map;

    HomePage.dataBase[name] = subject;
    // ----------
    // ---------- 2.DPOO
    name = ConstValues.DPOO;
    map = new Map();
    map[ConstValues.SEMESTRE] = "Anual";
    map[ConstValues.CURS] = 2;
    map[ConstValues.CREDITOS] = 8;

    horario = new Map<String, List<int>>(); // horario
    horesDeClasseDilluns = new List<int>();// Dilluns
    horesDeClasseDilluns.add(1);
    horario[ConstValues.DAY_L] = horesDeClasseDilluns;
    horesDeClasseDimarts = new List<int>(); // Dimarts
    horario[ConstValues.DAY_M] = horesDeClasseDimarts;
    horesDeClasseDimecres = new List<int>(); // Dimecres
    horesDeClasseDimecres.add(1);
    horario[ConstValues.DAY_X] = horesDeClasseDimecres;
    horesDeClasseDijous = new List<int>(); // Dijous
    horario[ConstValues.DAY_J] = horesDeClasseDijous;
    horesDeClasseDivendres = new List<int>(); // Divendres
    horario[ConstValues.DAY_V] = horesDeClasseDivendres;
    map[ConstValues.HORARIO] = horario;

    subject = new Subject(name);
    subject.data = map;

    HomePage.dataBase[name] = subject;
    // ----------
    // ---------- 3.PIC3
    name = ConstValues.PIC3;
    map = new Map();
    map[ConstValues.SEMESTRE] = "Anual";
    map[ConstValues.CURS] = 3;
    map[ConstValues.CREDITOS] = 3;

    horario = new Map<String, List<int>>(); // horario
    horesDeClasseDilluns = new List<int>();// Dilluns
    horario[ConstValues.DAY_L] = horesDeClasseDilluns;
    horesDeClasseDimarts = new List<int>(); // Dimarts
    horario[ConstValues.DAY_M] = horesDeClasseDimarts;
    horesDeClasseDimecres = new List<int>(); // Dimecres
    horesDeClasseDimecres.add(3);
    horario[ConstValues.DAY_X] = horesDeClasseDimecres;
    horesDeClasseDijous = new List<int>(); // Dijous
    horario[ConstValues.DAY_J] = horesDeClasseDijous;
    horesDeClasseDivendres = new List<int>(); // Divendres
    horario[ConstValues.DAY_V] = horesDeClasseDivendres;
    map[ConstValues.HORARIO] = horario;

    subject = new Subject(name);
    subject.data = map;

    HomePage.dataBase[name] = subject;
    // ----------

  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  static String fase = "";
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

    AIResponse response;
    if(userMessage == ConstValues.init){
        response = await HomePage.dialogflow.detectIntent(userMessage);
        print("Es missatge inicial");
        print(userMessage);
    }
    else{
        response = await HomePage.dialogflow.detectIntent(fase + " " + userMessage);
        print("Misstage de l'usuari: " + fase + userMessage);
        print("Es missatge resposta de " + fase);
    }

    String botMessage = response.getMessage();
    if(botMessage != null){
        if(notValidAnswer(botMessage)){
          // Mensaje de "no he entendido lo que me has dicho"
          sendMessage(botMessage);

        }else{
          // Obtenemos la fase en la que se encuentra la conversación
          fase = getFase(botMessage);
          print("Fase: " + fase);
          if (fase == ConstValues.fase1){// --------- FASE 1
            // Respuesta de presentación del chatbot (respuesta a INIT CHATBOT)
            String resposta = botMessage.substring(6, response.getMessage().length);
            print("Resposta FASE 1: " + resposta);
            sendMessage(resposta);

          }else if (fase == ConstValues.fase2){// --------- FASE 2
            // fase2 NAME $namelist fase2 Encantado de conocerte $namelist . Qué curso harás el año que viene?
            String NAMETag = botMessage.substring(6, 10);
            print("NAME TAGE: " + NAMETag);

            HomePage.studentName = getWord(botMessage, 11);
            print("Student name: " + HomePage.studentName);
            int index = 11 + HomePage.studentName.length;

            index++;
            String basura = getWord(botMessage, index);
            //basura = getWord(botMessage, index);
            print("Basura: " + basura);

            index += basura.length;
            String resposta = botMessage.substring(index, botMessage.length);
            sendMessage(resposta);

          }else if (fase == ConstValues.fase3){// --------- FASE 3
            // fase3 CURS $number fase3 Así que $number... Escribe las asignaturas pendientes de años anteriores que quieras añadir a tu horario.
            String CURStag = botMessage.substring(6, 10);
            print("CURS TAG: " + CURStag);

            String course = getWord(botMessage, 11);
            print("Student course: " + course);
            HomePage.studentCourse = int.parse(course);
            int index = 11 + course.length;

            index++;
            String basura = getWord(botMessage, index);
            print("Basura: " + basura);

            index += basura.length;
            String resposta = botMessage.substring(index, botMessage.length);
            sendMessage(resposta);

          }else if (fase == ConstValues.fase4){// --------- FASE 4

            /*
                1 - Leer la accion
                          [ADD1] añadir una sola
                          [ADD+] añadir listado de asignaturas pendientes
                          [INFO] información
                          [ENDCHATBOT] información

                  1.1 - ADD+:
                      Seguir la lista de asignaturas e irlas añadiendo

                  1.2 - ADD1:
                      Añadir la asignatura indicada, informando sobre las colisiones
                      y decidiendo en función de la elección del usuario

                  1.3 - INFO:
                      Mirar la siguiente palabra (será el campo a buscar info)
                      Buscar la info de ese campo en la base de datos
                      Mostrar la info

                  1.4 - ENDCHATBOT:
                      Mostrar horario / DESCARGAR horario

                2 - Mostrar mensaje de "Aqui tines tu horario por el momento"

                3 - Mostrar horario

                4 - Pedir siguiente acción al usuario

             */

            // PAS 1
            String action = getWord(botMessage, 6);
            print("ACTION: " + action);

            int index = 6 + action.length;
            if(action == ConstValues.ADDPENDENT){ // Afegim assignatures pendents
              // PAS 1.1
              String asignatura = "";
              while(botMessage[index + 1] != '%'){// Hemos puesto '%' como signo de clausura
                index++;
                asignatura = getWord(botMessage, index);
                print("Asignaturas: " + asignatura);
                if(asignatura != "y" && asignatura != "%"){
                  // Obtener datos de la asignatura
                  Subject subject = HomePage.dataBase[asignatura];
                  print("\tAsignatura de la Base de Dades: " + subject.name);
                  print("Créditos de " + subject.name + ": " + (subject.data[ConstValues.CREDITOS]).toString());

                  // Añadir asignatura al horario
                  Map<String, List<int>> horario = subject.data[ConstValues.HORARIO];
                  List<int> horesDia = horario[ConstValues.DAY_L]; // Hores de dilluns
                  int size;
                  if(horesDia != null){
                    if(horesDia.isNotEmpty){
                      size = horesDia.length;
                      for(int i = 0; i < size; i++){
                        HomePage.studentSchedule.addSubject(subject, 0, horesDia.elementAt(i));
                      }
                    }
                  }


                  horesDia = horario[ConstValues.DAY_M]; // Hores de dimarts
                  if(horesDia != null){
                    if(horesDia.isNotEmpty){
                      size = horesDia.length;
                      for(int i = 0; i < size; i++){
                        HomePage.studentSchedule.addSubject(subject, 1, horesDia.elementAt(i));
                      }
                    }
                  }


                  horesDia = horario[ConstValues.DAY_X]; // Hores de dimecres
                  if(horesDia != null){
                    if(horesDia.isNotEmpty){
                      size = horesDia.length;
                      for(int i = 0; i < size; i++){
                        HomePage.studentSchedule.addSubject(subject, 2, horesDia.elementAt(i));
                      }
                    }
                  }


                  horesDia = horario[ConstValues.DAY_J]; // Hores de dijous
                  if(horesDia != null){
                    if(horesDia.isNotEmpty){
                      size = horesDia.length;
                      for(int i = 0; i < size; i++){
                        HomePage.studentSchedule.addSubject(subject, 3, horesDia.elementAt(i));
                      }
                    }
                  }


                  horesDia = horario[ConstValues.DAY_V]; // Hores de dimarts
                  if(horesDia != null){
                    if(horesDia.isNotEmpty){
                      size = horesDia.length;
                      for(int i = 0; i < size; i++){
                        HomePage.studentSchedule.addSubject(subject, 4, horesDia.elementAt(i));
                      }
                    }
                  }

                  // Asignatura añadida al horario
                  sendMessage(subject.name + " añadida al horario!");

                }
                index += asignatura.length;
              }

              //WeekSchedule schedule = HomePage.studentSchedule;
              //print("Horario");
              // TODO:
              //    maybeNot -> Enviar mensaje de fase4 SHOW
              //    -> mostrar el horario
              //    Enviar mensaje de fase4 MORE
              //    En la respuesta con action = MORE mostrar el mensaje ( para que no siempre sea el mismo )

              // TODO: Falta por añadir la action tambien de FINISH

            }else if(action == ConstValues.ADDONE){ // Afegim una asignatura
              // PAS 1.2
              WeekSchedule schedule = HomePage.studentSchedule;
              index++;
              String assignatura = getWord(botMessage, index);
              Subject subject = HomePage.dataBase[assignatura];
              Map<String, List<int>> horario = subject.data[ConstValues.HORARIO];

              int numInsercions = 0;

              List<int> horesDia = horario[ConstValues.DAY_L]; // Hores de dilluns
              int size = 0;
              if(horesDia != null){
                if(horesDia.isNotEmpty){
                  size = horesDia.length;
                  for(int i = 0; i < size; i++){
                    int dia = 0;
                    int hora = horesDia.elementAt(i);
                    if(isOcuped(dia, hora)){
                      Subject previousSubject = HomePage.studentSchedule.dies.elementAt(dia).hores.elementAt(hora);
                      if(previousSubject.name != subject.name){
                        bool wants = await studentWantToOverride(previousSubject, subject, this.context, 2, 5);
                        if(wants){
                          HomePage.studentSchedule.addSubject(subject, dia, hora);
                          numInsercions++;
                        }
                      }
                    }else{
                      HomePage.studentSchedule.addSubject(subject, dia, hora);
                      numInsercions++;
                    }
                  }
                }
              }

              horesDia = horario[ConstValues.DAY_M]; // Hores de dimarts
              if(horesDia != null){
                if(horesDia.isNotEmpty){
                  size = horesDia.length;
                  for(int i = 0; i < size; i++){
                    int dia = 1;
                    int hora = horesDia.elementAt(i);
                    if(isOcuped(dia, hora)){
                      Subject previousSubject = HomePage.studentSchedule.dies.elementAt(dia).hores.elementAt(hora);
                      if(previousSubject.name != subject.name){
                        bool wants = await studentWantToOverride(previousSubject, subject, this.context, 2, 5);
                        if(wants){
                          HomePage.studentSchedule.addSubject(subject, dia, hora);
                          numInsercions++;
                        }
                      }
                    }else{
                      HomePage.studentSchedule.addSubject(subject, dia, hora);
                      numInsercions++;
                    }
                  }
                }
              }

              horesDia = horario[ConstValues.DAY_X]; // Hores de dimecres
              if(horesDia != null){
                if(horesDia.isNotEmpty){
                  size = horesDia.length;
                  for(int i = 0; i < size; i++){
                    int dia = 2;
                    int hora = horesDia.elementAt(i);
                    if(isOcuped(dia, hora)){
                      Subject previousSubject = HomePage.studentSchedule.dies.elementAt(dia).hores.elementAt(hora);
                      if(previousSubject.name != subject.name){
                        bool wants = await studentWantToOverride(previousSubject, subject, this.context, 2, 5);
                        if(wants){
                          HomePage.studentSchedule.addSubject(subject, dia, hora);
                          numInsercions++;
                        }
                      }
                    }else{
                      HomePage.studentSchedule.addSubject(subject, dia, hora);
                      numInsercions++;
                    }
                  }
                }
              }

              horesDia = horario[ConstValues.DAY_J]; // Hores de dijous
              if(horesDia != null){
                if(horesDia.isNotEmpty){
                  size = horesDia.length;
                  for(int i = 0; i < size; i++){
                    int dia = 3;
                    int hora = horesDia.elementAt(i);
                    if(isOcuped(dia, hora)){
                      Subject previousSubject = HomePage.studentSchedule.dies.elementAt(dia).hores.elementAt(hora);
                      if(previousSubject.name != subject.name){
                        bool wants = await studentWantToOverride(previousSubject, subject, this.context, 2, 5);
                        if(wants){
                          HomePage.studentSchedule.addSubject(subject, dia, hora);
                          numInsercions++;
                        }
                      }
                    }else{
                      HomePage.studentSchedule.addSubject(subject, dia, hora);
                      numInsercions++;
                    }
                  }
                }
              }

              horesDia = horario[ConstValues.DAY_V]; // Hores de divendres
              if(horesDia != null){
                if(horesDia.isNotEmpty){
                  size = horesDia.length;
                  for(int i = 0; i < size; i++){
                    int dia = 4;
                    int hora = horesDia.elementAt(i);
                    if(isOcuped(dia, hora)){
                      Subject previousSubject = HomePage.studentSchedule.dies.elementAt(dia).hores.elementAt(hora);
                      if(previousSubject.name != subject.name){
                        bool wants = await studentWantToOverride(previousSubject, subject, this.context, 2, 5);
                        if(wants){
                          HomePage.studentSchedule.addSubject(subject, dia, hora);
                          numInsercions++;
                        }
                      }
                    }else{
                      HomePage.studentSchedule.addSubject(subject, dia, hora);
                      numInsercions++;
                    }
                  }
                }
              }
              if(numInsercions > 0){
                // Asignatura añadida al horario
                sendMessage(subject.name + " añadida al horario!");
              }else{
                // No se ha añadido ni una vez
                sendMessage(subject.name + " no ha estado añadida al horario");
              }

            }else if(action == ConstValues.INFORMATION) { // Demanem info d'una asignatura
              // PAS 1.3

            }else{ // Demanem acabar (descarregar horari i tancar conversacio )
              // PAS 1.4

            }
          }

          String resposta = response.getMessage().substring(6, response.getMessage().length);
          print("Resposta: " + resposta);
          // TODO: Comprovar mensaje incorrecto
          // TODO: Comprovar tipo de mensaje
          // TODO: Tratar cadaa tipo de mensaje
          //chatbotResponseMessage = resposta;
        }

    }

    /*_chatController.clear();
    Message message = new Message(
        text: chatbotResponseMessage,
        student: false,
    );

    setState(() {
      _messages.insert(0, message);
    });*/

    //sendMessage(chatbotResponseMessage);

  }

  void sendMessage(String content) {

    _chatController.clear();
    Message message = new Message(
      text: content,
      student: false,
    );

    setState(() {
      _messages.insert(0, message);
    });

  }
}

enum ConfirmAction { CANCELAR, ACEPTAR }

Future<bool> studentWantToOverride(Subject previousSubject, Subject subject, BuildContext context,
    int dia, int hora) async{
  String message = "Aceptando se pondrá " + subject.name + " el día "
      + dia.toString() + " en vez de " + previousSubject.name + " en la "
      + hora.toString() + " hora";
  bool want = false;

  switch(
    await showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quieres sobreescribir la asignatura?'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCELAR);
                return false;
              },
            ),
            FlatButton(
              child: const Text('ACEPTAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACEPTAR);
                return true;
              },
            )
          ],
        );
      },
    )
  ){
    case ConfirmAction.ACEPTAR:
      want = true;
      break;
    case ConfirmAction.CANCELAR:
      want = false;
      break;
    default:
      want = false;
      break;
  }

  return want;
}

bool isOcuped(int dia, int hora) {
  return HomePage.studentSchedule.dies.elementAt(dia).hores.elementAt(hora) != null;
}

String getWord(String botMessage, int initialIndex) {
  String word = "";
  int index = initialIndex;
  while (index < botMessage.length && botMessage[index] != " " && botMessage[index] != ","){
    word = word + botMessage[index];
    index++;
  }
  return word;
}

bool notValidAnswer(String message) {
  if( message == ConstValues.notUnderstand1
      || message == ConstValues.notUnderstand2
      || message == ConstValues.notUnderstand3
      || message == ConstValues.notUnderstand4
      || message == ConstValues.notUnderstand5){
    return true;
  }
  return false;
}


String getFase(String botMessage) {
  return botMessage.substring(0, 5);
}