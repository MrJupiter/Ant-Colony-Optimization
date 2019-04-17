import static javax.swing.JOptionPane.*;

/*
  This class is a facade to our project.
  Reminder: Facade is a design pattern that makes the client use easily the program.
*/

public class InterfaceGraphique {

    private int _cellSize;
    private int _width;
    private int _cellNumber;
    private int _obstacleNumber;
    private ArrayList < Cell > _cells = new ArrayList < Cell > ();
    private Grid _grid = new Grid();
    private PImage _mapImage = null;

    public InterfaceGraphique(int dimension, int cellsize, int obstacleN){
      _width = dimension;
      _cellSize = cellsize;
      _obstacleNumber = obstacleN;
      _cellNumber = _width / _cellSize;
      _grid.setCellNumber(_cellNumber);
    }

    public InterfaceGraphique(String imageName) {
        _mapImage = loadImage(imageName);
        _width = _mapImage.width; // _width is now the cellNumber!
        _cellSize = 5;
        _grid.setCellNumber(_width);
    }

    public Grid getGrid(){
      return _grid;
    }

    public void setupMAP() {
        setupDesign();
        setupGrid();
        drawMap();
    }

    public void drawMap() {
        _grid.drawMap();
    }

    public void mousePressed(){
        _grid.mousePressed(_cellSize);
    }

    private void setupGrid() {
        for (Cell j: _cells)
            _grid.addMapComponent(j);
    }

    private void setupDesign() {
      if(_mapImage == null){
        putEmptyCells();
        putObstacles();
      }else
        buildMap();
    }

    private void buildMap() {
      for (int i = 0; i < _mapImage.height; ++i)
        for (int j = 0; j < _mapImage.width; ++j)
            _cells.add(new EmptyCell(new Position(i,j), _cellSize));

        for (int i = 0; i < _mapImage.height; ++i) {
          for (int j = 0; j < _mapImage.width; ++j) {
            if (_mapImage.pixels[_mapImage.width * i + j] == color(0,0,0)){
              _cells.set(_mapImage.width * i + j, new Obstacle(new Position(i,j), _cellSize));
            }
            else if (_mapImage.pixels[_mapImage.width * i + j] == color(255,255,255)){
              _cells.set(_mapImage.width * i + j, new EmptyCell(new Position(i, j), _cellSize));
            }
          }
      }
    }

    private void putEmptyCells() {
        for (int i = 0; i < _cellNumber; i++)
            for (int j = 0; j < _cellNumber; j++)
                _cells.add(new EmptyCell(new Position(i, j), _cellSize));
    }

    private void putObstacles() {
        int lastCellOfCellsArray = _cells.size() - 1;

        for (int i = 0; i < _obstacleNumber; i++) {
            int index = (int) random(lastCellOfCellsArray);
            if (index > _cellNumber && index < lastCellOfCellsArray - _cellNumber) {
                if (_cells.get(index - _cellNumber).getColorName() != "gray" && _cells.get(index + _cellNumber).getColorName() != "gray" && _cells.get(index - 1).getColorName() != "gray" && _cells.get(index + 1).getColorName() != "gray") {
                    Position pos = _cells.get(index).getPosition();
                    _cells.set(index, new Obstacle(pos, _cellSize));
                }
            } else if (index <= _cellNumber) {
                if (_cells.get(index + _cellNumber).getColorName() != "gray" && _cells.get(index + 1).getColorName() != "gray") {
                    Position pos = _cells.get(index).getPosition();
                    _cells.set(index, new Obstacle(pos, _cellSize));
                }
            } else {
                if (_cells.get(index - _cellNumber).getColorName() != "gray" && _cells.get(index - 1).getColorName() != "gray") {
                    Position pos = _cells.get(index).getPosition();
                    _cells.set(index, new Obstacle(pos, _cellSize));
                }
            }
        }
    }

}
