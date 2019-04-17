import static javax.swing.JOptionPane.*;
import java.awt.*;

float scaleFactor = 1.0;
float translateX = 0.0;
float translateY = 0.0;

Button startButton;
Button pauseButton;
Button exitButton;
boolean toggle = false;

PImage img;

int scoutAntsLifetime = 1000;
/*
final String foodsN = showInputDialog("Please Enter the number of foods to be displayed on the map:");
final int foodsNumber = (foodsN == null || "".equals(foodsN) || foodsN.charAt(0) == ' ')?1:Integer.parseInt(foodsN);

final String obstacleN = showInputDialog("Please Enter the number of obstacles to be displayed on the map:");
final int obstacleNumber = (obstacleN == null || "".equals(obstacleN) || obstacleN.charAt(0) == ' ')?0:Integer.parseInt(obstacleN);

*/
final String numberOfScoutAntsS = showInputDialog("Please Enter the number of scout ants that the colony contains:");
final int numberOfScoutAnts = (numberOfScoutAntsS == null || "".equals(numberOfScoutAntsS) || numberOfScoutAntsS.charAt(0) == ' ')?1:Integer.parseInt(numberOfScoutAntsS);


final String numberOfNormalAntsS = showInputDialog("Please Enter the number of normal ants that the colony contains:");
final int numberOfNormalAnts = (numberOfNormalAntsS == null || "".equals(numberOfNormalAntsS) || numberOfNormalAntsS.charAt(0) == ' ')?0:Integer.parseInt(numberOfNormalAntsS);


InterfaceGraphique IG = new InterfaceGraphique(900, 100, 80);
InterfaceGraphique map1;

Colony colony = new Colony(numberOfScoutAnts, numberOfNormalAnts);

void setup() {
    size(920, 980);
    pauseButton = new Button("Pause", color(0, 0, 255), 300, 925, 100, 50);
    startButton = new Button("Start", color(0,255,0), 410, 925, 100, 50);
    exitButton = new Button("Exit", color(255, 0, 0), 520, 925, 100, 50);
    img = loadImage("antouta.png");
    background(color(255,255,0));
    //IG.setupMAP();
    map1 = new InterfaceGraphique("img1.png");
    map1.setupMAP();
}

void mousePressed()
{
  if (startButton.MouseIsOver())
    toggle = true;

  if(pauseButton.MouseIsOver()){
    toggle = false;
    startButton.setLabel("Resume");
  }

  if(exitButton.MouseIsOver())
    exit();

  //IG.mousePressed();
  map1.mousePressed();

}
/*
void mouseWheel(MouseEvent e) {
  translateX -= mouseX;
  translateY -= mouseY;
  float delta = e.getCount() > 0 ? 1.05 : e.getCount() < 0 ? 1.0/1.05 : 1.0;
  scaleFactor *= delta;
  translateX *= delta;
  translateY *= delta;
  translateX += mouseX;
  translateY += mouseY;
}

void mouseDragged(MouseEvent e) {
  translateX += mouseX - pmouseX;
  translateY += mouseY - pmouseY;
}*/

boolean setupBool = false;

void draw() {
  /*noStroke();

  pushMatrix();

  translate(translateX,translateY);
  scale(scaleFactor);
  */
    for(int i=0; i<900; ){
      if(!(i>200 && i <600)) image(img, 10+i, 920, 100, 60);
      i+=100;
    }

    startButton.Draw();
    pauseButton.Draw();
    exitButton.Draw();
    //IG.drawMap();

    map1.drawMap();

    if(toggle){
      if(!setupBool){
        colony.setupColony(map1.getGrid(), scoutAntsLifetime);

        //colony.setupColony(IG.getGrid(), scoutAntsLifetime);
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
      //popMatrix();

}
