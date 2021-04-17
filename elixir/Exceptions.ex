defmodule Scope do
  defmodule Exception do
    defmodule Foo do
      defexception [:message]
    end

    defmodule Bar do
      defexception [:message]
    end

    defmodule Fib do
      defexception [:message]
    end
  end
end

defmodule Scope.Exception.Baz do
  defexception [:message]
end

defmodule Lib do
  def run(:foo) do
    raise %Scope.Exception.Foo{
      message: "derp"
    }
  end

  def run(:bar) do
    raise %Scope.Exception.Bar{
      message: "derp"
    }
  end

  def run(:fib) do
    raise %Scope.Exception.Fib{
      message: "derp"
    }
  end

  def run(:baz) do
    raise %Scope.Exception.Baz{
      message: "derp"
    }
  end
end

Lib.run(:baz)
