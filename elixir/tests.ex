defmodule Data.Task do
  alias Data.Task
  alias Data.Action

  defstruct actions: %{}

  def empty, do: %Data.Task{}

  def add_action(%Task{actions: actions} = task, id, description) do
    %{task | actions: Map.put(actions, id, Action.new(description))}
  end
  
    
  def fetch(%Task{actions: actions} = _, id) do
    Map.fetch(actions, id)
  end
end

defmodule Data.Action do
  alias Data.Action

  defstruct description: ""

  def empty, do: %Action{}

  def new(description) do
    %Action{
      description: description
    }
  end

  def update_description(action, description) do
    %{action | description: description}
  end
end

Data.Task.empty()
|> Data.Task.add_action(1, "asdad")
|> Data.Task.add_action(2, "d3asd")
|> Data.Task.add_action(3, "2s2eq")
|> IO.inspect()

Data.Task.empty()
|> Data.Task.add_action(1, "asdad")
|> Data.Task.add_action(2, "d3asd")
|> Data.Task.add_action(3, "2s2eq")
|> Data.Task.fetch(1)
|> case do
    {:ok, data} -> data.description |> String.upcase
    :error -> raise :error
   end
|> IO.inspect

Data.Action.new("asdad3q")
|> Data.Action.update_description("dadwqasad")
|> IO.inspect()
