package org.example.DAO;

import oracle.jdbc.OracleTypes;

import java.sql.*;
import java.util.Scanner;

public class Find {
    static Scanner scanner = new Scanner(System.in);
    public static void findStreetById(Connection connection) throws SQLException {
        System.out.println("id: ");
        int id = Integer.parseInt(scanner.nextLine());
        CallableStatement callableStatement = connection.prepareCall("begin ? := findStreetById(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.VARCHAR);
        callableStatement.setInt(2, id);
        callableStatement.execute();

        String result = callableStatement.getString(1);

        System.out.println(result);
    }
    public static void findStreetByName(Connection connection) throws SQLException{
        System.out.println("Street name: ");
        String name = scanner.nextLine();

        CallableStatement callableStatement = connection.prepareCall("begin ? := findStreetByName(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "STRING_ARRAY");
        callableStatement.setString(2, name);
        callableStatement.execute();

        Array result = callableStatement.getArray(1);

        Object obj = result.getArray();

        Object [] objectArray = (Object []) obj;   // cast it to an array of objects

        StringBuffer buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));
//        System.out.println(objectArray.length);
        for (int j = 1; j < objectArray.length; j++)
        {
            buffer.append("\n").append(String.valueOf(objectArray[j]));

        }
        System.out.println(buffer);
    }
    public static void findStreetByCost(Connection connection) throws SQLException{
        System.out.println("cost: ");
        int cost = Integer.parseInt(scanner.nextLine());

        CallableStatement callableStatement = connection.prepareCall("begin ? := findStreetByCost(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "NUME_ARRAY");
        callableStatement.setInt(2, cost);
        callableStatement.execute();

        Array result = callableStatement.getArray(1);

        Object obj = result.getArray();

        Object [] objectArray = (Object []) obj;   // cast it to an array of objects

        StringBuffer buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));
        System.out.println(objectArray.length);
        for (int j = 1; j < objectArray.length; j++)
        {
            buffer.append("\n").append(String.valueOf(objectArray[j]));

        }
        System.out.println(buffer);
    }
    public static void findStreetByIntersections(Connection connection) throws SQLException{
        System.out.println("Street name: ");
        String name = scanner.nextLine();

        CallableStatement callableStatement = connection.prepareCall("begin ? := findStreetByIntersections(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "STRING_ARRAY");
        callableStatement.setString(2, name);
        callableStatement.execute();

        Array result = callableStatement.getArray(1);

        Object obj = result.getArray();

        Object [] objectArray = (Object []) obj;   // cast it to an array of objects

        StringBuffer buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));
//        System.out.println(objectArray.length);
        for (int j = 1; j < objectArray.length; j++)
        {
            buffer.append("\n").append(String.valueOf(objectArray[j]));

        }
        System.out.println(buffer);
    }

    public static String findNameById(Connection connection, int id) throws SQLException{

        String sql = "SELECT * FROM streets WHERE id = ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, id);

        ResultSet rs = pstatement.executeQuery();
        String keep = "";
        while(rs.next()){
            keep = rs.getString(2);
        }
        pstatement.close();
        return keep;
    }
    public static int findCostById(Connection connection, int id) throws SQLException{

        String sql = "SELECT * FROM streets WHERE id = ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, id);

        ResultSet rs = pstatement.executeQuery();
        int keep = -1;
        while(rs.next()){
            keep = rs.getInt(3);
        }
        pstatement.close();
        return keep;
    }

    public static String findNameById2(Connection connection, int id) throws SQLException{

        String sql = "SELECT * FROM items WHERE id = ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, id);

        ResultSet rs = pstatement.executeQuery();
        String keep = "";
        while(rs.next()){
            keep = rs.getString(2);
        }
        pstatement.close();
        return keep;
    }
    public static int findCostById2(Connection connection, int id) throws SQLException{

        String sql = "SELECT * FROM items WHERE id = ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, id);

        ResultSet rs = pstatement.executeQuery();
        int keep = -1;
        while(rs.next()){
            keep = rs.getInt(3);
        }
        pstatement.close();
        return keep;
    }
    public static String findWarehouseNameById(Connection connection, int id) throws SQLException{

        String sql = "SELECT * FROM warehouses WHERE id = ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, id);

        ResultSet rs = pstatement.executeQuery();
        String keep = "";
        while(rs.next()){
            keep = rs.getString(2);
        }
        pstatement.close();
        return keep;
    }

    public static int findWarehouseAdressById(Connection connection, int id) throws SQLException {
        String sql = "SELECT * FROM warehouses WHERE id = ?";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, id);

        ResultSet rs = pstatement.executeQuery();
        String keep = "";
        while(rs.next()){
            keep = rs.getString(3);
        }
        pstatement.close();
        return Integer.parseInt(keep);
    }
}