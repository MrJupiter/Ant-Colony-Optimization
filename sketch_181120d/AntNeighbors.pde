public final class AntNeighbors {
    private ArrayList < Cell > _neighbors;

    public AntNeighbors(){
        _neighbors = new ArrayList < Cell > ();
    }

    public ArrayList < Cell > getNeighbors(ArrayList < MapComponent > mapComponent, Cell cell, int cellNumber) {
        _neighbors.clear();
        int index = (int) mapComponent.indexOf(cell);
        int mapComponentSize = cellNumber * cellNumber - 1;
        if (index > cellNumber && index < mapComponentSize - cellNumber) {
            if (index % cellNumber == (cellNumber - 1))
                putRightNeighbors(_neighbors, mapComponent, index, cellNumber);
            else if (index % cellNumber == 0)
                putLeftNeighbors(_neighbors, mapComponent, index, cellNumber);
            else
                putOtherNeighbors(_neighbors, mapComponent, index, cellNumber);
        } else if (index <= cellNumber) {
            putAboveNeighbors(_neighbors, mapComponent, index, cellNumber);
        } else{
            putBellowNeighbors(_neighbors, mapComponent, index, cellNumber);
        }

        deleteColonyIfExists();

        return _neighbors;
    }

    private void deleteColonyIfExists(){
      for(int i = 0; i<_neighbors.size(); i++) {
        if (_neighbors.get(i) instanceof ColonyLocation) _neighbors.remove(i);
      }
    }

    private void putAboveNeighbors(ArrayList < Cell > neighbors, ArrayList < MapComponent > mapComponent, int index, int cellNumber) {
        if (!(mapComponent.get(index + cellNumber) instanceof Obstacle))
          neighbors.add((Cell)mapComponent.get(index + cellNumber));
        if(index == 0){
          if(!(mapComponent.get(index + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + 1));
          if(!(mapComponent.get(index + cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber + 1));
        }
        else if (index == cellNumber - 1) {
            if(!(mapComponent.get(index - 1) instanceof Obstacle))
              neighbors.add((Cell)mapComponent.get(index - 1));
            if(!(mapComponent.get(index + cellNumber - 1) instanceof Obstacle))
              neighbors.add((Cell)mapComponent.get(index + cellNumber - 1));
        }
        else if(index == cellNumber){
          if(!(mapComponent.get(index + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + 1));
          if(!(mapComponent.get(index + cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber + 1));
          if(!(mapComponent.get(index - cellNumber) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber));
          if(!(mapComponent.get(index - cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber + 1));
        }
        else {
          if(!(mapComponent.get(index + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + 1));
          if(!(mapComponent.get(index - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - 1));
          if(!(mapComponent.get(index + cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber + 1));
          if(!(mapComponent.get(index + cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber - 1));
        }
    }

    private void putBellowNeighbors(ArrayList < Cell > neighbors, ArrayList < MapComponent > mapComponent, int index, int cellNumber) {
        if (!(mapComponent.get(index - cellNumber) instanceof Obstacle))
          neighbors.add((Cell)mapComponent.get(index - cellNumber));
        if(index == cellNumber * cellNumber - cellNumber - 1){
          if (!(mapComponent.get(index - cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber - 1));
          if (!(mapComponent.get(index - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - 1));
          if(!(mapComponent.get(index + cellNumber) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber));
          if(!(mapComponent.get(index + cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber - 1));
        }
        else if(index == cellNumber * cellNumber - 1){
          if(!(mapComponent.get(index - cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber - 1));
          if(!(mapComponent.get(index - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - 1));
        }
        else if(index == cellNumber * cellNumber - cellNumber){
          if(!(mapComponent.get(index - cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber + 1));
          if(!(mapComponent.get(index + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + 1));
        }
        else{
          if(!(mapComponent.get(index + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + 1));
          if(!(mapComponent.get(index - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - 1));
          if(!(mapComponent.get(index - cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber + 1));
          if(!(mapComponent.get(index - cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber - 1));
        }
    }

    private void putLeftNeighbors(ArrayList < Cell > neighbors, ArrayList < MapComponent > mapComponent, int index, int cellNumber) {
        if (!(mapComponent.get(index + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + 1));
        if (!(mapComponent.get(index + cellNumber) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber));
        if (!(mapComponent.get(index + cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber + 1));
        if (!(mapComponent.get(index - cellNumber) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber));
        if (!(mapComponent.get(index - cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber + 1));
    }

    private void putRightNeighbors(ArrayList < Cell > neighbors, ArrayList < MapComponent > mapComponent, int index, int cellNumber) {
        if (!(mapComponent.get(index - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - 1));
        if (!(mapComponent.get(index + cellNumber) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber));
        if (!(mapComponent.get(index + cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber - 1));
        if (!(mapComponent.get(index - cellNumber) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber));
        if (!(mapComponent.get(index - cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber - 1));
    }

    private void putOtherNeighbors(ArrayList < Cell > neighbors, ArrayList < MapComponent > mapComponent, int index, int cellNumber) {
        if (!(mapComponent.get(index + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + 1));
        if (!(mapComponent.get(index - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - 1));
        if (!(mapComponent.get(index + cellNumber) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber));
        if (!(mapComponent.get(index - cellNumber) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber));
        if (!(mapComponent.get(index + cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber + 1));
        if (!(mapComponent.get(index - cellNumber + 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber + 1));
        if (!(mapComponent.get(index + cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index + cellNumber - 1));
        if (!(mapComponent.get(index - cellNumber - 1) instanceof Obstacle))
            neighbors.add((Cell)mapComponent.get(index - cellNumber - 1));
    }

}
