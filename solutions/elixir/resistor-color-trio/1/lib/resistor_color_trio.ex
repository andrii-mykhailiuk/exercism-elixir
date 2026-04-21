defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @resistor_colors %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([first, second, third | _]) do
    tens = @resistor_colors[first]
    ones = @resistor_colors[second]
    exponent = @resistor_colors[third]

    # Count total amount of Ohms
    total_ohms = (tens * 10 + ones) * Integer.pow(10, exponent)

    # Find out metric prefix
    cond do
      total_ohms >= 1_000_000_000 -> {div(total_ohms, 1_000_000_000), :gigaohms}
      total_ohms >= 1_000_000 -> {div(total_ohms, 1_000_000), :megaohms}
      total_ohms >= 1_000 -> {div(total_ohms, 1_000), :kiloohms}
      true -> {total_ohms, :ohms}
    end
  end
end
