@Category(Integer)
class IntegerExtension {
    Integer twice() {
        this * 2
    }
    
    Integer thrice() {
        this * 3
    }
}

use (IntegerExtension) {
    println(3.twice())
    println(5.thrice())
}
