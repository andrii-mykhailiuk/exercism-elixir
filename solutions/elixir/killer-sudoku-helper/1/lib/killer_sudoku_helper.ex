defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{exclude: exclude, size: size, sum: sum}) do
    digits = Enum.to_list(1..9) -- exclude

    make_combinations(digits, size, sum)
  end

  @spec make_combinations(digits :: [integer], size :: integer, sum :: integer) :: [integer]
  defp make_combinations(_digits, 0, 0), do: [[]]

  defp make_combinations(_digits, size, sum) when size < 0 or sum < 0, do: []
  defp make_combinations([], _size, _sum), do: []

  defp make_combinations([h | tail], size, sum) do
    with_x =
      tail
      |> make_combinations(size - 1, sum - h)
      |> Enum.map(fn combo -> [h | combo] end)

    without_x = make_combinations(tail, size, sum)

    with_x ++ without_x
  end
end
