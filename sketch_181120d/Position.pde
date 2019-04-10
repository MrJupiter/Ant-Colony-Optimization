public final class Position {
    private int _x;
    private int _y;

    public Position() {
        _x = 0;
        _y = 0;
    }

    public Position(int x, int y) {
        _x = x;
        _y = y;
    }

    public int getX() {
        return _x;
    }

    public int getY() {
        return _y;
    }

    public void setX(int x) {
        _x = x;
    }

    public void setY(int y) {
        _y = y;
    }

    public String toString() {
        return "(" + _x + ", " + _y + ")";
    }
}
