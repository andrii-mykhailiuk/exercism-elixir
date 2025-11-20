defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)

    cond do
      all_uppers(input) and asking(input) -> "Calm down, I know what I'm doing!"
      all_uppers(input) and shouting(input) -> "Whoa, chill out!"
      all_uppers(input) -> "Whoa, chill out!"
      asking(input) -> "Sure."
      silence(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  @spec all_uppers(String.t()) :: boolean()
  defp all_uppers(input) do
    letters =
      input
      |> String.graphemes()
      # тільки букви
      |> Enum.filter(&String.match?(&1, ~r/\p{L}/u))

    letters != [] and Enum.all?(letters, &(&1 == String.upcase(&1)))
  end

  @spec asking(String.t()) :: boolean()
  defp asking(input) do
    Regex.match?(~r/.*\?$/, input)
  end

  @spec shouting(String.t()) :: boolean()
  defp shouting(input) do
    Regex.match?(~r/^.*!$/, input)
  end

  @spec silence(String.t()) :: boolean()
  defp silence(input), do: Regex.match?(~r/^\s*$/, input)
end
