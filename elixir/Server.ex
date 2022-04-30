defmodule Store do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  # Client

  def add(pid, item) do
    GenServer.call(pid, {:add, item})
  end

  def values(pid) do
    GenServer.call(pid, :values)
  end

  # Server

  @impl true
  def init(_) do
    {:ok, []}
  end

  @impl true
  def handle_call({:add, item}, _from, items) do
    {:reply, nil, [item | items]}
  end

  @impl true
  def handle_call(:values, _from, items) do
    {:reply, items, items}
  end
end

{:ok, pid} = Store.start_link()

GenServer.call(pid, {:add, 3})
GenServer.call(pid, {:add, 5})
GenServer.call(pid, {:add, 7})
GenServer.call(pid, {:add, 11})

GenServer.call(pid, :values)
|> IO.inspect()

Store.add(pid, 13)
Store.add(pid, 17)
Store.add(pid, 21)
Store.values(pid)
|> IO.inspect()

defmodule Client do
  def add(pid, item) do
    GenServer.call(pid, {:add, item})
  end

  def values(pid) do
    GenServer.call(pid, :values)
  end
end

defmodule Server do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  @impl true
  def init(_) do
    {:ok, []}
  end

  @impl true
  def handle_call({:add, item}, _from, items) do
    {:reply, nil, [item | items]}
  end

  @impl true
  def handle_call(:values, _from, items) do
    {:reply, items, items}
  end
end

{:ok, server_pid} = Server.start_link()

Client.add(server_pid, 3)
Client.values(server_pid) |> IO.inspect()
