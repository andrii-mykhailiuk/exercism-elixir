defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.replace(~r/(.)\1*/, string, fn group, char ->
      len = String.length(group)
      if len > 1, do: "#{len}#{char}", else: char
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.replace(~r/(\d*)(.)/, string, fn _, count, char ->
      repeat = if count == "", do: 1, else: String.to_integer(count)
      String.duplicate(char, repeat)
    end)
  end
end
