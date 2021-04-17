sealed trait ABC;
// abstract class ABC;

case class A() extends ABC;
case class B() extends ABC;
case class C() extends ABC;

def abcToString(abc: ABC): String = abc match {
  case A() => "A";
  case B() => "B";
  case C() => "C";
};

println(abcToString(A()));
println(abcToString(B()));
println(abcToString(C()));
