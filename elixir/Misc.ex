defmodule Data do
  def kv() do
    [
      {:a, 1},
      {:b, 2},
      {:c, 3},
      {:d, 4},
      {:e, 5},
      {:f, 6},
      {:g, 7},
	]
  end

  def match([{:a, x} | xs]) do
    {:a, x, xs}
  end

  def match([x | xs]) do
    {x, xs}
  end
end

defmodule Lib do
  def random_events do
    for _ <- 1..10, do: random_event()
  
   # List.duplicate(random_event(), 10)
  end

  def random_event() do
    elem({:inc, :dec}, :rand.uniform(2) - 1)
  end

  def event_sample1,
    do: [:inc, :dec, :inc, :dec, :inc, :dec, :dec, :dec, :dec, :dec]

  def event_sample2,
    do: [:dec, :dec, :dec, :dec, :inc, :dec, :dec, :inc, :inc, :dec]

  def event_sample3,
    do: [:dec, :dec, :inc, :inc, :inc, :inc, :inc, :dec, :inc, :inc]

  def match({:a, x}) do
    {:a, x, :derp}
  end

  def match({atom, value}) do
    {Atom.to_string(atom), value, :damn}
  end

  def reducer(:inc, acc), do: acc + 1
  def reducer(:dec, acc), do: acc - 1
end

defmodule Main do
  def run() do
	Data.kv()
    |> Keyword.get(:b)
  end
end

Main.run()
|> IO.inspect()
