package com.packages;
import net.sf.clipsrules.jni.*;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;

public class problem3 {
    static JFrame mainFrame = null;
    static String inputPath = "";
    static String outputPath = "";
    public static void startGUI() {
        mainFrame = new JFrame();
        mainFrame.setSize(600, 600);
        JPanel panel = new JPanel(null);
        JButton startButton = new JButton("Start");
        startButton.setSize(100, 50);
        startButton.setLocation(250, 275);

        JLabel inputPathLabel = new JLabel("Enter Input Path");
        inputPathLabel.setBounds(50, 50, 200, 30);
        JTextField inputPathTF = new JTextField();
        inputPathTF.setBounds(50, 100, 500, 30);

        JLabel outputPathLabel = new JLabel("Enter Output Path");
        outputPathLabel.setBounds(50, 150, 200, 30);
        JTextField outputPathTF = new JTextField();
        outputPathTF.setBounds(50, 200, 500, 30);

        startButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                mainFrame.dispatchEvent(new WindowEvent(mainFrame, WindowEvent.WINDOW_CLOSING));
                inputPath = inputPathTF.getText();
                outputPath=outputPathTF.getText();
                System.out.println(inputPath);
                System.out.println(outputPath);
                try {
                    start();
                } catch (CLIPSException ex) {
                    throw new RuntimeException(ex);
                }
           }
        });
        panel.add(inputPathLabel);
        panel.add(inputPathTF);
        panel.add(outputPathLabel);
        panel.add(outputPathTF);
        panel.add(startButton);
        mainFrame.add(panel);
        mainFrame.setVisible(true);
        mainFrame.setLayout(null);
    }
    public static void start() throws CLIPSException {
        Environment clips = new Environment();
        clips.clear();

        clips.loadFromString("  (deftemplate student \n" +
                "    (slot name)\n" +
                "    (multislot courseGrades)\n" +
                "  ) \n" +
                "\n" +
                "  (defrule ReadFromFile\n" +
                "  =>\n" +
                "    (open \""+inputPath+"\" data \"r\")\n" +
                "    (bind ?name (read data))\n" +
                "    (while (neq ?name EOF)\n" +
                "    (printout t ?name crlf)\n" +
                "    (bind $?courseGrades (explode$ (readline data))) \n" +
                "    (printout t $?courseGrades crlf)\n" +
                "    (assert (student (name ?name) (courseGrades $?courseGrades) ))\n" +
                "    (bind ?name (read data))\n" +
                "    )\n" +
                "\t(close data)\n" +
                "  )\n" +
                "\n" +
                "  (defrule CalculateAndWrite\n" +
                "  (student (name ?name)(courseGrades $?courseGrades))\n" +
                "  =>(open \""+outputPath+"\" data \"a\")\n" +
                "  (bind ?res (+ (expand$ ?courseGrades)))\n" +
                "  (bind ?res (/ ?res 4))\n" +
                "  (printout data ?name \" \"$?courseGrades \" \"?res crlf)\n" +
                "  (close data)\n" +
                "  )");
        clips.reset();
        clips.run();

    }
    public static void main(String[] args)  {
        startGUI();
    }
}