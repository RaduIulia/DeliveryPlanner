package org.example.Entity;

public class Warehouses {
    int id = 0;
    String name;

    public Warehouses(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Warehouses(String name) {
        id++;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
