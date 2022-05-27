package org.example.panel;

import org.example.Create;
import org.example.Entity.Street;

import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

public class DrawingPanel extends JPanel {
    final MainFrame mainFrame;
    Create create;
    int streets;

    public DrawingPanel(MainFrame mainFrame, Create create, int streets) {
        this.mainFrame = mainFrame;
        this.create = create;
        this.streets = streets;
        start();
    }
    public DrawingPanel(MainFrame mainFrame, int streets) {
        this.mainFrame = mainFrame;
        this.streets = streets;
    }

    public void start(){

        List<Street> streetList = create.getStreetList();

        JTable table = new JTable(new DefaultTableModel());
        table.setPreferredSize(new Dimension(700, 9000));

        DefaultTableModel model = (DefaultTableModel) table.getModel();
        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
        scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);

//        delete somehow the table
//        model.getDataVector().removeAllElements();
//        model.fireTableDataChanged();

        model.addColumn("Id");
        model.addColumn("Name");
        model.addColumn("Cost");
        model.addColumn("Intersections");
        table.getColumnModel().getColumn(0).setPreferredWidth(50);
        table.getColumnModel().getColumn(1).setPreferredWidth(150);
        table.getColumnModel().getColumn(2).setPreferredWidth(50);
        table.getColumnModel().getColumn(3).setPreferredWidth(450);

        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
        centerRenderer.setHorizontalAlignment( JLabel.CENTER );
        table.getColumnModel().getColumn(0).setCellRenderer(centerRenderer);
        table.getColumnModel().getColumn(2).setCellRenderer(centerRenderer);

        for(Street s : streetList){
            model.addRow(new Object[]{s.getId(), s.getName(), s.getCost(), s.neighborhood(streetList)});
        }
        scrollPane.setPreferredSize(new Dimension(700, 400));
//        add(table);
        add(scrollPane);

    }
}
