import java.util.*;

public final class NormalAnts extends Ants {

    public NormalAnts(Grid map, color traceColor) {
        super(map, traceColor);
    }

    private boolean nullPheromoneValue(ArrayList < Cell > neighbors) {
        for (Cell c: neighbors)
            if (c instanceof EmptyCell)
                if (((EmptyCell) c).getPheromoneValue() != 0)
                    return false;
        return true;
    }

    private float totalAmountOfPheromone(ArrayList < Cell > neighbors) {
        float total = 0;
        for (Cell c: neighbors)
            if (c instanceof EmptyCell)
                total += Math.pow(((EmptyCell) c).getPheromoneValue(), 2);
        return total;
    }

    private Map < Double, Cell > adjacentCellsProbabilities(ArrayList < Cell > neighbors) {
        float sumSquareOfPheromone = (float) totalAmountOfPheromone(neighbors);
        Map < Double, Cell > cellsAndProbabilties = new TreeMap < Double, Cell > (Collections.reverseOrder());
        int i = 1;
        for (Cell c: neighbors) {
            if (c instanceof EmptyCell) {
                Double probability = (Double)(Math.pow(((EmptyCell) c).getPheromoneValue(), 2) / sumSquareOfPheromone);
                if (cellsAndProbabilties.containsKey(probability)) probability += (i++) * 0.00001;
                probability = Math.floor(probability * 100000) / 100000;
                cellsAndProbabilties.put(probability, c);
            }
        }

        return cellsAndProbabilties;
    }

    private Map < Double, Cell > adjacentCellsDistanceToTheNest(Map < Double, Cell > cellsAndProbabilties) {
        Map < Double, Cell > cellsAndDistances = new TreeMap < Double, Cell > (Collections.reverseOrder());
        Set set = cellsAndProbabilties.entrySet();
        Iterator it = set.iterator();
        int i = 1;
        while (it.hasNext()) {
            Map.Entry mapCell = (Map.Entry) it.next();
            Double distance = (Double)((Cell) mapCell.getValue()).distance(_map.getColony());
            if (cellsAndDistances.containsKey(distance)) {
                distance += (i++) * 0.001;
            }
            distance = Math.floor(distance * 10000) / 10000;
            cellsAndDistances.put(distance, ((Cell) mapCell.getValue()));
        }

        return cellsAndDistances;
    }

    private Cell getItAway(Map < Double, Cell > cellsAndProbabilties, Map < Double, Cell > cellsAndDistances) {
        Set set1 = cellsAndProbabilties.entrySet();
        Iterator it1 = set1.iterator();
        Set set2 = cellsAndDistances.entrySet();
        Iterator it2 = set2.iterator();

        Map < Integer, Cell > cellsAndIndexes = new TreeMap < Integer, Cell > (Collections.reverseOrder());
        while (it1.hasNext()) {
            Map.Entry mapCell1 = (Map.Entry) it1.next();
            Cell c1 = (Cell) mapCell1.getValue();
            boolean b = false;
            int i = 0;

            while (it2.hasNext() && b == false) {
                Map.Entry mapCell2 = (Map.Entry) it2.next();
                Cell c2 = (Cell) mapCell2.getValue();
                i++;
                if (c1.getPosition().getX() == c2.getPosition().getX() && c1.getPosition().getY() == c2.getPosition().getY()) {
                    cellsAndIndexes.put(i, c1);
                    b = true;
                }
            }
            it2 = set2.iterator();
        }
        //Map<Integer, Cell> map = new TreeMap<Integer, Cell>(cellsAndIndexes);
        Set set = cellsAndIndexes.entrySet();
        Iterator it = set.iterator();
        println(cellsAndIndexes);
        return (Cell)((Map.Entry) it.next()).getValue();
    }


    public void moveRandomly() {
        ArrayList < Cell > neighbors = antNeighbors.getNeighbors(_map.getMapComponent(), currentPos, _map.getCellNumber());

        Map < Double, Cell > cellsAndProbabilties = adjacentCellsProbabilities(neighbors);
        Map < Double, Cell > cellsAndDistances = adjacentCellsDistanceToTheNest(cellsAndProbabilties);
        _stepsCounter++;
        currentPos = getItAway(cellsAndProbabilties, cellsAndDistances);

        if (currentPos instanceof Food) println("Done!");
    }

}
