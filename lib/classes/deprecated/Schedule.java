package classes.deprecated;

public class Schedule {
    // Const values
    public static final int MAX_HORES = 9;

    // Attributes
    private Subject[] hora;

    // Constructor
    public Schedule(){
        this.hora = new Subject[MAX_HORES];
    }

    // Getters & Setters
    public Subject[] getHora() {
        return hora;
    }
    public void setHores(Subject[] hores) {
        this.hora = hores;
    }

    // Methods & Functions
    public boolean isFree(int indexHora){
        return this.hora[indexHora] == null;
    }
    public void addSubject(Subject subject, int indexHora){
        this.hora[indexHora] = subject;
    }
}
