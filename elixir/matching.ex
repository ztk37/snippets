defmodule Lib do
    @type msg :: { :inc } | { :dec }
    
    @spec compute(msg()) :: integer() | nil
    def compute(msg) do
        case msg do
         {:inc} -> 1
         {:dec} -> -1
         _ -> nil
        end
    end
end

{} |> Lib.compute() |> IO.puts()
