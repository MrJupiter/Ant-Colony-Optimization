public class Colony {
    private ArrayList < Ants > _scoutAnts = new ArrayList < Ants > ();
    private ArrayList < Ants > _normalAnts = new ArrayList < Ants > ();
    private int _numberOfScoutAnts;
    private int _numberOfNormalAnts;

    public Colony(int numberOfScoutAnts, int numberOfNormalAnts) {
        _numberOfScoutAnts = numberOfScoutAnts;
        _numberOfNormalAnts = numberOfNormalAnts;
    }

    public void setupColony(Grid map, int lifetime) {
        for (int i = 0; i < _numberOfScoutAnts; ++i)
            _scoutAnts.add(new ScoutAnts(map, color(145, 255, 0), lifetime));
        for (int i = 0; i < _numberOfNormalAnts; ++i)
            _normalAnts.add(new NormalAnts(map, color(169, 222, 249)));
    }


    public void scoutAntsRandomlyMove() {
        for (Ants sa: _scoutAnts)
            if (sa.getStepsCounter() < ((ScoutAnts) sa).getLifetime() + 1 && !sa.doesFoodExist()) {
                sa.moveRandomly();
            }
    }

    public void deleteLosedScoutAnts() {
        ArrayList < Ants > toBeKilled = new ArrayList < Ants > ();
        for (Ants sa: _scoutAnts)
            if (sa.getStepsCounter() > ((ScoutAnts) sa).getLifetime() && !sa.doesFoodExist()) {
                toBeKilled.add(sa);
                sa.deleteTrace();
            }
        _scoutAnts.removeAll(toBeKilled);
    }

    public void scoutAntsComeback() {
        for (Ants sa: _scoutAnts) {
            if (sa.doesFoodExist() && !sa.isInTheNest()) sa.comeback();
        }
    }

    private boolean isInTheNest() {
        for (Ants sa: _scoutAnts)
            if (sa.isInTheNest())
                return true;
        return false;
    }

    public void normalAntsRandomlyMove() {
        if (isInTheNest()) {
            for (Ants na: _normalAnts)
                if (!na.doesFoodExist())
                    na.moveRandomly();
        }
    }

    public void normalAntsComeback(ArrayList < Integer > cursusList) {
        for (Ants na: _normalAnts)
            if (na.doesFoodExist() && !na.isInTheNest()) {
                na.comeback();
                cursusList.set(_normalAnts.indexOf(na), cursusList.get(_normalAnts.indexOf(na)) + 1);
            }
    }

}
