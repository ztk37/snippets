defmodule DSL do
  defmacro __using__(_) do
    quote do
      @before_compile unquote(__MODULE__)

      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :lists, accumulate: true)

      # FIX: read module attribute correclty
      def values(name) do
        @lists
      end
    end
  end

  defmacro __before_compile__(_) do
    quote do
      def __lists__, do: @lists
    end
  end

  defmacro list(name, do: block) do

    quote do
      Module.register_attribute(__MODULE__, :internal_list, accumulate: true)
      unquote(block)
      @lists {unquote(name), :internal_list}
      Module.delete_attribute(__MODULE__, :internal_list)
    end
  end

  defmacro item(value) do
    quote do
      @internal_list [unquote(value) | @internal_list]
    end
  end
end

defmodule Main do
  use DSL

  list :a do
    item 1
    item 2
    item 3
  end

  list :b do
    item 4
    item 5
    item 6
  end

  list :c do
    item 7
    item 8
    item 9
  end

  def run() do
    values(:a) |> IO.inspect()
    values(:b) |> IO.inspect()
    values(:c) |> IO.inspect()
  end
end

Main.run()
