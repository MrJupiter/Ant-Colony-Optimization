public final class Button {
  String label; // button label
  float x;      // top left corner x position
  float y;      // top left corner y position
  float w;      // width of button
  float h;      // height of button
  color _buttonColor; // button color

  Button(String labelB, color buttonColor,float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    _buttonColor = buttonColor;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }

  void Draw() {
    fill(218);
    stroke(141);
    fill(_buttonColor);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(createFont("Arial Bold", 16));
    text(label, x + (w / 2), y + (h / 2));
  }

  void setLabel(String labelB){
    label = labelB;
  }

  boolean MouseIsOver() {
    return (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h));
  }
}
