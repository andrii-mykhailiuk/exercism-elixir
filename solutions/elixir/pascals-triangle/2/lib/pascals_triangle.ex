defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(1), do: [[1]]
  def rows(2), do: [[1], [1, 1]]

  def rows(num) do
    all_prev_rows = rows(num - 1)

    last_row = List.last(all_prev_rows)

    new_row =
      Enum.zip([0 | last_row], last_row ++ [0])
      |> Enum.map(fn {x, y} -> x + y end)

    all_prev_rows ++ [new_row]
  end
end
