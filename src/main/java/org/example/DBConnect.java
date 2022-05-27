package org.example;

import java.sql.*;

public class DBConnect {

    private static DBConnect connect = null;
    public Connection connection;
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String username = "STUDENT";
    String password = "STUDENT";

    private DBConnect() {
        try {
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
    public static DBConnect createConnection() throws SQLException {
        if(connect == null)
            connect = new DBConnect();

        return connect;
    }
}
