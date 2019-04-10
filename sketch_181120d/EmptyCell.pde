/*
  This class is a Leaf class
  Reminder: Composite is a design pattern that allowing us to have a project architecture respecting the 'SOLID' rule
  A Leaf Class :
    represents leaf objects in the composition
    implements all Component methods
*/

public final class EmptyCell extends Cell {

    private Pheromone _pheromone;

    public EmptyCell(Position emptyCellPos, int cellSize) {
        _cellColor = new White();
        _position = emptyCellPos;
        _cellSize = cellSize;
        _pheromone = new Pheromone();
    }

    public void drawMap() {
        fill(_cellColor.getColorRGB());
        rect(_position.getY() * _cellSize, _position.getX() * _cellSize, _cellSize, _cellSize);
    }

    public float getPheromoneValue() {
        return _pheromone.getValue();
    }

    public void pheromoneInc(double length) {
        _pheromone.incrementation(length);
    }

    public void pheromoneEvap() {
        if(getPheromoneValue() >= 0.05)  _pheromone.evaporation();
        else _pheromone.setValue(0);
    }

    public void setPheromoneValue(float i) {
        _pheromone.setValue(i);
    }

    private void updateCellColor(){
        if(getPheromoneValue() < 5)
            _cellColor = new White();
        else if(getPheromoneValue() >= 5 && getPheromoneValue() <= 2000)
            _cellColor = new YellowLevel1();
        else if(getPheromoneValue() > 2000 && getPheromoneValue() <= 6000)
            _cellColor = new YellowLevel2();
        else
            _cellColor = new YellowLevel3();
    }

}
