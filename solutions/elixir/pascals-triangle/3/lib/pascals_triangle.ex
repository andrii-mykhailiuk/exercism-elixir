defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    do_rows(num, [[1]])
  end

  @spec do_rows(integer(), list()) :: [[integer]]
  defp do_rows(1, acc), do: Enum.reverse(acc)

  defp do_rows(num, [last_row | _] = acc) do
    new_row = calculate_next(last_row)

    do_rows(num - 1, [new_row | acc])
  end

  @spec calculate_next(list()) :: [integer]
  defp calculate_next(row) do
    [0 | row]
    |> Enum.chunk_every(2, 1, [0])
    |> Enum.map(&Enum.sum/1)
  end
end
