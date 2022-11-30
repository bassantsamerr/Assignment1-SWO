package com.packages;
import net.sf.clipsrules.jni.*;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.io.IOException;

public class problem2 {
    static JFrame mainFrame = null;
    static String selectedColor = "";
    public static void startGUI() {
        mainFrame = new JFrame();
        mainFrame.setSize(600, 600);
        JPanel panel = new JPanel(null);
        JComboBox<String> selectedColorButton = new JComboBox<>();
        selectedColorButton.addItem("Red");
        selectedColorButton.addItem("White");
        selectedColorButton.addItem("Black");
        selectedColorButton.addItem("Black");
        selectedColorButton.addItem("Blue");
        selectedColorButton.addItem("Yellow");
        selectedColorButton.addItem("Green");
        selectedColorButton.addItem("Orange");
        selectedColorButton.setSize(100, 50);
        selectedColorButton.setLocation(250, 175);
        JButton continueButton = new JButton("Continue");
        continueButton.setSize(100, 50);
        continueButton.setLocation(250, 275);
        continueButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                mainFrame.dispatchEvent(new WindowEvent(mainFrame, WindowEvent.WINDOW_CLOSING));
                selectedColor = selectedColorButton.getSelectedItem().toString();
                try {
                    viewInferedCountries();
                } catch (CLIPSException ex) {
                    throw new RuntimeException(ex);
                }
            }
        });

        panel.add(selectedColorButton);
        panel.add(continueButton);
        mainFrame.add(panel);
        mainFrame.setVisible(true);
        mainFrame.setLayout(null);
    }

    public static void viewInferedCountries() throws CLIPSException {
        Environment clips = new Environment();
        CaptureRouter router = new CaptureRouter(clips, new String[] {Router.STDOUT});
        clips.clear();
        clips.loadFromString("(deftemplate c\n" +
                "\t(slot countryName (type STRING))\n" +
                "\t(multislot colors)\n" +
                ")\n" +
                "(deffacts countries\n" +
                "\t(c (countryName \"Egypt\") (colors red white black))\n" +
                "\t(c (countryName \"United states\") (colors red white blue))\n" +
                "\t(c (countryName \"Belgium\") (colors black yellow red))\n" +
                "\t(c (countryName \"Sweden\") (colors yellow blue))\n" +
                "\t(c (countryName \"Italy\") (colors green white red))\n" +
                "\t(c (countryName \"Ireland\") (colors green white orange))\n" +
                "\t(c (countryName\"Greece\") (colors blue white))\n" +
                ")\n" +
                "(defrule check \n" +
                "\t(color ?color)\n" +
                "\t(c (countryName ?countryName) (colors $?colors))\n" +
                "\t(test (member$ ?color ?colors))\n" +
                "\t=>\n" +
                "\t(printout t ?countryName \" and its flag's colors are \" ?colors crlf)\n" +
                ")");
        clips.reset();
        clips.eval("(assert (color " + selectedColor.toLowerCase() + "))");
        clips.run();
        String returnedCountriesString = router.getOutput();
        String[] countriesList = returnedCountriesString.split("\n");
        mainFrame = new JFrame();
        mainFrame.setSize(600, 400);
        JPanel panel = new JPanel(new GridLayout(20, 1));
        panel.setBorder(BorderFactory.createEmptyBorder(0, 50, 0, 50));
        panel.add(new JLabel("Countries are", SwingConstants.CENTER));
        for (String country : countriesList) {
            panel.add(new JLabel(country));
        }
        mainFrame.setVisible(true);
        mainFrame.add(panel);
    }
    public static void main(String[] args) throws IOException, CLIPSException {
        startGUI();
    }
}