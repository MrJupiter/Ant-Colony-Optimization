public abstract class Ants{
  protected Cell currentPos;
  protected Grid _map;
  protected AntNeighbors antNeighbors = new AntNeighbors();
  protected ArrayList<Cell> visitedCells = new ArrayList<Cell>();
  protected color _traceColor;
  protected int _stepsCounter = 0;

  public Ants(Grid map, color traceColor) {
    _map = map;
    currentPos = _map.getColony();
    visitedCells.add(currentPos);
    _traceColor = traceColor;
  }

  public int getStepsCounter(){
    return _stepsCounter;
  }

  public boolean doesFoodExist(){
    for(Cell c: visitedCells)
      if(c instanceof Food)
        return true;
    return false;
  }

  public boolean isInTheNest(){
    return (currentPos instanceof ColonyLocation);
  }

  public void deleteTrace(){
    for(Cell c : visitedCells)
      if((c instanceof EmptyCell) && ((EmptyCell)c).getPheromoneValue() == 0)
        c.setColor(color(255,255,255));
  }

  public void comeback(){
    currentPos = visitedCells.get(_stepsCounter-1);
    if(currentPos instanceof ColonyLocation)  println("Nest!");
    if(!(currentPos instanceof ColonyLocation) && !(currentPos instanceof Food)){
      _stepsCounter--;

      ((EmptyCell)currentPos).pheromoneInc(currentPos.distance(_map.getColony()));
      //println(currentPos + " pher: " + ((EmptyCell)currentPos).getPheromoneValue());

      for(int i=1; i<_stepsCounter; ++i){
        ((EmptyCell)visitedCells.get(i)).pheromoneEvap();
        ((EmptyCell)visitedCells.get(i)).updateCellColor();
      }
      ((EmptyCell)visitedCells.get(_stepsCounter)).updateCellColor();
    }
  }

  public abstract void moveRandomly();

}
