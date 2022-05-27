package org.example.panel;

import org.example.Create;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.sql.SQLException;

public class SidePanel extends JPanel {
    final MainFrame mainFrame;

    public SidePanel(MainFrame mainFrame) {
        this.mainFrame = mainFrame;

        this.setPreferredSize(new Dimension(200, 400));
        JPanel mainPanel = new JPanel();
        this.setLayout(new BorderLayout());

        JPanel buttonPanel = new JPanel();
        JButton button = new JButton("New Item");
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JTextField textField = new JTextField();
                textField.setPreferredSize(new Dimension(100, 24));
                JButton jButton = new JButton("asd");

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

        JButton jButton = new JButton("Add");

        mainPanel.add(jTextField);
        mainPanel.add(jButton);

    }
}
