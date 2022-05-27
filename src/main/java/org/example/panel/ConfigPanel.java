package org.example.panel;

import org.example.Create;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.sql.SQLException;


public class ConfigPanel extends JPanel {
    JTextField streets, intersections;
    Boolean gameCreated = false;
    final MainFrame mainFrame;
    DrawingPanel drawingPanel;
    public ConfigPanel(MainFrame mainFrame) {
        this.mainFrame = mainFrame;
        JLabel gridSize = new JLabel("Number of streets ");
        gridSize.setForeground(Color.BLACK);
        JTextField streets = new JTextField("10");
//        JTextField intersections = new JTextField();
        streets.setPreferredSize(new Dimension(50, 20 ));
//        intersections.setPreferredSize(new Dimension(50, 20 ));
        JButton createGame = new JButton("Create");
        createGame.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                setStreets(streets);
//                setIntersections(intersections);
                try {
                    Create create = new Create(Integer.parseInt(streets.getText()));
                    System.out.println("Game Created!");

                    setGameCreated(true);
                    drawingPanel = new DrawingPanel(mainFrame, create, Integer.parseInt(streets.getText()));

                    mainFrame.add(drawingPanel, BorderLayout.CENTER);
                    mainFrame.pack();
                } catch (SQLException | IOException ex) {
                    throw new RuntimeException(ex);
                } catch (NumberFormatException ex) {
                    System.out.println("Not a number");
                }
            }
        });
        add(gridSize);
        add(streets);
//        add(intersections);
        add(createGame);
    }
    public Boolean getGameCreated() {
        return gameCreated;
    }

    public void setGameCreated(Boolean gameCreated) {
        this.gameCreated = gameCreated;
    }

    public JTextField getStreets() {
        return streets;
    }

    public void setStreets(JTextField streets) {
        this.streets = streets;
    }

    public JTextField getIntersections() {
        return intersections;
    }

    public void setIntersections(JTextField intersections) {
        this.intersections = intersections;
    }
}
