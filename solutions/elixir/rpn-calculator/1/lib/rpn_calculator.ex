defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      res = operation.(stack)
      {:ok, res}
    rescue
      _e -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      res = operation.(stack)
      {:ok, res}
    rescue
      e ->{:error, Exception.message(e)}
    end
  end
end
