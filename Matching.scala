val a = true;
val b = false;

val n = (a, b) match {
  case (true, true) => 2
  case (true, false) => 1
  case (false, true) => 1
  case (false, false) => 0
}

object Lib {
  def valueOf(pair: (Boolean, Boolean)): Int = pair match {
    case (true, true) => 2
    case (true, false) => 1
    case (false, true) => 1
    case (false, false) => 0
  }
}


println(n);
println(Lib.valueOf(true, true));
println(Lib.valueOf(false, true));
println(Lib.valueOf(false, false));

val m = Map(
  "a" -> 1,
  "b" -> 2,
  "c" -> 3
);

m.get("d") match {
  case Some(v) => println(v)
  case None => println("value does not exists")
}

val x = m.get("a") match {
  case Some(v) => v
  case None => "value does not exists"
}

println(x)

def eval(input: String): Unit = input.split("\\s+") match {
  case Array("help") => println("help dialog")
  case Array(cmd, arg) => println(cmd ++ ": " ++ arg)
  case _ => println("parsing error")
}

eval("")
eval("help")
eval("cmd --v")
eval("cmd --X")
eval("bar --input=/path/to/file.json")
