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
        JButton save = new JButton("Save");
        JButton load = new JButton("Load");
        JButton exit = new JButton("Exit");
        save.addActionListener(this::save);
        load.addActionListener(this::load);
        exit.addActionListener(this::exit);
        exit.setBackground(Color.RED);
        save.setBackground(Color.GREEN);
        load.setBackground(Color.CYAN);
        add(save);
        add(load);
        add(exit);
    }
    private void load(ActionEvent e) {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setDialogTitle("Specify a file to load from:");
        if (fileChooser.showOpenDialog(frame) == JFileChooser.APPROVE_OPTION) {
            File loadFile = fileChooser.getSelectedFile();
            System.out.println("Loading file: " + loadFile.getAbsolutePath());
            try {
                BufferedImage image = ImageIO.read(loadFile);
                // TODO
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        }
    }

    private void save(ActionEvent e) {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setDialogTitle("Specify a file to save:");
        if (fileChooser.showSaveDialog(frame) == JFileChooser.APPROVE_OPTION) {
            File fileToSave = fileChooser.getSelectedFile();
            System.out.println("Save as file: " + fileToSave.getAbsolutePath());
            System.out.println("save");
        }
    }

    private void exit(ActionEvent e) {
        JFrame saveFrame = new JFrame();
        saveFrame.setVisible(true);
        saveFrame.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        saveFrame.setPreferredSize(new Dimension(400, 80));
        saveFrame.setLocation(530, 350);
        saveFrame.pack();
        JLabel saveLabel = new JLabel("Do you want to save?");

        JPanel savePanel = new JPanel();
        JButton yesButton = new JButton("Yes");
        JButton noButton = new JButton("No ");
        yesButton.addActionListener(this::saveAndExit);
        noButton.addActionListener(this::exitNoSave);
        savePanel.add(saveLabel);
        savePanel.add(yesButton);
        savePanel.add(noButton);
        saveFrame.add(savePanel);
        try {
            wait(10);
        } catch (InterruptedException interruptedException) {
            interruptedException.printStackTrace();
        }
        System.exit(0);
    }

    private void exitNoSave(ActionEvent actionEvent) {
        System.exit(0);
    }

    private void saveAndExit(ActionEvent e) {
        this.save(e);
        System.exit(0);
    }
}
