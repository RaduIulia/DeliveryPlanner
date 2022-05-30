package org.example.Entity;

public class Warehouses {
    int id = 0;
    String name;
    int id_strada;

    public Warehouses(int id, String name,int id_strada) {
        this.id = id;
        this.name = name;
        this.id_strada=id_strada;
    }

    public Warehouses(String name, int id_strada) {
        id++;
        this.name = name;
        this.id_strada=id_strada;
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

    public int getId_strada(){return id_strada;}

    public void setId_strada(int id_strada){ this.id_strada=id_strada;}
}
