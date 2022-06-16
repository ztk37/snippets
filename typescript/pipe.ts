type Op<T extends any, R> = (value: T) => R;

export default function pipe(): <R>(value: R) => R;

export default function pipe<F extends Function>(op: F): F;

export default function pipe<A, T extends any, R>(
  op1: Op<T, A>,
  op2: Op<A, R>
): Op<T, R>;

export default function pipe<A, B, T extends any, R>(
  op1: Op<T, A>,
  op2: Op<A, B>,
  op3: Op<B, R>
): Op<T, R>;

export default function pipe<A, B, C, T extends any, R>(
  op1: Op<T, A>,
  op2: Op<A, B>,
  op3: Op<B, C>,
  op4: Op<C, R>
): Op<T, R>;

export default function pipe<A, B, C, D, T extends any, R>(
  op1: Op<T, A>,
  op2: Op<A, B>,
  op3: Op<B, C>,
  op4: Op<C, D>,
  op5: Op<D, R>
): Op<T, R>;

export default function pipe<A, B, C, D, E, T extends any, R>(
  op1: Op<T, A>,
  op2: Op<A, B>,
  op3: Op<B, C>,
  op4: Op<C, D>,
  op5: Op<D, E>,
  op6: Op<E, R>
): Op<T, R>;

export default function pipe<A, B, C, D, E, F, T extends any, R>(
  op1: Op<T, A>,
  op2: Op<A, B>,
  op3: Op<B, C>,
  op4: Op<C, D>,
  op5: Op<D, E>,
  op6: Op<E, F>,
  op7: Op<F, R>
): Op<T, R>;

export default function pipe<A, B, C, D, E, F, G, T extends any, R>(
  op1: Op<T, A>,
  op2: Op<A, B>,
  op3: Op<B, C>,
  op4: Op<C, D>,
  op5: Op<D, E>,
  op6: Op<E, F>,
  op7: Op<F, G>,
  op8: Op<G, R>
): Op<T, R>;

export default function pipe<A, B, C, D, E, F, G, H, T extends any, R>(
  op1: Op<T, A>,
  op2: Op<A, B>,
  op3: Op<B, C>,
  op4: Op<C, D>,
  op5: Op<D, E>,
  op6: Op<E, F>,
  op7: Op<F, G>,
  op8: Op<G, H>,
  op9: Op<H, R>
): Op<T, R>;

export default function pipe<R>(
  op1: (value: any) => R,
  ...ops: Function[]
): (value: any) => R;

export default function pipe(...ops: Function[]) {
  if (ops.length === 0) return <T>(value: T) => value;
  if (ops.length === 1) return ops[0];

  return ops.reduceRight(
    (prevOp, nextOp) => (value: any) => prevOp(nextOp(value))
  );
}
