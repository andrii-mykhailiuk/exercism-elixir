defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) when number > 64 or number < 1,
    do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  def square(number) do
    {:ok, Integer.pow(2, number - 1)}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    square(64)
    |> then(fn {:ok, res} -> {:ok, res * 2 - 1} end)
  end
end
