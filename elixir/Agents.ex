defmodule KV do
  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  def get(kv, key) do
    Agent.get(kv, &Map.get(&1, key))
  end

  def put(kv, key, value) do
    Agent.update(kv, &Map.put(&1, key, value))
  end
end

{:ok, kv} = KV.start_link

KV.put(kv, "a", 1)
KV.put(kv, "b", 2)
KV.put(kv, "c", 3)

IO.inspect KV.get(kv, "a")

defmodule Count do
  def start_link do
    Agent.start_link(fn -> 0 end)
  end

  def get(c) do
    Agent.get(c, & &1)
  end

  def increment(c) do
    Agent.update(c, &(&1 + 1))
  end
end

{:ok, c} = Count.start_link

Count.increment(c)
Count.increment(c)
Count.increment(c)
Count.increment(c)

IO.inspect(Count.get(c))
