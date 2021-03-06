class Scalar {
    private value;

    constructor(value: number) {
        this.value = value;
    }

    public static of(value: number): Scalar {
        return new Scalar(value);
    }

    public add(n: number): Scalar {
        return new Scalar(this.value + n)
    }

    public substract(n: number): Scalar {
        return new Scalar(this.value - n);
    }
    public apply(f: (x: number) => number): Scalar {
        return new Scalar(f(this.getValue()));
    }

    public getValue(): number {
        return this.value;
    }
}

class Point {
    private x: Scalar;
    private y: Scalar;

    constructor(x: number, y: number) {
        this.x = new Scalar(x);
        this.y = new Scalar(y);
    }

    public static of(x: number, y: number): Point {
        return new Point(x, y);
    }

    public static from([x, y]: number[]): Point {
        return new Point(x, y);
    }

    public translateX(n: number): Point {
        return new Point(this.x.add(n).getValue(), this.y.getValue());
    }

    public translateY(n: number): Point {
        return new Point(this.x.getValue(), this.x.add(n).getValue());
    }

    public toArray(): [number, number] {
        return [this.x.getValue(), this.y.getValue()];
    }

    public print(): void {
        console.log(`Point(${this.x.getValue()}, ${this.y.getValue()})`);
    }
}

const p1 = Point.of(1, 3).translateX(10).translateY(-3);

console.log(p1)
console.log(p1.toArray())
p1.print()

const s1 = Scalar.of(11).add(10).apply(x => x * 3).substract(21).getValue()

console.log(s1);
