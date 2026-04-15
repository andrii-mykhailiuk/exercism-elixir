defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(1), do: [[1]]
  def rows(2), do: [[1], [1, 1]]

  def rows(num) do
    res =
      rows(num - 1)
      |> List.last()
      |> then(fn l -> [[0 | l], l ++ [0]] end)
      |> Enum.zip()
      |> Enum.map(fn {x, y} -> x + y end)

    rows(num - 1) ++ [res]
  end
end
