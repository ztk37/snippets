defmodule Kind do
  defmacro __using__(kind) do
    quote do
      @behaviour unquote(__MODULE__)
      def kind, do: unquote(kind)
    end
  end

  @type kind ::
    :a
    | :b
    | :c

  @callback kind() :: kind()

  def kinds() do
    [
      :a,
      :b,
      :c
	]
  end
end

defmodule A do
  use Kind, :a

  def run, do: kind()
end

defmodule B do
  use Kind, :b

  def run, do: kind()
end

defmodule C do
  use Kind, :c

  def run, do: kind()
end

A.run() |> IO.inspect()
B.run() |> IO.inspect()
C.run() |> IO.inspect()
