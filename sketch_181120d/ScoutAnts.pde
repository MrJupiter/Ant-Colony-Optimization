import java.util.Random;
import java.util.Collections;

public final class ScoutAnts extends Ants{
  private int _lifetime;

  public ScoutAnts(Grid map, color traceColor, int lifetime) {
    super(map, traceColor);
    _lifetime = lifetime;
  }

  public int getLifetime(){
    return _lifetime;
  }

  public void moveRandomly(){
      _stepsCounter++;
      ArrayList < Cell > neighbors = antNeighbors.getNeighbors(_map.getMapComponent(), currentPos, _map.getCellNumber());

      Random rand = new Random();
      int possibilities = (neighbors.size() == 1)? 0: rand.nextInt(neighbors.size());
      currentPos = neighbors.get(possibilities);

      if(currentPos instanceof EmptyCell && ((EmptyCell)currentPos).getPheromoneValue() == 0)
        currentPos.setColor(_traceColor);

      visitedCells.add(currentPos);
  }


}
