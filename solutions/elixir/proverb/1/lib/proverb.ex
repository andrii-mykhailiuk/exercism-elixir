defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""

  def recite(strings) do
    strings
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce("", fn [first, second], acc ->
      acc <> "For want of a #{first} the #{second} was lost.\n"
    end)
    |> then(fn verse ->
      verse <> "And all for the want of a #{List.first(strings)}.\n"
    end)
  end
end
