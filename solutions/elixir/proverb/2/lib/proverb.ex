defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""

  def recite(strings) do
    verces =
      strings
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [first, second] ->
        "For want of a #{first} the #{second} was lost.\n"
      end)

    final_line = "And all for the want of a #{hd(strings)}.\n"

    Enum.join(verces ++ [final_line])
  end
end
