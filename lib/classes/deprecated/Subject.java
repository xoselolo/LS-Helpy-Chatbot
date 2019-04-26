package classes.deprecated;

import java.util.HashMap;

public class Subject {
    // Attributes of a subject
    private String name;
    private HashMap data;

    // Constructor
    public Subject(String name){
        this.name = name;
        this.data = new HashMap();
    }

    // Getters & Setters
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public HashMap getData() {
        return data;
    }
    public void setData(HashMap data) {
        this.data = data;
    }
}
