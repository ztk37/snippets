defmodule Adapter do
  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)

      def first(_) do
        nil
      end

      def second(_) do
        nil
      end

      defoverridable  first: 1, second: 1
    end
  end

  @callback first(term) :: nil

  @callback second(term) :: nil
end

defmodule Concrete do
  use Adapter
  
  # @impl Adapter
  def first(_), do: nil

  # @impl Adapter
  def second(_), do: nil
end
