defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size < 1, do: []

  def slices(s, size) do
    chars = String.codepoints(s)
    len = length(chars)

    for i <- 0..(len - size),
        size <= len,
        do: Enum.slice(chars, i, size) |> Enum.join()
  end
end
