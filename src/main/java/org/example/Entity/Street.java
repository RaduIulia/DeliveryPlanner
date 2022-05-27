package org.example.Entity;

import com.github.javafaker.Faker;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class Street {
    int id = 0;
    String name;
    int cost;
    int[] adjacency;

    public Street(String name, int cost, int[] adjacency) {
        id++;
        this.name = name;
        this.cost = cost;
        this.adjacency = adjacency;
    }
    public Street(int id, String name, int cost, int[] adjacency) {
        this.id = id;
        this.name = name;
        this.cost = cost;
        this.adjacency = adjacency;
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

    public int getCost() {
        return cost;
    }

    public int[] getAdjacency() {
        return adjacency;
    }

    public List<String> neighborhood(List<Street> streetList){
        streetList.removeAll(Collections.singleton(null));
        List<String> ddd = new LinkedList<>();

        int i = 0;
        for(Street st : streetList){
            if(adjacency[i] == 1 && st.getName() != null) {
                ddd.add(st.getName() + " - " + st.getCost());
            }
            i++;
        }

        return ddd;
    }

    public List<Intersection> getIntersections(List<Street> streetList){
        List<Intersection> intersections = new LinkedList<>();
        Faker faker = new Faker();

        int i = 0;
        for(Street st : streetList){
            if(adjacency[i] == 1 && st.getName() != null) {
                intersections.add(new Intersection(faker.address().streetName(), Collections.singletonList(st.getName())));
            }
            i++;
        }
        return intersections;
    }
    public static void calculate(int[][] matrix){ // TODO : not working properly
        int i, j;
        int[][] test = matrix;
        int count = 10;
        for(i = 0; i < 10; i++) {
            for (j = 0; j < 10; j++)
                System.out.print(test[i][j] + " ");
            System.out.println("");
        }
        System.out.println("\n\n");
        for(i = 0; i < 10; i++) {
            int[] keep = matrix[i];
            for (j = 0; j < 10; j++) {
                if (matrix[i][j] == 1) {
                    for (int k = i; k < j; k++) {
                        if (keep[k] == 1 && matrix[k][j] != 1) {
                            test[i][j] = test[j][i] = count;
                            count++;
                        }
                    }
                }
            }
        }

        for(i = 0; i < 10; i++) {
            for (j = 0; j < 10; j++)
                System.out.print(test[i][j] + " ");
            System.out.println();
        }
    }
}
