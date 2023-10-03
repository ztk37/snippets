case class Container[A](value: A)

trait Functor[F[_]] {
  def map[A, B](fa: F[A])(f: A => B): F[B]
}

object Functor {
  def apply[F[_]](implicit instance: Functor[F]): Functor[F] = instance
}

object FunctorInstances {
  implicit val functorForContainer: Functor[Container] =
    new Functor[Container] {
      def map[A, B](fa: Container[A])(f: A => B): Container[B] = Container(
        f(fa.value)
      )
    }
}

import FunctorInstances._

println(Functor[Container].map(Container(10))((x: Int) => x * x))

// TODO: How can I do something like `Container(10).map(x => x * x)` ?
