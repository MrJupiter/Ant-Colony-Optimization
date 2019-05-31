/**
 * @author  Abdelmalik GHOUBIR <ghoubir.abdo@gmail.com>
 */

import static javax.swing.JOptionPane.*;
import java.awt.*;

Button startButton;
Button pauseButton;
Button exitButton;
boolean toggle = false;

PImage img;

int scoutAntsLifetime = 1000;

//final String numberOfScoutAntsS = showInputDialog("Please Enter the number of scout ants that the colony contains:");
//final int numberOfScoutAnts = (numberOfScoutAntsS == null || "".equals(numberOfScoutAntsS) || numberOfScoutAntsS.charAt(0) == ' ')?1:Integer.parseInt(numberOfScoutAntsS);

//final String numberOfNormalAntsS = showInputDialog("Please Enter the number of normal ants that the colony contains:");
//final int numberOfNormalAnts = (numberOfNormalAntsS == null || "".equals(numberOfNormalAntsS) || numberOfNormalAntsS.charAt(0) == ' ')?0:Integer.parseInt(numberOfNormalAntsS);

String pathOfImage = showInputDialog("Please Enter the path to the Image you want to use:");

InterfaceGraphique IG = new InterfaceGraphique(900, 100, 80); // Version: Random distribution
InterfaceGraphique map1;

Colony colony = new Colony(50, 50);

void setup() {
    while (pathOfImage == null || pathOfImage.equals(""))
        pathOfImage = showInputDialog("Please Enter the path to the Image you want to use:");

    size(920, 980);
    pauseButton = new Button("Pause", color(0, 0, 255), 300, 925, 100, 50);
    startButton = new Button("Start", color(0, 255, 0), 410, 925, 100, 50);
    exitButton = new Button("Exit", color(255, 0, 0), 520, 925, 100, 50);
    img = loadImage("antouta.png");
    background(color(255, 255, 0));

    map1 = new InterfaceGraphique(pathOfImage);
    map1.setupMAP();
}

void mousePressed() {
    if (startButton.MouseIsOver())
        toggle = true;

    if (pauseButton.MouseIsOver()) {
        toggle = false;
        startButton.setLabel("Resume");
    }

    if (exitButton.MouseIsOver())
        exit();

    map1.mousePressed();
}

boolean setupBool = false;

void draw() {
    for (int i = 0; i < 900;) {
        if (!(i > 200 && i < 600)) image(img, 10 + i, 920, 100, 60);
        i += 100;
    }

    startButton.Draw();
    pauseButton.Draw();
    exitButton.Draw();
    map1.drawMap();

    if (toggle) {
        if (!setupBool) {
            colony.setupColony(map1.getGrid(), scoutAntsLifetime);
            setupBool = true;
        }

        // Forward Scout Ants
        colony.scoutAntsRandomlyMove();

        // Deleting Scout ants Traces if lifetime expired
        colony.deleteLosedScoutAnts();

        // Backward Scout Ants (free pheromone)
        colony.scoutAntsComeback();

        // Forward Normal Ants (using probility equation)
        colony.normalAntsRandomlyMove();

        // Backward Normal Ants (free pheromone)
        // colony.normalAntsComeback(normalAntsUtilArray);
    }

}
