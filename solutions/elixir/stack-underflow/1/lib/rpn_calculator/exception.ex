defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception [message: "division by zero occurred"]
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(term) do
      case term do
        [] ->
          %__MODULE__{}

        context when is_binary(context) ->
          %__MODULE__{message: "stack underflow occurred, context: #{context}"}

        _ ->
          %__MODULE__{}
      end
    end
  end

    def divide([]), do: (raise StackUnderflowError, "when dividing")
    def divide([_]), do: (raise StackUnderflowError, "when dividing")
    def divide([0, _arg]), do: raise DivisionByZeroError
    def divide([divisor, dividend]), do: dividend / divisor
end
