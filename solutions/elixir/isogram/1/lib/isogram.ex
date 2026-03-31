defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.filter(fn chr -> chr not in [?\s, ?-] end)
    |>then(&length(&1) == MapSet.size(MapSet.new(&1)))
  end
end
