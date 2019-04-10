/*
  This class is a Leaf class
  Reminder: Composite is a design pattern that allowing us to have a project architecture respecting the 'SOLID' rule
  A Leaf Class :
    represents leaf objects in the composition
    implements all Component methods
*/

public final class Obstacle extends Cell {


    public Obstacle(Position obstaclePos, int cellSize) {
        _cellColor = new Gray();
        _position = obstaclePos;
        _cellSize = cellSize;
    }

    public void drawMap() {
        fill(_cellColor.getColorRGB());
        rect(_position.getY() * _cellSize, _position.getX() * _cellSize, _cellSize, _cellSize);
    }


}
