package org.example.panel;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import static javax.swing.WindowConstants.DISPOSE_ON_CLOSE;

public class ControlPanel extends JPanel{
    MainFrame frame;
    public ControlPanel(MainFrame frame) {
        JButton exit = new JButton("Exit");
        exit.addActionListener(this::exit);
        exit.setBackground(Color.RED);
        add(exit);
    }

    private void exit(ActionEvent e) {
        JFrame saveFrame = new JFrame();
        saveFrame.setVisible(true);
        saveFrame.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        saveFrame.setPreferredSize(new Dimension(400, 80));
        saveFrame.setLocation(530, 350);
        saveFrame.pack();
        System.exit(0);
    }

    private void exitNoSave(ActionEvent actionEvent) {
        System.exit(0);
    }

}
