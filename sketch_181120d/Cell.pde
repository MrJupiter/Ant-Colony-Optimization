public abstract class Cell implements MapComponent {
    protected CellColor _cellColor;
    protected Position _position;
    protected int _cellSize;

    public abstract void drawMap();

    public String getColorName() {
        return _cellColor.getColorName();
    }

    public Position getPosition() {
        return _position;
    }

    public String toString() {
        return getPosition().toString();
    }

    public void setColor(color c) {
        _cellColor.setColor(c);
    }

    public void changeColor(CellColor newColor) {
        _cellColor = newColor;
    }

    public double distance(Cell arrive) {
        return (Math.sqrt(Math.pow(_position.getX() - arrive.getPosition().getX(), 2) + Math.pow(_position.getY() - arrive.getPosition().getY(), 2)));
    }

    boolean MouseIsOver() {
        return (mouseX > _position.getY() * _cellSize && mouseX < (_position.getY() * _cellSize + _cellSize) && mouseY > _position.getX() * _cellSize && mouseY < (_position.getX() * _cellSize + _cellSize));
    }
}
