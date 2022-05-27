package org.example;


import org.example.panel.MainFrame;

import java.sql.SQLException;

public class Main {
    public static void main(String[] args) throws SQLException {
        MainFrame frame = new MainFrame();
        frame.setSize(700, 400);
        frame.setVisible(true);
    }
}
