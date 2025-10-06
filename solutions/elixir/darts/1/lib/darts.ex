defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    hpt = hypot(x, y)

    cond do
      hpt <= 1 -> 10
      hpt <= 5 -> 5
      hpt <= 10 -> 1
      true -> 0
    end
  end

  @spec hypot(number(), number()) :: float()
  def hypot(x, y), do: :math.sqrt(x * x + y * y)
end
