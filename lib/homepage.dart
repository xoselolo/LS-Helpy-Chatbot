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
    //asignaturas de 1o
    createSubject("PROG I", "Anual", 1, 10, [1, -1, 1, -1, 1]);
    createSubject("IO", "Anual", 1, 9, [3, -1, 0, 0, 0]);
    createSubject("Business", "Anual", 1, 4, [0, -1, 4, -1, -1]);
    createSubject("ALGEBRA", "Anual", 1, 8, [-1, -1, 2, -1, 2]);
    createSubject("PiC I", "Anual", 1, 2, [-1, -1, -1, 3, -1]);
    createSubject("CALCULO", "Anual", 1, 10, [2, 3, -1, 2, -1]);
    createSubject("DiU I", "Anual", 1, 5, [-1, 1, -1, -1, -1]);
    createSubject("ELECTRO I", "Anual", 1, 12, [-1, -1, -1, 3, -1]);

    //asignaturas de 2o
    createSubject("PAED", "Anual", 2, 8, [-1, -1, 4, 4, 4]);
    createSubject("MATES", "Anual", 2, 8, [3, 0, 3, 2, 0]);
    createSubject("DPOO", "Anual", 2, 6, [1, 0, 1, 0, 0]);
    createSubject("COMPUS", "Anual", 2, 9, [-1, 3, 2, -1, 2]);
    createSubject("PIC II", "Anual", 2, 2, [4, -1, -1, -1, -1]);
    createSubject("XARXES", "Anual", 2, 6, [-1, 2, -1, 3, -1]);
    createSubject("BASES", "Anual", 2, 5, [2, -1, -1, -1, 1]);
    createSubject("VALUE CHAIN", "Anual", 2, 4, [1, 0, -1, -1, 1]);
    createSubject("PROYECTOS DE PROGRMACIÓN I", "Semestral (1er sem.)", 2, 3, [-1, 1, -1, -1, 3]);
    createSubject("PROYECTOS DE PROGRMACIÓN II", "Semestral (2ndo sem.)", 2, 4, [-1, 1, -1, -1, 3]);
    createDoubleHourSubject("PROGRAMACION DE GRAFICOS 3D", "Semestral (1er sem.)", 2, 5, 4, [0, 1]);

    //asignaturas de 3o
    createSubject("PIC III", "Anual", 3, 3, [-1, 1, 3, -1, -1]);
    createSubject("SO", "Semestral (1er sem.)", 3, 5, [6, -1, 5, -1, -1]);
    createSubject("WEB I", "Semestral (1er sem.)", 3, 4, [-1, 8, -1, 7, -1]);
    createSubject("SO", "Semestral (1er sem.)", 3, 5, [6, -1, 5, -1, -1]);
    createSubject("METODOLOGÍA DEL SOFTWARE I", "Semestral (1er sem.)", 3, 4, [5, -1, 5, -1, -1]);
    createSubject("INTERCONEXIÓN DE REDES DE DATOS", "Semestral (1er sem.)", 3, 4, [-1, 5, -1, -1, 6]);
    createSubject("ADMINISTRACIÓN Y DISEÑO DE SISTEMAS", "Semestral (1er sem.)", 3, 6, [7, -1, 7, -1, 7]);
    createSubject("SOA", "Semestral (2ndo sem.)", 3, 4, [-1, -1, 6, -1, 5]);
    createSubject("WEB II", "Semestral (2ndo sem.)", 3, 5, [-1, -1, -1, 7, 7]);
    createSubject("PERIFERICOS", "Semestral (2ndo sem.)", 3, 4, [8, 8, -1, -1, -1]);
    createDoubleHourSubject("LENGUAJES DE PROGRAMACION", "Semestral (2ndo sem.)", 3, 6, 5, [6, 7]);
    createDoubleHourSubject("PROGRAMACION DE GRAFICOS 3D", "Semestral (1er sem.)", 2, 5, 4, [0, 1]);
    createDoubleHourSubject("OM", "Semestral (2ndo sem.)", 3, 3, 1, [5, 6]);
    createDoubleHourSubject("SISTEMAS BASADOS EN EL CONOCIMIENTO", "Semestral (2NDO sem.)", 3, 4, 4, [5, 6]);

    //ASIGNATURAS DE 4O
    createSubject("METODOLOGÍA DEL SOFTWARE II", "Semestral (1er sem.)", 4, 4, [6, -1, -1, -1, 5]);
    createSubject("PROYECTOS EN ARQUITECTURA DISTRIBUIDA", "Semestral (1er sem.)", 4, 4, [5, -1, -1, 5, -1]);
    createSubject("SEGURIDAD EN LAS TIC", "Semestral (2ndo sem.)", 4, 4, [5, 5, -1, -1, 5]);
    createSubject("ENTREPENEURSHIP", "Semestral (2ndo sem.)", 4, 3, [-1, -1, -1, 5, -1]);
    createDoubleHourSubject("PROGRAMACION DE DISPOSITIVOS MOVILES", "Semestral (1er sem.)", 4, 4, 2, [5, 6]);
    createDoubleHourSubject("PROJECT MANAGMENT", "Semestral (1er sem.)", 4, 3, 3, [5, 6]);
    createDoubleHourSubject("ARQUITECTURA DE COMPUTADORES", "Semestral (1er sem.)", 4, 5, 5, [6, 7]);
    createDoubleHourSubject("MINERIA DE DATOS", "Semestral (1er sem.)", 4, 5, 4, [6, 7]);
    createDoubleHourSubject("TENDENCIAS TECNOLÓGICAS", "Semestral (2ndo sem.)", 4, 4, 4, [6, 7]);
  }

  void createDoubleHourSubject(String nombre, String duracion, int curso, int creditos, int dia_semana, List<int> list){
    String name = nombre;
    Map<String, Object> map = new Map();
    map[ConstValues.SEMESTRE] = duracion; // Tipus d'assignatura
    map[ConstValues.CURS] = curso; // Curs
    map[ConstValues.CREDITOS] = creditos; // Num de credits

    Map<String, List<int>> horario = new Map<String, List<int>>(); // horario
    if(dia_semana == 1){
      List<int> horesDeClasseDilluns = new List<int>();// Dilluns
      horesDeClasseDilluns.add(list[0]);
      horesDeClasseDilluns.add(list[1]);
      horario[ConstValues.DAY_L] = horesDeClasseDilluns;

      List<int> horesDeClasseAltres = new List<int>();
      horario[ConstValues.DAY_M] = horesDeClasseAltres;
      horario[ConstValues.DAY_X] = horesDeClasseAltres;
      horario[ConstValues.DAY_J] = horesDeClasseAltres;
      horario[ConstValues.DAY_V] = horesDeClasseAltres;
    }

    if(dia_semana == 2){
      List<int> horesDeClasseDilluns = new List<int>();//Martes
      horesDeClasseDilluns.add(list[0]);
      horesDeClasseDilluns.add(list[1]);
      horario[ConstValues.DAY_M] = horesDeClasseDilluns;

      List<int> horesDeClasseAltres = new List<int>();
      horario[ConstValues.DAY_L] = horesDeClasseAltres;
      horario[ConstValues.DAY_X] = horesDeClasseAltres;
      horario[ConstValues.DAY_J] = horesDeClasseAltres;
      horario[ConstValues.DAY_V] = horesDeClasseAltres;
    }

    if(dia_semana == 3){
      List<int> horesDeClasseDilluns = new List<int>();//Miercoles
      horesDeClasseDilluns.add(list[0]);
      horesDeClasseDilluns.add(list[1]);
      horario[ConstValues.DAY_X] = horesDeClasseDilluns;

      List<int> horesDeClasseAltres = new List<int>();
      horario[ConstValues.DAY_M] = horesDeClasseAltres;
      horario[ConstValues.DAY_L] = horesDeClasseAltres;
      horario[ConstValues.DAY_J] = horesDeClasseAltres;
      horario[ConstValues.DAY_V] = horesDeClasseAltres;
    }

    if(dia_semana == 4){
      List<int> horesDeClasseDilluns = new List<int>();//Jueves
      horesDeClasseDilluns.add(list[0]);
      horesDeClasseDilluns.add(list[1]);
      horario[ConstValues.DAY_J] = horesDeClasseDilluns;

      List<int> horesDeClasseAltres = new List<int>();
      horario[ConstValues.DAY_M] = horesDeClasseAltres;
      horario[ConstValues.DAY_X] = horesDeClasseAltres;
      horario[ConstValues.DAY_L] = horesDeClasseAltres;
      horario[ConstValues.DAY_V] = horesDeClasseAltres;
    }

    if(dia_semana == 5){
      List<int> horesDeClasseDilluns = new List<int>();//Viernes
      horesDeClasseDilluns.add(list[0]);
      horesDeClasseDilluns.add(list[1]);
      horario[ConstValues.DAY_V] = horesDeClasseDilluns;

      List<int> horesDeClasseAltres = new List<int>();
      horario[ConstValues.DAY_M] = horesDeClasseAltres;
      horario[ConstValues.DAY_X] = horesDeClasseAltres;
      horario[ConstValues.DAY_J] = horesDeClasseAltres;
      horario[ConstValues.DAY_L] = horesDeClasseAltres;
    }

    map[ConstValues.HORARIO] = horario;

    Subject subject = new Subject(name);
    subject.data = map;

    HomePage.dataBase[name] = subject;
  }

  void createSubject(String nombre, String duracion, int curso, int creditos, List<int> list) {
    String name = nombre;
    Map<String, Object> map = new Map();
    map[ConstValues.SEMESTRE] = duracion; // Tipus d'assignatura
    map[ConstValues.CURS] = curso; // Curs
    map[ConstValues.CREDITOS] = creditos; // Num de credits

    Map<String, List<int>> horario = new Map<String, List<int>>(); // horario
    if (list[0] == -1){
      List<int> horesDeClasseDilluns = new List<int>();// Dilluns
      horario[ConstValues.DAY_L] = horesDeClasseDilluns;
    }else{
      List<int> horesDeClasseDilluns = new List<int>();// Dilluns
      horesDeClasseDilluns.add(list[0]);
      horario[ConstValues.DAY_L] = horesDeClasseDilluns;
    }

    if (list[1] == -1){
      List<int> horesDeClasseDimarts = new List<int>();// Dimarts
      horario[ConstValues.DAY_M] = horesDeClasseDimarts;
    }else{
      List<int> horesDeClasseDimarts = new List<int>();// Dimarts
      horesDeClasseDimarts.add(list[1]);
      horario[ConstValues.DAY_M] = horesDeClasseDimarts;
    }

    if (list[2] == -1){
      List<int> horesDeClasseDimecres = new List<int>();// Dimecres
      horario[ConstValues.DAY_X] = horesDeClasseDimecres;
    }else{
      List<int> horesDeClasseDimecres = new List<int>(); // DImecres
      horesDeClasseDimecres.add(list[2]);
      horario[ConstValues.DAY_X] = horesDeClasseDimecres;
    }

    if (list[3] == -1){
      List<int> horesDeClasseDijous = new List<int>();// Dijous
      horario[ConstValues.DAY_J] = horesDeClasseDijous;
    }else{
      List<int> horesDeClasseDijous = new List<int>(); // Dijous
      horesDeClasseDijous.add(list[3]);
      horario[ConstValues.DAY_J] = horesDeClasseDijous;
    }

    if (list[4] == -1){
      List<int> horesDeClasseDijous = new List<int>();// Divendres
      horario[ConstValues.DAY_V] = horesDeClasseDijous;
    }else{
      List<int> horesDeClasseDivendres = new List<int>(); // Divendres
      horesDeClasseDivendres.add(list[4]);
      horario[ConstValues.DAY_V] = horesDeClasseDivendres;
    }

    map[ConstValues.HORARIO] = horario;

    Subject subject = new Subject(name);
    subject.data = map;

    HomePage.dataBase[name] = subject;
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
                          [ADD1] añadir listado de asignaturas
                          [INFO] información
                          [SHOW] mostrar horario
                          [ENDD] información

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

            }else if(action == ConstValues.ADDONE){ // Afegim asignatures
                          // (en veritat són varies assignatures, però així diferenciem)
              // PAS 1.2
//              WeekSchedule schedule = HomePage.studentSchedule;
              List<String> asignaturas = getAssignaturas(botMessage, index + 1);
              String assignatura = "";
              int i = 0;
              print("Resposta del bot: " + botMessage);
              while(i < asignaturas.length){
                //index++;
                //assignatura = getWord(botMessage, index);
                assignatura = asignaturas.elementAt(i);
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
                i++;
              }

              mostrarMensajeQueMas();

            }else if(action == ConstValues.INFORMATION) { // Demanem info d'una asignatura
              // PAS 1.3

              String assignatura = getWord(botMessage, index + 1);
              index = index + 2 + assignatura.length;
              print("Asignatura para info: " + assignatura);

              String atributo = getWord(botMessage, index);
              print("Atributo pedido: " + atributo);

              /*
              static const String SEMESTRE = "SEMESTRE";
      static const String CURS = "CURS";
      static const String CREDITOS = "CREDITOS";
      static const String HORARIO = "HORARIO";
               */
              switch (atributo){
                case ConstValues.SEMESTRE:
                  muestraTemporalidadAsignatura(assignatura);
                  break;
                case ConstValues.CURS:
                  muestraCursoAsignatura(assignatura);
                  break;
                case ConstValues.CREDITOS:
                  muestraCreditosAsignatura(assignatura);
                  break;
                case ConstValues.HORARIO:
                  muestraHorarioAsignatura(assignatura);
                  break;
              }

              print("Resposta del bot: " + botMessage);


              sendMessage("QUIERES INFO");
              //mostrarMensajeQueMas();

            }else{ // Demanem acabar (descarregar horari i tancar conversacio )
              // PAS 1.4
              sendMessage("QUIERES ACABAR");
              print("Resposta del bot: " + botMessage);
            }
          }

          String resposta = response.getMessage().substring(6, response.getMessage().length);
          print("Resposta: " + resposta);
        }

    }

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

  void mostrarMensajeQueMas() {
    String whatMoreMessage = "Qué más deseas hacer?\n"
        "Puedes pedirme cosas como información respecto alguna asignatura (créditos, temporalidad...), "
        "añadir más asignaturas\n"
        "Si quieres puedo mostrarte el horario construido hasta el momento...\n"
        "También puedes terminar la conversación y te daré tu horario.";
    sendMessage(whatMoreMessage);
  }

  void muestraTemporalidadAsignatura(String assignatura) {
      String temporalidad = HomePage.dataBase[assignatura].data[ConstValues.SEMESTRE];
      sendMessage(temporalidad);
  }

  void muestraCursoAsignatura(String assignatura) {

  }

  void muestraCreditosAsignatura(String assignatura) {

  }

  void muestraHorarioAsignatura(String assignatura) {

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
  if(botMessage[initialIndex] == ","){
    initialIndex += 2;
  }
  String word = "";
  int index = initialIndex;
  while (index < botMessage.length && botMessage[index] != " "){
    if(botMessage[index] == ","){
      break;
    }
    word = word + botMessage[index];
    index++;
  }
  return word;
}

List<String> getAssignaturas(String botMessage, int initialIndex) {
  List<String> asignaturas = new List<String>();
  String asignatura = "";
  while(initialIndex < botMessage.length){
    if(botMessage[initialIndex] == ","){
      if(asignatura != "y"){
        asignaturas.add(asignatura);
        asignatura = "";
      }
      initialIndex++;
      initialIndex++;
    }else if(botMessage[initialIndex] == " "){
      if(asignatura != "y"){
        asignaturas.add(asignatura);
      }
      asignatura = "";
      initialIndex++;
    }else{
      asignatura += botMessage[initialIndex];
      initialIndex++;
    }
  }
  asignaturas.add(asignatura);
  return asignaturas;
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