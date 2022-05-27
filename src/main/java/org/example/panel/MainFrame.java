package org.example.panel;

import javax.swing.*;
import java.awt.*;


public class MainFrame extends JFrame {
    ConfigPanel configPanel;
    DrawingPanel drawingPanel;
    ControlPanel controlPanel;
    SidePanel sidePanel;

    public MainFrame(){
        super("My App");
        start();
    }

    private void start() {
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        configPanel = new ConfigPanel(this);
        drawingPanel = new DrawingPanel(this, 20);
        controlPanel = new ControlPanel(this);
        sidePanel = new SidePanel(this);

        configPanel.setBackground(Color.lightGray);

        add(sidePanel, BorderLayout.WEST);
        if(configPanel.getGameCreated())
            add(drawingPanel, BorderLayout.CENTER);
        add(configPanel, BorderLayout.NORTH);
        add(controlPanel, BorderLayout.SOUTH);


        pack();
    }
    public JTextField getStreet(){
        System.out.println(configPanel.getStreets());
        return configPanel.getStreets();
    }
}