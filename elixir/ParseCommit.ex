 Regex.run(~r/(\w+)\((\w+)\):\s+([\w\s]+)/, "impl(core): add plugin interface")
 |> Enum.at(0)
