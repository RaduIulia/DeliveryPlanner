package org.example.panel;

import oracle.jdbc.OracleTypes;
import oracle.sql.NUMBER;
import org.example.Create;
import org.example.DBConnect;
import org.example.Entity.Street;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SidePanel extends JPanel {
    final MainFrame mainFrame;
    private DBConnect conn;

    public SidePanel(MainFrame mainFrame) throws SQLException {
        conn = DBConnect.createConnection();

        List<String> items = new ArrayList<>();

        this.mainFrame = mainFrame;

        this.setPreferredSize(new Dimension(200, 400));
        JPanel mainPanel = new JPanel();
        this.setLayout(new BorderLayout());

        JPanel buttonPanel = new JPanel();
        JButton button = new JButton("Send Order");
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JTextField textField = new JTextField();
                textField.setPreferredSize(new Dimension(100, 24));
                JButton jButton = new JButton("Add new item ");

                mainPanel.add(textField);
                mainPanel.add(jButton);
            }
        });
        mainPanel.setBackground(Color.BLUE);
        add(mainPanel);
        buttonPanel.add(button);
        add(button,BorderLayout.SOUTH);

        JTextField jTextField = new JTextField();
        jTextField.setPreferredSize(new Dimension(100, 24));

        JButton jButton = new JButton("Add new item");

        jButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                CallableStatement callableStatement = null;
                int y = 0;
                try {
                    callableStatement = conn.connection.prepareCall("begin ? := checkStockItems(?); end;");
                    callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
                    callableStatement.setString(2, jTextField.getText());
                    callableStatement.execute();
                    int result = callableStatement.getInt(1);
                    callableStatement.close();

                    if (result == 0){
                        System.out.println("Aia e, nu avem pe stoc");
                    }else {
                        items.add(jTextField.getText());
                        System.out.println(items);
                        System.out.println("Are bajatu'");
                    }

                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }



            }
        });

        mainPanel.add(jTextField);
        mainPanel.add(jButton);

    }
}
