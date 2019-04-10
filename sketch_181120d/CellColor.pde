/*
  This abstract class is serving as a bridge between cells and different colors
  The Pros : Adding new colors will not require changing cells classes and vice versa.
*/
public abstract class CellColor {
    protected color _colorRGB;
    protected String _colorName;

    public String getColorName() {
        return _colorName;
    }
    public color getColorRGB() {
        return _colorRGB;
    }
    public void setColor(color c) {
        _colorRGB = c;
    }

}
