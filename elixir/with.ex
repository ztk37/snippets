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
}) |> IO.inspect

# https://www.openmymind.net/Elixirs-With-Statement/
