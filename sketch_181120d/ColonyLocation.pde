/*
  This class is a Leaf class
  Reminder: Composite is a design pattern that allowing us to have a project architecture respecting the 'SOLID' rule
  A Leaf Class :
    represents leaf objects in the composition
    implements all Component methods
*/

public final class ColonyLocation extends Cell {

    public ColonyLocation(Position colonyLocationPos, int cellSize) {
        _cellColor = new Red();
        _position = colonyLocationPos;
        _cellSize = cellSize;
    }

    public void drawMap() {
        fill(_cellColor.getColorRGB());
        rect(_position.getY() * _cellSize, _position.getX() * _cellSize, _cellSize, _cellSize);
    }

}
