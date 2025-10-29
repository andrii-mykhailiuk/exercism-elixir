defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @alphabet_len 26
  @upper_base ?A
  @small_base ?a

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> Enum.map(fn char ->
      cond do
        char in ?A..?Z ->
          rem(char - @upper_base + shift, @alphabet_len) + @upper_base

        char in ?a..?z ->
          rem(char - @small_base + shift, @alphabet_len) + @small_base

        true ->
          char
      end
    end)
    |> List.to_string()
  end
end
