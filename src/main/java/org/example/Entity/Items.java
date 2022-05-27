package org.example.Entity;

public class Items {
    int id = 0;
    String name;
    int pret;

    public Items(int id, String name, int pret) {
        this.id = id;
        this.name = name;
        this.pret = pret;
    }

    public Items(String name, int pret) {
        id++;
        this.name = name;
        this.pret = pret;
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

    public int getPret() {
        return pret;
    }

    public void setPret(int pret) {
        this.pret = pret;
    }
}
