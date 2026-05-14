defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true

  def chain?([{left, right} | rest]) do
    solve(rest, left, right)
  end

  @spec solve(rest :: [domino], target :: integer, current :: integer) :: list() | boolean()
  defp solve([], target, current), do: target == current

  defp solve(rest, target, current) do
    IO.inspect(rest, label: "Поточні доміно")
    indices = find_dominoes_indices(current, rest)

    # Якщо хоча б один варіант веде до успіху — повертаємо true
    Enum.any?(indices, fn index ->
      {left, right} = Enum.at(rest, index)
      new_rest = List.delete_at(rest, index)

      # Якщо підійшов left, наступний current буде right, і навпаки
      next_current = if(left == current, do: right, else: left)

      solve(new_rest, target, next_current)
    end)
  end

  defp find_dominoes_indices(current, rest) do
    rest
    |> Enum.with_index()
    |> Enum.filter(fn {{l, r}, _i} -> l == current or r == current end)
    |> Enum.map(fn {_, i} -> i end)
  end
end
