str = "acb"


defmodule Lib do
  def parse(str) do
    str
    |> String.split("", trim: true)
    |> Enum.reduce([], fn(chr, acc) ->
      # IO.puts(chr)
      parsed = do_parse(chr)
      acc ++ [parsed]
    end)
  end

  def debug(chr), do: do_parse(chr)

  def parse_r(str), do: parse_r(str, [])

  def parse_r("", acc), do: acc

  def parse_r(str, acc) do
    {term, rest} = do_parse_r(str)
    parse_r(rest, acc ++ [term])
  end

  defp do_parse_r("a" <> rest), do: {:a, rest}
  defp do_parse_r("b" <> rest), do: {:b, rest}
  defp do_parse_r("c" <> rest), do: {:c, rest}
  defp do_parse_r(rest), do: {:error, rest}

  defp do_parse("a"), do: {:a, "a"}
  defp do_parse("b"), do: {:b, "b"}
  defp do_parse("c"), do: {:c, "c"}
  defp do_parse(_), do: {:error, nil}
end

IO.puts(str)
# str |> hd() |> IO.puts()
"acb" |> Lib.parse() |> IO.inspect()
"acb" |> Lib.parse_r() |> IO.inspect()
"a" |> Lib.debug() |> IO.inspect()
