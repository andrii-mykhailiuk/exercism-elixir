defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  @spec compare(list(), list()) :: :equal | :sublist | :superlist | :unequal
  def compare(a, b) do
    cond do
      a == b -> :equal
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  @spec sublist?(list(), list()) :: boolean()
  defp sublist?([], _), do: true
  defp sublist?(_, []), do: false
  defp sublist?(a, b) when length(a) > length(b), do: false

  defp sublist?(a, b) do
    Enum.chunk_every(b, length(a), 1, :discard)
    |> Enum.any?(&(&1 === a))
  end
end
