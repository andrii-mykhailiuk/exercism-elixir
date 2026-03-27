defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    "#{name}, you are the #{number}#{format_num(number)} customer we serve today. Thank you!"
  end

  @spec format_num(number :: pos_integer()) :: String.t()
  defp format_num(number) do
    cond do
      rem(number, 10) == 1 and not (rem(number, 100) == 11) -> "st"
      rem(number, 10) == 2 and not (rem(number, 100) == 12) -> "nd"
      rem(number, 10) == 3 and not (rem(number, 100) == 13) -> "rd"
      true -> "th"
    end
  end
end
