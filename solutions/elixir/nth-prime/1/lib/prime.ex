defmodule Prime do
  @doc """
  Generates the nth prime.
  """

  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2
  def nth(count) when count > 1 do
    Stream.iterate(3, &(&1 + 2))
    |> Stream.filter(&prime?/1)
    |> Enum.at(count-2)
  end

  @spec prime?(non_neg_integer()) :: boolean()
  defp prime?(n) do
    limit = :math.sqrt(n) |> trunc
    Enum.all?(3..limit//2, fn i -> rem(n, i) != 0 end)
  end
end
