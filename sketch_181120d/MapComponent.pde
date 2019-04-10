/*
  This class is the component class
  Reminder: Composite is a design pattern that allowing us to have a project architecture respecting the 'SOLID' rule
  The Component Class :  
    is the abstraction for all components, including composite ones
    declares the interface for objects in the composition
    (optional) defines an interface for accessing a component's parent in the recursive structure, and implements it if that's appropriate
*/

public interface MapComponent {
    public void drawMap();
}
