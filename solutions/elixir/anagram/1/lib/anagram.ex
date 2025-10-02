defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    sorted_base = sorted_chars(base)

    Enum.filter(candidates, fn candidate ->
      sorted_base == sorted_chars(candidate) and
        String.downcase(base) != String.downcase(candidate)
    end)
  end

  @spec sorted_chars(String.t()) :: charlist()
  defp sorted_chars(string) do
    string
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.sort()
  end
end
