// type PredicateFn<T> = (input: T) => boolean

class Predicate<T> {
    private constructor(private _predicate: (input: T) => boolean) {

    }

    static from<T>(predicate: (input: T) => boolean) {
        return new Predicate<T>(predicate)
    }

    all(...ps: Predicate<T>[]): Predicate<T> {
        return new Predicate<T>((input) => ps.reduce((result, p) => result && p.run(input), true))
    }

    any(...ps: Predicate<T>[]): Predicate<T> {
        return new Predicate<T>((input) => ps.reduce((result, p) => result || p.run(input), false))
    }

    run(input: T) {
        return this._predicate(input)
    }
}
console.log(Predicate.from<string>((input) => input === input.toUpperCase()).run("foo"))
