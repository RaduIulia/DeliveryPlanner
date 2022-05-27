package org.example.Entity;

import java.util.List;

public class Intersection {
    String name;
    List<String> streets;
    public Intersection(String streetName, List<String> streets) {
        name = streetName;
        this.streets = streets;
    }

    public String getName() {
        return name;
    }

    public List<String> getStreets() {
        return streets;
    }
    public void calculate(){

    }
}
