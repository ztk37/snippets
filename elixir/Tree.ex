defmodule Tree do
  defmodule Node do
    defstruct [value: nil, left: nil, right: nil]
  end
end

defmodule Lib do
  @spec info(module::term(), keys :: [atom()]) :: map()
  def info(module, keys)

  def info(_module, []), do: %{}

  def info(module, keys) do
    Enum.reduce(keys, %{}, fn key, info ->
      Map.put(info, key, module.__info__(key))
    end)
  end

  @spec ap(value :: term()) :: ((term() -> term()) -> term())
  def ap(_y) do
    fn _x ->
      fn _z ->
        nil
      end
    end
  end
end

Tree.__info__(:macros) |> IO.inspect
Tree.Node.__info__(:macros) |> IO.inspect

Lib.info(Tree, [
  :attributes,
  :compile,
  :functions,
  :macros,
  :md5,
  :module
]) |> IO.inspect()

