package org.example.DAO;

import org.example.Entity.Items;
import org.example.Entity.Street;
import org.example.Entity.Warehouses;

import java.sql.*;
import java.util.List;


public class Add {
    public static void createStreet(Connection connection, Street street, List<Street> streetList) throws SQLException {
//        Statement statement = connection.createStatement();
//        String sql = String.format("INSERT INTO streets VALUES(%d, '%s', %d, '%s')", street.getId(), street.getName(), street.getCost(), street.neighborhood(streetList));
        String sql = "INSERT INTO streets VALUES(?, ?, ?, ?)";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, street.getId());
        pstatement.setString(2, street.getName());
        pstatement.setInt(3, street.getCost());

        String streetString = String.join(", ", street.neighborhood(streetList));

        pstatement.setString(4, streetString);

        pstatement.executeUpdate();
        pstatement.close();
//        statement.execute(sql);
    }
    public static void createItem(Connection connection, Items items) throws SQLException {
        String sql = "INSERT INTO items VALUES(?, ?, ?)";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, items.getId());
        pstatement.setString(2, items.getName());
        pstatement.setInt(3, items.getPret());

        pstatement.executeUpdate();
        pstatement.close();
    }
    public static void createWarehouse(Connection connection, Warehouses warehouses) throws SQLException {
        String sql = "INSERT INTO WAREHOUSES VALUES(?, ?)";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, warehouses.getId());
        pstatement.setString(2, warehouses.getName());

        pstatement.executeUpdate();
        pstatement.close();
    }
    public static void createInventory(Connection connection, int warehouseId, int itemId) throws SQLException {
        String sql = "INSERT INTO WAREHOUSEITEMS VALUES(?, ?)";
        PreparedStatement pstatement = connection.prepareStatement(sql);
        pstatement.setInt(1, itemId);
        pstatement.setInt(2, warehouseId);

        pstatement.executeUpdate();
        pstatement.close();
    }
}