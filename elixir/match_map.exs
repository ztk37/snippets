f = fn
  n when is_number(n) -> n * 2
  %{n: n}  -> n * 2
  {:double, n} -> n * 2
end

f.(32) |> IO.inspect()
f.({:double, 21}) |> IO.inspect()
f.(%{n: 21}) |> IO.inspect()

defmodule Lib do
  def compute(n) when is_number(n), do: n * 2
  def compute(%{x: n}), do: n * 2
  def compute({:double, x}), do: x * 2
end

Lib.compute(1) |> IO.inspect()
Lib.compute(%{x: 3}) |> IO.inspect()
