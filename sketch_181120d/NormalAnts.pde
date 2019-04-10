import java.util.*;

public final class NormalAnts extends Ants{

  public NormalAnts(Grid map, color traceColor) {
    super(map, traceColor);
  }

  private boolean nullPheromoneValue(ArrayList < Cell > neighbors){
    for(Cell c: neighbors)
      if(c instanceof EmptyCell)
        if(((EmptyCell)c).getPheromoneValue() != 0)
          return false;
    return true;
  }

  private float totalAmountOfPheromone(ArrayList < Cell > neighbors){
    float total = 0;
    for(Cell c : neighbors)
      if(c instanceof EmptyCell)
        total += Math.pow(((EmptyCell)c).getPheromoneValue(),2);
    return total;
  }

  private Map<Double, Cell> adjacentCellsProbabilities(ArrayList < Cell > neighbors){
    float sumSquareOfPheromone = (float) totalAmountOfPheromone(neighbors);
    Map<Double, Cell> cellsAndProbabilties = new TreeMap<Double, Cell>(Collections.reverseOrder());
    int i = 1;
    for(Cell c: neighbors){
      if(c instanceof EmptyCell){
        Double probability = (Double) (Math.pow(((EmptyCell)c).getPheromoneValue(), 2)/sumSquareOfPheromone);
        if(cellsAndProbabilties.containsKey(probability)) probability += (i++)*0.00001;
        probability = Math.floor(probability * 100000) / 100000;
        cellsAndProbabilties.put(probability, c);
      }
    }

    return cellsAndProbabilties;
  }

  private Map<Double, Cell> adjacentCellsDistanceToTheNest(Map<Double, Cell> cellsAndProbabilties){
    Map<Double, Cell> cellsAndDistances = new TreeMap<Double, Cell>(Collections.reverseOrder());
    Set set = cellsAndProbabilties.entrySet();
    Iterator it = set.iterator();
    int i = 1;
    while(it.hasNext()) {
      Map.Entry mapCell = (Map.Entry)it.next();
      Double distance = (Double) ((Cell)mapCell.getValue()).distance(_map.getColony());
      if(cellsAndDistances.containsKey(distance)){
        distance += (i++)*0.001;
      }
      distance = Math.floor(distance * 10000) / 10000;
      cellsAndDistances.put(distance, ((Cell)mapCell.getValue()));
    }

    return cellsAndDistances;
  }

  private Cell getAwayFromTheNest(Map<Double, Cell> cellsAndDistances){
    Set set = cellsAndDistances.entrySet();
    Iterator it = set.iterator();
    Iterator it1 = set.iterator();
    Cell c = (Cell) ((Map.Entry)it1.next()).getValue();
    Random rand = new Random();

    /*if(cellsAndDistances.size() > 1 && cellsAndDistances.size() < 4){
      int i = 0;
      while(it.hasNext()) {
        Map.Entry mapCell = (Map.Entry)it.next();
        if(i == rand.nextInt(cellsAndDistances.size())+1){
          c =  (Cell) mapCell.getValue();
        }
        i++;
      }
    }*/

    return c;
  }

  public void moveRandomly(){
    ArrayList < Cell > neighbors = antNeighbors.getNeighbors(_map.getMapComponent(), currentPos, _map.getCellNumber());

    Map<Double, Cell> cellsAndProbabilties = adjacentCellsProbabilities(neighbors);
    Map<Double, Cell> cellsAndDistances = adjacentCellsDistanceToTheNest(cellsAndProbabilties);
    println(currentPos);
    _stepsCounter++;
    println(_stepsCounter);
    currentPos = getAwayFromTheNest(cellsAndDistances);
    //noLoop();
    println(currentPos);
    if(currentPos instanceof Food) println("Done!");
  }

}
