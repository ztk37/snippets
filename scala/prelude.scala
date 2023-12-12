object prelude {
  implicit class OptionOps[A](value: Option[A]) {
    def ??(fallback: A): A = value.getOrElse(fallback)
  }
}

object Main extends App {
  import prelude._

  println(None ?? 42)
  println(Some(21) ?? 1337)
}
