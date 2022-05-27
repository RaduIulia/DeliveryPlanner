package org.example.DAO;

import java.sql.*;
import java.util.Scanner;

public class Find {
    static Scanner scanner = new Scanner(System.in);
    public static void findStreetById(Connection connection) throws SQLException{
        System.out.println("Id: ");
        int id = Integer.parseInt(scanner.nextLine());
//        Statement statement = connection.createStatement();

        String sql = "SELECT * FROM streets WHERE id = ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, id);

        ResultSet rs = pstatement.executeQuery();

        while(rs.next()){
            for(int i = 1;i<5;i++)
                System.out.print(rs.getString(i) + " ");
        }
        System.out.println();
    }
    public static void findStreetByName(Connection connection) throws SQLException{
        System.out.println("Street name: ");
        String name = scanner.nextLine();

        String sql = "SELECT * FROM streets WHERE nume_strada like ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setString(1, '%' + name + '%');

        ResultSet rs = pstatement.executeQuery();

        while(rs.next()){
            for(int i = 1;i<5;i++)
                System.out.print(rs.getString(i) + " ");
        }
        System.out.println();
    }
    public static void findStreetByCost(Connection connection) throws SQLException{
        System.out.println("id: ");
        int cost = Integer.parseInt(scanner.nextLine());
//        Statement statement = connection.createStatement();

        String sql = "SELECT * FROM streets WHERE cost = ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, cost);

        ResultSet rs = pstatement.executeQuery();

        while(rs.next()){
            for(int i = 1;i<5;i++)
                System.out.print(rs.getString(i) + " ");
        }
        System.out.println();
    }
    public static void findStreetByIntersections(Connection connection) throws SQLException{
        System.out.println("Street name: ");
        String name = scanner.nextLine();

        String sql = "SELECT nume_strada FROM streets WHERE intersectare like ? ";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setString(1, '%' + name + '%');

        ResultSet rs = pstatement.executeQuery();

        while(rs.next()){
            System.out.print(rs.getString(1) + ", ");
        }
        System.out.println();
    }
}
