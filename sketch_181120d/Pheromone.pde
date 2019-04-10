public final class Pheromone {

    private float _value;
    private float Q;
    private final float evaporationRate = 0.2;


    public Pheromone() {
        _value = 0;
        Q = 10000;
    }

    public float getValue() {
        return _value;
    }

    public void setValue(float value) {
        _value = value;
    }

    public void incrementation(double length) {
      _value += Q/length;
    }

    public void evaporation() {
      _value = (1-evaporationRate)*_value;
    }

}
