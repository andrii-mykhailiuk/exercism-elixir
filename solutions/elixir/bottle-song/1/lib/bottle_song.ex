defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """
  @verse_start_map %{
    0 => "No",
    1 => "One",
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine",
    10 => "Ten"
  }

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    start_bottle
    |> Stream.iterate(&(&1 - 1))
    |> Stream.take(take_down)
    |> Enum.map(&generate_verse/1)
    |> Enum.join("\n\n")
  end

  defp generate_verse(bottle_num) do
    """
    #{String.capitalize(bottles(bottle_num))} hanging on the wall,
    #{String.capitalize(bottles(bottle_num))} hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be #{bottles(bottle_num - 1)} hanging on the wall.
    """
    |> String.trim_trailing()
  end

  defp bottles(0), do: "no green bottles"
  defp bottles(1), do: "one green bottle"
  defp bottles(n), do: "#{String.downcase(@verse_start_map[n])} green bottles"
end
