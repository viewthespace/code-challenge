import scala.collection.immutable.Set;

case class LightStrandSet(lights: Set[Int] = Set[Int]()) {
  def isOn(index: Int): Boolean = lights.contains(index)
  
  def toggle(start: Int, end: Int): LightStrandSet = (start, end) match {
    case (start, end) if start > end => this
    case (start, end) if lights.contains(start) => LightStrandSet(lights - start).toggle(start + 1, end) 
    case (start, end) => LightStrandSet(lights + start).toggle(start + 1, end)
  }
}

class LightStrandSetMutable {
  
  var lights = Set[Int]()
 
  def isOn(index: Int): Boolean = {
    lights.contains(index)
  }

  def toggle(start: Int, end: Int): Unit = (start, end) match {
    case (start, end) if start > end =>
    case (start, end) if lights.contains(start) => lights -= start; toggle(start + 1, end)
    case (start, end) => lights += start; toggle(start + 1, end)
  }
}