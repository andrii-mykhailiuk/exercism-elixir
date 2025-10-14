defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.reduce_while(MapSet.new(), fn char, acc ->
      cond do
        MapSet.size(acc) == 26 ->
          {:halt, acc}

        char in ?a..?z ->
          {:cont, MapSet.put(acc, char)}

        true ->
          {:cont, acc}
      end
    end)
    |> then(&(MapSet.size(&1) == 26))
  end
end
