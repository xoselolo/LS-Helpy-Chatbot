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
    String descripcion;
    //asignaturas de 1o
    descripcion = "La asignatura está pensada para cualquier estudiante de primer curso de una Ingeniería. Se trata de una introducción al mundo de la programación de ordenadores. Se estudian los conceptos elementales como son el de ordenador y el de lenguaje de programación. Toda la introducción a la algorítmica se realiza mediante un lenguaje de pseudocódigo, que nos permite discernir los conceptos teóricos de aquellos que son claramente prácticos, relacionados con los lenguajes de programación.";
    createSubject("PROG", "Anual", 1, 10, [1, -1, 1, -1, 1], "DAVID VERNET BELLET", descripcion);

    descripcion = "La asignatura pretende iniciar al alumno en el funcionamiento de los ordenadores y se estructura en cuatro partes. En la primera parte se estudia álgebra de Boole para entender la representación de la información en los computadores. En la segunda parte se dan a conocer los sistemas combinacionales y la aritmética binaria, los circuitos digitales más básicos de un computador. En la tercera parte se estudia la base del funcionamiento de la unidad de control de los ordenadores y como se memoriza la información. En la cuarta y última parte se estudian pequeños sistemas secuenciales que forman las unidades de control de los computadores";
    createSubject("IO", "Anual", 1, 9, [3, -1, 0, 0, 0], "IGNACIO BLÁZQUEZ GARCÍA", descripcion);

    descripcion = "La asignatura tiene dos partes, la teórica y la práctica que se ha de aprobar por separado. La parte teórica consiste en trabajar la parte escrita y oral del alumno y su capacidad de comprensión. La parte práctica consiste en asistir a una conferencia semanal dirigida por un profesor especializado en las áreas d´economía, ingeniería o gestión y entregar 2 trabajos por trimestre.";
    createSubject("BUSINESS", "Anual", 1, 4, [0, -1, 4, -1, -1], "LISA KINNEAR", descripcion);

    descripcion = "En esta asignatura se presentan al alumno los temas clásicos de un primer curso de álgebra lineal. Se intenta, sin embargo, que el alumno no sólo asimile los conceptos teóricos adecuadamente, sino que también los asocie con situaciones y problemas reales del mundo técnico. Es decir, se hace mucho énfasis en que el alumno vea el álgebra como una herramienta más para solucionar problemas reales.";
    createSubject("ALGEBRA", "Anual", 1, 8, [-1, -1, 2, -1, 2], "JOSÉ ANTONIO MONTERO MORALES", descripcion);

    createSubject("PIC1", "Anual", 1, 2, [-1, -1, -1, 3, -1], "DAVID CASADO REDON", "No hay una descripcion para esta asignatura");

    descripcion = "En esta asignatura se presentan al alumno los temas básicos de análisis matemático que cualquier ingeniero/a requiere para la comprensión de los conceptos de la carrera. Esta asignatura es prerrequisito de la asignatura de Estadística y análisis matemático, de 2o curso de Ingeniería y de otras asignaturas dependiendo de la ingeniería cursada. Se intenta que el alumno no se quede sólo con las definiciones y demostraciones teóricas, sino que sepa aplicar estos conocimientos a la resolución de problemas. Con este propósito se hacen sesiones de ejercicios por parte del profesor.";
    createSubject("CALCULO", "Anual", 1, 10, [2, 3, -1, 2, -1], "IGNASI IRIONDO", descripcion);

    descripcion = "La asignatura se basa en los conceptos básicos de usabilidad aplicados a Internet, móvil quioscos interactivos, etc. y en técnicas de evaluación con usuarios para un diseño centrado en el usuario (DCU), así como en conceptos de diseño gráfico y en la utilización de los programas necesarios para lograr con éxito toda creación digital.";
    createSubject("DIU", "Anual", 1, 5, [-1, 1, -1, -1, -1], "EVA VILLEGAS PORTERO", descripcion);

    descripcion = "Primero se ven los fundamentos básicos de la electrónica, así como las técnicas necesarias para el análisis de circuitos en dominio temporal. Posteriormente se estudian diferentes componentes electrónicos (resistores lineales y no lineales, condensadores, bobinas, transformadores, díodos, transistores,...) tanto a nivel ideal como real, referenciando estos estudios a documentación actualizada de distintos fabricantes.";
    createSubject("ELECTRO", "Anual", 1, 12, [-1, -1, -1, 3, -1], "XAVIER SENMARTI SENMARTI", descripcion);



    //asignaturas de 2o
    descripcion = "La asignatura divide sus contenidos en dos partes claramente diferenciadas: - En la primera parte se trabaja el análisis algorítmico (costes, casos, notación asintótica, resolución de recurrencias simples), la especificación y la verificación formal de algoritmos recursivos simples. Se introduce el análisis de la eficiencia de los programas como un criterio más de calidad. Se estudia también el diseño de algoritmos recursivos simples y múltiples, y varias técnicas de resolución de problemas combinatorios. - En la segunda parte, se introduce el concepto y especificación de tipos abstractos de datos como estructuras de datos lineales, árboles, tablas y grafos.";
    createSubject("PAED", "Anual", 2, 8, [-1, -1, 4, 4, 4], "XAVIER SOLÉ BETETA", descripcion);

    descripcion = "La asignatura da una visión avanzada de las herramientas matemáticas que una titulación tecnológica requiere. Consta de tres capítulos: Las ecuaciones diferenciales, las funciones de varias variables, y la probabilidad y la estadística. En el capítulo de ecuaciones diferenciales se estudia la formación, uso y resolución de las ecuaciones diferenciales ordinarias. En el capítulo de funciones de varias variables se estudian el cálculo de límites, derivadas parciales, diferenciales, ecuaciones con derivadas parciales, cambios de variable, gradientes, máximos y mínimos condicionados y la integración múltiple (integrales dobles y triples). ";
    createSubject("MATES", "Anual", 2, 8, [3, 0, 3, 2, 0], "XAVIER SEVILLANO DOMÍNGUEZ", descripcion);

    descripcion = "Los descriptores generales de contenidos de la asignatura son: - Introducción a la Orientación a Objetos - Características de la Orientación a Objetos - Análisis Orientado a Objetos - Diseño Orientado a Objetos - Implementación en Lenguaje Java - Patrones de diseño (GRASP, MVC y GOF) - Estructuras de datos lineales - Bases de datos - Diagrama de actividades - Diagrama de secuencia - Diagrama de paquetes - Diagrama de clases";
    createSubject("DPOO", "Anual", 2, 6, [1, 0, 1, 0, 0], "EDUARD DE TORRES GÓMEZ", descripcion);

    descripcion = "En esta asignatura se explican las técnicas y la metodología para el diseño de sistemas digitales. Se inicia con el estudio de sistemas secuenciales. A partir de estos sistemas el alumno puede abordar el diseño de sistemas digitales síncronos de proceso específico. Seguidamente, se estudia el diseño de sistemas con microprocesadores y microcontroladores.";
    createSubject("COMPUS", "Anual", 2, 9, [-1, 3, 2, -1, 2], "JOAN NAVARRO MARTÍN", descripcion);

    createSubject("PIC2", "Anual", 2, 2, [4, -1, -1, -1, -1], "DAVID CASADO REDON", "No hay descripción disponible para esta asignatura");

    descripcion = "En esta asignatura se pretende dar una visión amplia sobre las redes de comunicaciones y conseguir que el alumno se familiarice con conceptos y aplicaciones relacionadas con el campo de la telemática y las redes de ordenadores, especialmente enfocado a las redes de área local. Es por ello que la primera parte del curso permite introducir conceptos generales de las redes de datos y se profundiza en la arquitectura OSI, así como en la arquitectura TCP/IP";
    createSubject("XARXES", "Anual", 2, 6, [-1, 2, -1, 3, -1], "GUIOMAR CORRAL TORRUELLA", descripcion);

    descripcion = "Se tratan los conceptos básicos de archivos, conceptualización y caracterización de las estructuras de acceso a la memoria secundaria. Introducción a los sistemas gestores de bases de datos: conceptos i tipología, evolución histórica y sus lenguajes de acceso y principales funciones. Se introduce una prospectiva de las bases de datos orientadas a objetos. Asimismo se trabaja sobre el modelo de datos corporativo. Modelo E/R. Paso del modelo conceptual a la implementación.";
    createSubject("BASES", "Anual", 2, 5, [2, -1, -1, -1, 1], "JOAN NAVARRO MARTÍN", descripcion);

    descripcion = "En el competitivo mundo empresarial de hoy, se hace muy difícil crecer de manera sana y constante. Podemos ver que incluso algunas empresas luchan simplemente por sobrevivir. Con el fin de poder asegurar su futuro, la empresa debe gozar de una buena salud financiera. Sin una adecuada gestión económica de la empresa, probablemente la compañía desaparecerá.";
    createSubject("VALUE", "Anual", 2, 4, [1, 0, -1, -1, 1], "JOSEP PETCHAMÉ SABARTÉS", descripcion);

    descripcion = "La programación es una ciencia principalmente práctica, y como la mayoría de ciencias prácticas, esta se estructura en proyectos. Esta es la premisa de la cual parte la asignatura de Proyectos de Programación 1. El objetivo de la asignatura es profundizar en el mundo de la programación a través del desarrollo de prácticas y proyectos que permitan que el aprendizaje sea dinámico, práctico, auto-didáctico y colaborativo";
    createSubject("PPROG1", "Semestral (1er sem.)", 2, 3, [-1, 1, -1, -1, 3], "EDUARD DE TORRES GÓMEZ", descripcion);

    descripcion = "La programación es una ciencia principalmente práctica y, como la mayoría de ciencias prácticas, esta se estructura en proyectos. Esta es la premisa de la cual parte la asignatura de Proyectos de Programación 2. El objetivo principal de la asignatura es ampliar los conocimientos de los alumnos en el campo de la programación, presentándolos un nuevo ámbito: la programación para dispositivos móviles. Dado que el mundo de la programación para dispositivos móviles es muy amplio, la asignatura se centrará en el sistema que, de momento, tiene una mayor presencia en el mercado. Este sistema es Android. ";
    createSubject("PPROG2", "Semestral (2ndo sem.)", 2, 4, [-1, 1, -1, -1, 3], "ALFREDO RUEDA", descripcion);

    descripcion = "En esta asignatura se pretende que el alumno sea capaz de programar un sistema de visualización de gráficos 3D en tiempo real y que comprenda los cálculos y conceptos teóricos en que se basan sus algoritmos.";
    createDoubleHourSubject("GRAFICOS3D", "Semestral (1er sem.)", 2, 5, 4, [0, 1], "ALUN THOMAS EVANS", descripcion);



    //asignaturas de 3o
    createSubject("PIC3", "Anual", 3, 3, [-1, 1, 3, -1, -1], "DAVID CASADO REDON", "No hay descripción disponible de la asignatura");

    descripcion = "n sistema operativo es una capa de software que se ejecuta sobre un hardware con el objetivo de proporcionar una serie de servicios. El objetivo de la asignatura es dar a conocer un sistema operativo en todas sus partes y, de este modo, dotar al alumno de conocimientos sobre uno de los componentes más importantes en los sistemas informáticos hoy en día. Desde el punto de vista práctico, se realizan prácticas que implementan diversas funcionalidades, políticas o técnicas de un sistema operativo. ";
    createSubject("SO", "Semestral (1er sem.)", 3, 5, [6, -1, 5, -1, -1], "XAVIER CANALETA", descripcion);

    descripcion = "Esta asignatura se centra en el diseño de arquitecturas software para el desarrollo de aplicaciones interactivas con interficie de usuario independientes de plataformas o frameworks de desarrollo. La primera parte del curso plantea los principios esenciales del diseño de arquitecturas orientadas a objetos, así como el uso de patrones, buenas prácticas de diseño y metodologías para la planificación y gestión de los diferentes ciclos de vida del software. Paralelamente se abordan los fundamentos básicos de las plataformas Java y .NET, y cada semana se estudian conceptos más avanzados hasta acabar el curso, de manera que el alumno habrá aprendido a crear cualquier aplicación de escritorio con interficie gráfica y conectividad de red. ";
    createSubject("WEB1", "Semestral (1er sem.)", 3, 4, [-1, 8, -1, 7, -1], "DANIEL AMO FILVÀ", descripcion);

    descripcion = "Un sistema operativo es una capa de software que se ejecuta sobre un hardware para ofrecer una serie se servicios. En la asignatura de Sistemas Operativos se ve un sistema operativo en todas sus partes y se profundiza en el núcleo del sistema, poniendo especial atención en el multiprocesamiento, concurrencia y también en los mecanismos de comunicación entre procesos y exclusión mutua. El objetivo de la asignatura de Sistemas Operativos Avanzados será profundizar en los dos subtemas fundamentales del sistema operativo como son el sistema de ficheros y el sistema de administración de memoria. ";
    createSubject("SOA", "Semestral (2ndo sem.)", 3, 4, [-1, -1, 6, -1, 5], "ALFREDO RUEDA UNSAIN", descripcion);

    descripcion = "No hay descripción disponible de la asignatura";
    createSubject("METODOLOGIA1", "Semestral (1er sem.)", 3, 4, [5, -1, 5, -1, -1], "MARC CAMPMANY LLORENS", descripcion);

    descripcion = "La asignatura forma al alumno en las tecnologías WAN que permiten la interconexión de redes a nivel global, las redes troncales y las redes de acceso, así como en el diseño de redes globales dentro de entornos totalmente heterogéneos con aplicación de tecnologías de calidad de servicios (QoS) que permiten la integración de todo tipo de servicios.";
    createSubject("INTERCONE", "Semestral (1er sem.)", 3, 4, [-1, 5, -1, -1, 6], "JAUME ABELLA", descripcion);

    descripcion = "En la asignatura de Administración de Sistemas Operativos se dan los conocimientos básicos necesarios para administrar cualquier sistema servidor, tanto en lo referido al sistema operativo como a los servicios ofrecidos, profundizando especialmente en la administración de sistemas con sistemas operativos de la familia UNIX.";
    createSubject("ASO", "Semestral (1er sem.)", 3, 6, [7, -1, 7, -1, 7], "ALFREDO RUEDA UNSAIN", descripcion);

    descripcion = "La asignatura introduce al alumno en la manera actual de desarrollar aplicaciones web de cualquier magnitud. El alumno aprenderá cuál es el entorno de desarrollo actual para este tipo de aplicaciones y los pondrá en práctica cada día. Se analizarán también las tendencias tecnológicas del momento en este sector, con la finalidad de irlas incorporando en el currículum del alumno. ";
    createSubject("WEB2", "Semestral (2ndo sem.)", 3, 5, [-1, -1, -1, 7, 7], "JAUME CAPDEVILA", descripcion);

    descripcion = "La asignatura da una visión de los elementos de entrada / salida del computador más suscebtibles de ser manipulados por un programador. Para ello, en el primer tema se introducen los conceptos genéricos y se estudian las técnicas de sincronismo y de gestión de las transferencias de datos y en los siguientes se desarrollan las técnicas de acceso y control a los periféricos en base a la metodología de programación cooperativa propia de la Salle.";
    createSubject("PERIFERICOS", "Semestral (2ndo sem.)", 3, 4, [8, 8, -1, -1, -1], "JOSEP MARIA RIO DOVAL", descripcion);

    descripcion = "Al acabar el curso el alumno: -	Conoce los fundamentos básicos por la definición formal de lenguajes de programación. - Usa correctamente las técnicas para la implementación de lenguajes de programación. -	Conoce los diferentes paradigmas de programación. -	Tiene la capacidad suficiente para escoger el lenguaje de programación más adecuado por la resolución de un problema.";
    createDoubleHourSubject("COMPILADORES", "Semestral (2ndo sem.)", 3, 6, 5, [6, 7], "EDUARD FERNANDEZ ALONSO", descripcion);

    descripcion = "Primera visión empresarial para lograr los conocimientos básicos de la organización de empresa. Se imparten conceptos de Estrategia, Modelo de Negocio, Habilidades Directivas y Marketing.";
    createDoubleHourSubject("OM", "Semestral (2ndo sem.)", 3, 3, 1, [5, 6], "SÒNIA LUENGO ALVAREZ", descripcion);

    descripcion = "El objetivo de la asignatura es que el alumno adquiera los fundamentos teóricos y las habilidades prácticas para ser capaces de desarrollar un sistema basado en el conocimiento. Al finalizar la asignatura el alumno deberá ser capaz de recopilar y representar el conocimiento de un problema, así como desarrollar o adaptar motores existentes para razonar sobre el problema y resolverlos. Todo esto se aborda con el soporte de metodologías de ingeniería del software, así como el uso de implementaciones basadas en los motores de inferencias más extendidas.";
    createDoubleHourSubject("SBC", "Semestral (2NDO sem.)", 3, 4, 4, [5, 6], "ELISABET GOLOBARDES RIBÉ :D", descripcion);




    //ASIGNATURAS DE 4O
    descripcion = "La asignatura estudia la problemática del desarrollo de sistemas informáticos complejos y plantea la necesidad de acotar el desarrollo de dichos sistemas desde una perspectiva basada en la ingeniería. Se estudian técnicas de especificación de sistemas software (ERS) a nivel de análisis y de diseño. Se aplican técnicas para la construcción de aplicaciones tanto en entornos convencionales (estructurados) como en entornos orientados a objetos. ";
    createSubject("METODOLOGIA2", "Semestral (1er sem.)", 4, 4, [6, -1, -1, -1, 5], "MARC CAMPMANY LLORENS", descripcion);

    descripcion = "Esta asignatura se mueve en sintonía con el mercado de componentes y los entornos e desarrollo de aplicaciones sobre plataformas distribuidas. El objetivo principal es introducir al alumno en el paradigma de diseño, gestión y desarrollo de aplicaciones distribuidas y en los conceptos relacionados con el mercado de componentes, siempre manteniendo el punto de actualidad necesario.";
    createSubject("ARQ.DISTRIBUIDA", "Semestral (1er sem.)", 4, 4, [5, -1, -1, 5, -1], "JOAN NAVARRO MARTÍN", descripcion);

    descripcion = "Esta asignatura forma al alumno en el mundo de la Seguridad en las TIC a través del `Hacking Ético´. Es una asignatura puramente práctica que es desarrolla en los Laboratorios de Telemática.";
    createSubject("SEG.TIC", "Semestral (2ndo sem.)", 4, 4, [5, 5, -1, -1, 5], "JAUME ABELLA FUENTES", descripcion);

    descripcion = "Esta guía está diseñada para los estudiantes del curso de Emprendimiento e Innovación que no pueden asistir debido al trabajo u otros compromisos. Si bien se entiende que los estudiantes no asistirán a las clases regulares, están obligados a preparar las mismas tareas que los demás estudiantes en el curso con ciertas excepciones, los detalles se proporcionan a continuación. Además, mientras que las sesiones de clases especiales no están dispuestos debido a la dificultad de coordinar diferentes horarios, los estudiantes pueden hacer los arreglos para las reuniones cara a cara con el profesor hasta dos veces al mes para discutir el curso. El contenido del curso se publico en estudy, incluyendo el calendario, las tareas y las notas del Profesor.";
    createSubject("ENTREPENEURSHIP", "Semestral (2ndo sem.)", 4, 3, [-1, -1, -1, 5, -1], "PAUL FOX", descripcion);

    descripcion = "No hay descripción disponible de la asignatura";
    createDoubleHourSubject("IOS", "Semestral (1er sem.)", 4, 4, 2, [5, 6], "LUÍS MIGUEL MONTERO FARRERO", descripcion);

    descripcion = "La asignatura de Project Management da una visión práctica de la profesión de Project Manager, mostrando los conceptos, las herramientas y técnicas básicas para la planificación y seguimiento de proyectos, así como las habilidades y competencias requeridas para dicha profesión. Al final del curso, los estudiantes deben ser capaces de crear un Project Charter, una WBS, un Schedule, un Presupuesto y tener nociones de los Planes de Riesgo, Comunicación, Calidad y conocer el Seguimiento y el Cierre de un proyecto.";
    createDoubleHourSubject("PM", "Semestral (1er sem.)", 4, 3, 3, [5, 6], "SÒNIA LUENGO ALVAREZ", descripcion);

    descripcion = "La asignatura es una descripción de las técnicas relacionadas con la arquitectura de computadores. Des de un procesador básico, se introducen todas las técnicas que mejoran el rendimiento hasta llegar a un procesador actual.";
    createDoubleHourSubject("ARQUITECTURA", "Semestral (1er sem.)", 4, 5, 5, [6, 7], "ENRIQUE GIBERT CODINA", descripcion);

    descripcion = "La asignatura realiza una introducción a la minería de datos. La minería de datos es la disciplina que estudia la extracción de información útil de bases de datos. Hoy en día, las técnicas de minería de datos se usan en muchas aplicaciones diversas, tales como la predicción de fraude en transacciones de tarjetas de crédito, la segmentación de clientes para estudios de marketing o el diagnóstico médico. En este sentido, la minería de datos abarca un campo multi-disciplinar y de gran interés práctico.";
    createDoubleHourSubject("MINERIA", "Semestral (1er sem.)", 4, 5, 4, [6, 7], "LLUÍS FORMIGA FANALS", descripcion);

    descripcion = "Esta asignatura pretende mostrar métodos y tecnologías avanzadas en el mundo de la multimedia. Su enfoque es claramente divulgativo. Se pretende que los alumnos reciban una visión general de las líneas de investigación más importantes en el ámbito de las tecnologías multimedia en la actualidad.";
    createDoubleHourSubject("TEND.TECNOLOGICAS", "Semestral (2ndo sem.)", 4, 4, 4, [6, 7], "DAVID MIRALLES ESTEBAN", descripcion);
  }

  void createDoubleHourSubject(String nombre, String duracion, int curso, int creditos, int dia_semana, List<int> list, String profesor, String descripcion){
    String name = nombre;
    Map<String, Object> map = new Map();
    map[ConstValues.SEMESTRE] = duracion; // Tipus d'assignatura
    map[ConstValues.CURS] = curso; // Curs
    map[ConstValues.CREDITOS] = creditos; // Num de credits
    map[ConstValues.PROFESOR] = profesor;
    map[ConstValues.DESCRIPCION] = descripcion;


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

  void createSubject(String nombre, String duracion, int curso, int creditos, List<int> list, String profesor, String descripcion) {
    String name = nombre;
    Map<String, Object> map = new Map();
    map[ConstValues.SEMESTRE] = duracion; // Tipus d'assignatura
    map[ConstValues.CURS] = curso; // Curs
    map[ConstValues.CREDITOS] = creditos; // Num de credits
    map[ConstValues.PROFESOR] = profesor;
    map[ConstValues.DESCRIPCION] = descripcion;

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
                case ConstValues.PROFESOR:
                  muestraProfesorAsignatura(assignatura);
                  break;
                case ConstValues.DESCRIPCION:
                  muestraDescripcionAsignatura(assignatura);
                  break;
              }

              print("Resposta del bot: " + botMessage);
              
              //sendMessage("QUIERES INFO");
              mostrarMensajeQueMas();

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
      sendMessage("La asignatura " + assignatura + " es una asigatura " + temporalidad + ".");
  }

  void muestraCursoAsignatura(String assignatura) {
    String curso = HomePage.dataBase[assignatura].data[ConstValues.CURS];
    sendMessage(assignatura + " se cursa en " + curso + "º.");
  }

  void muestraCreditosAsignatura(String assignatura) {
    int creditos = HomePage.dataBase[assignatura].data[ConstValues.CREDITOS];
    sendMessage("La asignatura de " + assignatura + " tiene un total de " + creditos.toString() + " creditos.");
  }

  void muestraHorarioAsignatura(String assignatura) {

    String horarioTotal = "";
    Map<String, List<int>> horario = HomePage.dataBase[assignatura].data[ConstValues.HORARIO];
    for(int i = 0; i < 5; i++){
      String horarioDiaI = muestraHorarioDia(assignatura, horario, i);
      horarioTotal = horarioTotal + horarioDiaI;
      if(i != 4){
        horarioTotal = horarioTotal + "\n";
      }
    }
    
    sendMessage("Horario de la asignatura: " + assignatura + "\n"
        + horarioTotal);
  }

  void muestraProfesorAsignatura(String assignatura) {
    String profesor = HomePage.dataBase[assignatura].data[ConstValues.PROFESOR];
    sendMessage("El profesor de la asignatura de " + assignatura + " es: " + profesor);
  }

  void muestraDescripcionAsignatura(String assignatura) {
    String descripcion = HomePage.dataBase[assignatura].data[ConstValues.DESCRIPCION];
    sendMessage("Descripción de la asignatura: " + assignatura + "\n"
        + descripcion);
  }

  String muestraHorarioDia(String assignatura, Map<String, List<int>> horario, int i) {
    String horarioDia = "";
    List<int> horasDia;
    switch(i){
      case 0:
        horarioDia = ConstValues.DAY_L + ":\n";
        horasDia = horario[ConstValues.DAY_L];
        break;
      case 1:
        horarioDia = ConstValues.DAY_M + ":\n";
        horasDia = horario[ConstValues.DAY_M];
        break;
      case 2:
        horarioDia = ConstValues.DAY_X + ":\n";
        horasDia = horario[ConstValues.DAY_X];
        break;
      case 3:
        horarioDia = ConstValues.DAY_J + ":\n";
        horasDia = horario[ConstValues.DAY_J];
        break;
      default:
        horarioDia = ConstValues.DAY_V + ":\n";
        horasDia = horario[ConstValues.DAY_V];
        break;
    }

    if(horasDia.isEmpty){
      horarioDia = horarioDia + " - sin clases - \n";
    }else{
      for(int i = 0; i < horasDia.length; i++){
        int hora = horasDia.elementAt(i);
        String horaString = transformaHoraIndexAString(hora);
        horarioDia = horarioDia + horaString + "\n";
      }
    }

    return horarioDia;
  }

  String transformaHoraIndexAString(int hora) {
    switch(hora){
      case 0:
        return "8.00h a 9.20h";
        break;
      case 1:
        return "9.40h a 11.00h";
        break;
      case 2:
        return "11.10h a 12.30h";
        break;
      case 3:
        return "12.40h a 14.00h";
        break;
      case 4:
        return "14.05h a 15.25h";
        break;
      case 5:
        return "15.30h a 16.50h";
        break;
      case 6:
        return "17.00h a 18.20h";
        break;
      case 7:
        return "18.30h a 19.50h";
        break;
      case 8:
        return "20.00h a 21.20h";
        break;
    }
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