defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    ""
    |> add_sound(number, 3, "Pling")
    |> add_sound(number, 5, "Plang")
    |> add_sound(number, 7, "Plong")
    |> then(fn res -> if res == "", do: Integer.to_string(number), else: res end)
  end

  @spec add_sound(String.t(), pos_integer(), pos_integer(), String.t()) :: String.t()
  defp add_sound(result, number, factor, sound) when rem(number, factor) == 0 do
    result <> sound
  end

  defp add_sound(result, _number, _factor, _sound),
    do: result
end
