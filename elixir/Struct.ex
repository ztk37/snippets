defmodule App do
  defmodule Config do
    @type t :: %__MODULE__{
        id: String.t,
        value: String.t,
        params: [String.t]
    }
    
    defstruct id: nil, value: nil, params: []
    
    def id(%Config{id: id}), do: id
    
    def add_param(%Config{params: params} = config, param) do
      %{config | params: [param | params]}
    end
  end

  defmodule Main do
    @spec run() :: App.Config.t
    def run, do: %App.Config{}
  end
end

App.Main.run()
|> App.Config.add_param("foo")
|> App.Config.add_param("bar")
|> App.Config.add_param("fib")
|> IO.inspect()
