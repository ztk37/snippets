# Compiled using Elchemy v0.7.4
defmodule Main do
  use Elchemy

  
  @spec run() :: String.t
  def run() do
    "Hello, world!"
  end

  @type action :: :inc | :dec | :double | {:mul, integer} | {:add, integer} | {:sub, integer}

  @type state :: integer

  @spec update(action, state) :: state
  curry update/2
  def update(action, state) do
    case action do
      :inc ->
        (state + 1)
      :dec ->
        (state - 1)
      :double ->
        (state * 2)
      {:mul, n} ->
        (state * n)
      {:add, n} ->
        (state + n)
      {:sub, n} ->
        (state - n)
    end
  end

end
