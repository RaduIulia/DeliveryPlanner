package org.example.panel;

import oracle.jdbc.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
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
import java.util.Objects;

import static org.example.Create.calculare_depozite;

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

                try {
                    CallableStatement callableStatement = conn.connection.prepareCall("begin ? := clientOrder(?, ?); end;");
                    callableStatement.registerOutParameter(1, OracleTypes.VARCHAR);
                    callableStatement.setString(2, "test");
                    ArrayDescriptor desc = ArrayDescriptor.createDescriptor("NUME_ARRAY",conn.connection);
                    ARRAY array = new ARRAY(desc, conn.connection, items.toArray());
                    callableStatement.setArray(3, array);
                    callableStatement.execute();
                    String result = callableStatement.getString(1);
                    System.out.println(result);

                    calculare_depozite(result, items.size());
                    callableStatement.close();
                    System.out.println("Comanda trimisa");

                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }

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
                checkItems(jTextField, items);
            }
        });

        JTextField deleteTextField = new JTextField();
        deleteTextField.setPreferredSize(new Dimension(100, 24));

        JButton deleteButton = new JButton("Remove item");
        deleteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                removeItem(deleteTextField, items);
                System.out.println("Buton apasat");
            }
        });

        mainPanel.add(jTextField, BorderLayout.CENTER);
        mainPanel.add(jButton, BorderLayout.CENTER);
        mainPanel.add(deleteTextField, BorderLayout.CENTER);
        mainPanel.add(deleteButton, BorderLayout.CENTER);


    }
    public void checkItems(JTextField jTextField, List<String> items){
        CallableStatement callableStatement = null;
        int y = 0;
        try {
            callableStatement = conn.connection.prepareCall("begin ? := checkStockItems(?); end;");
            callableStatement.registerOutParameter(1, OracleTypes.VARCHAR);
            callableStatement.setString(2, jTextField.getText());
            callableStatement.execute();
            String result = callableStatement.getString(1);
            callableStatement.close();
            System.out.println(result);
            if (Objects.equals(result, "0")){
                System.out.println("Produsul nu exista pe stoc.");

            }else if (Objects.equals(result, "2")){
                System.out.println("Avem mai multe produse cu acest nume. Introduceti numele complet.");
            }
            else{
                items.add(result);
                System.out.println(items);
                System.out.println("Produs adaugat in lista de cumparaturi!");
            }

        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }
    public void removeItem(JTextField jTextField, List<String> items){
        CallableStatement callableStatement = null;
        int y = 0;
        try {
            callableStatement = conn.connection.prepareCall("begin ? := checkStockItems(?); end;");
            callableStatement.registerOutParameter(1, OracleTypes.VARCHAR);
            callableStatement.setString(2, jTextField.getText());
            callableStatement.execute();
            String result = callableStatement.getString(1);
            callableStatement.close();

            if (Objects.equals(result, "0")){
                System.out.println("Produsul nu exista in lista de cumparaturi!");
            }else if (Objects.equals(result, "2")){
                System.out.println("Avem mai multe produse cu acest nume. Introduceti numele complet.");
            }
            else{
                items.remove(result);
                System.out.println("Produs scos din lista de cumparaturi!");
                System.out.println(items);
            }

        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

}
