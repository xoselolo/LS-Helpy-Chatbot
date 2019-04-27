

class Subject{
  static const String CREDITOS = "creditos";

  // Attributes
  String name;
  Map<String, Object> data;

  Subject(String name){
    this.name = name;
    data = new Map<String, Object>();
  }

}


class DaySchedule {
  static const int MAX_HORES = 9;

  List<Subject> hores;

  DaySchedule(){
    this.hores = new List<Subject>(MAX_HORES);
  }

  // Funtions
  bool isFree(int index){
    return hores.elementAt(index) == null;
  }
  Subject elementAt(int index){
    return hores.elementAt(index);
  }
  void addSubject(Subject subject, int hora){
    hores.removeAt(hora);
    hores.insert(hora, subject);
  }
}

class WeekSchedule {
  static const int MAX_DAYS = 5;

  List<DaySchedule> dies;

  WeekSchedule(){
    dies = new List<DaySchedule>();
    for(int i = 0; i < 5; i++){
      dies.add(new DaySchedule());
    }
  }

  bool isFree(int dia, int hora){
    return dies.elementAt(dia).elementAt(hora) == null;
  }
  DaySchedule getDia(int dia){
    return dies.elementAt(dia);
  }
  void addSubject(Subject subject, int dia, int hora){
    dies.elementAt(dia).addSubject(subject, hora);
  }

}