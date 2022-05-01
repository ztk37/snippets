defmodule Store do
  use Agent

  @initial_state %{
    :items => []
  }

  def start_link() do
    Agent.start_link(fn -> @initial_state end)
  end

  def add_item(pid, item) do
    # IO.inspect(item)

    Agent.update(pid, fn state ->
      %{state | :items => [item | state.items ]}
    end)
  end

  def get_items(pid) do
    Agent.get(pid, fn state -> state[:items] end)
  end
end

defmodule DSL do
  defmacro __using__(_opts) do
    {:ok, pid} = Store.start_link()

    quote do
      def item(item), do: Store.add_item(unquote(pid), item)
      def items(), do: Store.get_items(unquote(pid))
    end
  end
end

defmodule Main do
  use DSL

  def run() do
  	item(1)
    item(2)
    item(3)

    items() |> IO.inspect()
  end
end

Main.run()
