// discriminated union

interface Failure<E> {
    _tag: "failure"
    reason: E
}
interface Success<T> {
    _tag: "success"
    value: T
}

type Result<T, E> = Success<T> | Failure<E>

function result<T, U, E>(
    r: Result<T, E>,
    f: (_: Success<T>) => U,
    g: (_: Failure<E>) => U
): U {
    switch (r._tag) {
        case "success": return f(r)
        case "failure": return g(r)
    }
}

function mapResult<T, U, E>(
  f: (_: T) => U,
  r: Result<T, E>
): Result<U, E> {
    switch (r._tag) {
        case "success": return {
          _tag: "success",
          value: f(r.value)
        }
        case "failure": return r
    }
}

function mapSuccess<T, U>(
  f: (_: T) => U,
  {value}: Success<T>
): Success<U> {
  return {
    _tag: "success",
    value: f(value)
  }
}

type SuccessFactory<T> = (_: T) => Success<T>
type FailureFactory<E> = (_: E) => Failure<E>

const success: SuccessFactory<number> = value => ({
  _tag: "success",
  value
})

const failure: FailureFactory<string> = reason => ({
  _tag: "failure",
  reason
})

const value = result<number, number, number>(
  success(42),
  arg => arg.value,
  arg => arg.reason
);
  
console.log(value);

// Or class based

type UniFunction<T, U> = (arg: T) => U;

abstract class Result<T, E> {
    abstract match<U>(
        f: UniFunction<Success<T, E>, U>,
        g: UniFunction<Failure<T, E>, U>,
    ): U;
}

class Success<T, E> extends Result<T, E> {
    public value: T;

    constructor(value: T) {
        super()
        this.value = value;
    }

    match<U>(
        f: UniFunction<Success<T, E>, U>,
        g: UniFunction<Failure<T, E>, U>
    ): U { return f(this); }
}

class Failure<T, E> extends Result<T, E> {
    public reason: E;

    constructor(reason: E) {
        super()
        this.reason = reason;
    }

    match<U>(
        f: UniFunction<Success<T, E>, U>,
        g: UniFunction<Failure<T, E>, U>
    ): U { return g(this); }
}
