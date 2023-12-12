case class Position(val x: Int, y: Int, z: Int)

object PositionBuilder {
  type Modifier = Position => Position

  type Build = Seq[Modifier] => Position

  def apply(initial: Position): Build = fns =>
    Function.chain(fns).apply(initial)

  def apply(): Build = apply(Position(0, 0, 0))

  def x(value: Int): Modifier = pos => pos.copy(x = value)
  def y(value: Int): Modifier = pos => pos.copy(y = value)
  def z(value: Int): Modifier = pos => pos.copy(z = value)
}

object Main extends App {
  val builder = PositionBuilder()
  
  println(builder(Seq(PositionBuilder.x(1))))
}
