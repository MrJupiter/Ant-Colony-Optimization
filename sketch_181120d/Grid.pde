/*
  This class is the composite class
  Reminder: Composite is a design pattern that allowing us to have a project architecture respecting the 'SOLID' rule
  The Composite Class :
    represents a composite Component (component having children)
    implements methods to manipulate children: The different cells types (the method addMapComponent() )
    implements all Component methods, generally by delegating them to its children (The method drawMap() )
*/
public final class Grid implements MapComponent {

    private ArrayList < MapComponent > _element = new ArrayList < MapComponent > ();
    private Cell _colony;
    private int _cellNumber;

    public void drawMap() {
        Cell pointer;

        for (MapComponent e: _element) {
            pointer = (Cell) e;
            if (pointer instanceof ColonyLocation)
                _colony = pointer;
            e.drawMap();
        }
    }


    public void addMapComponent(MapComponent e) {
        _element.add(e);
    }

    /* Useful Getter */

    public ArrayList < MapComponent > getMapComponent() {
        return _element;
    }

    public Cell getColony() {
        return _colony;
    }

    public int getCellNumber() {
        return _cellNumber;
    }

    /* useful seter */

    public void setCellNumber(int cellNumber) {
        _cellNumber = cellNumber;
    }

    void mousePressed(int _cellSize) {
        for (MapComponent e: _element) {
            //if( ! (e instanceof Obstacle)){
            if (((Cell) e).MouseIsOver()) {
                int index = _element.indexOf(e);
                String type = showInputDialog("Nest or Food or Empty?");
                Position p = ((Cell) e).getPosition();

                String typeOfCell = (type == null || "".equals(type) || type.charAt(0) == ' ') ? "" : type;

                if (typeOfCell.equalsIgnoreCase("nest")) {
                    _element.set(index, new ColonyLocation(p, _cellSize));
                    _colony = (Cell) e;
                }
                if (typeOfCell.equalsIgnoreCase("food"))
                    _element.set(index, new Food(p, _cellSize));
                if (typeOfCell.equalsIgnoreCase("empty"))
                    _element.set(index, new EmptyCell(p, _cellSize));
            }
        }
        //}
    }

}
