defmodule User do
    defstruct name: nil, dob: nil
    
    def empty, do: %User{} 
    
    def create(params) do
        with {:ok, dob} <- parse_dob(params["dob"]),
             {:ok, name} <- parse_name(params["name"])
        do
          %User{dob: dob, name: name}
        else
          err -> err
        end
    end
    
    defp parse_dob(nil), do: {:error, "dob is required"}
    defp parse_dob(dob) when is_integer(dob), do: {:ok, dob}
    defp parse_dob(_invalid), do: {:error, "dob must be an integer"}
    
    defp parse_name(nil), do: {:error, "name is required"}
    defp parse_name(""), do: parse_name(nil)
    defp parse_name(name), do: {:ok, name}
end

User.create(%{
    "dob" => 1,
    "name" => "damn"
}) |> IO.inspect()

defmodule Core.Something do
  alias __MODULE__

  defstruct name: nil, value: nil
  
  def create(params \\ []) do
    with { :ok, name } <- validate_name(Keyword.get(params, :name)),
         { :ok, value } <- validate_value(Keyword.get(params, :value))
    do
      %Something{name: name, value: value}
    else
      error -> error
    end
  end
  
  defp validate_name(nil), do: { :error, "Name can't be nil" }
  defp validate_name(""), do: { :error, "Name can't be empty"}
  defp validate_name(name) when is_binary(name), do: { :ok, name }
  
  defp validate_value(nil), do: { :error, "Value can't be nil" }
  defp validate_value(""), do: { :error, "Value can't be empty"}
  defp validate_value(value) when is_binary(value), do: { :ok, value }
end

Core.Something.create(name: "Somebody", value: "Some Value") |> IO.inspect()

# https://www.openmymind.net/Elixirs-With-Statement/
