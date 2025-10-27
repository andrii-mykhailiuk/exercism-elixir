defmodule RomanNumerals do
  @roman_nums %{
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    do_numeral(number, Enum.sort(Map.keys(@roman_nums), :desc))
  end

  defp do_numeral(0, _), do: ""

  defp do_numeral(number, [value | rest]) when number >= value do
    @roman_nums[value] <> do_numeral(number - value, [value | rest])
  end

  defp do_numeral(number, [_ | rest]) do
    do_numeral(number, rest)
  end
end
