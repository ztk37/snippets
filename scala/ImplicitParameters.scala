def add(a: Int)(implicit b: Int): Int = a + b

def work() = {
    implicit val b = 5
    
    println(add(4))
}

work()
