defmodule ResistorColorDuo do
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
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([first_color, second_color]) do
    String.to_integer(
      "#{Map.get(@resistor_colors, first_color)}#{Map.get(@resistor_colors, second_color)}"
    )
  end

  def value([first_color, second_color, _rest]) do
    value([first_color, second_color])
  end
end
