defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    cipher_map = cipher(:encode)

    String.downcase(plaintext)
    |> String.to_charlist()
    |> Enum.filter(&char_allowed?/1)
    |> Enum.map(fn chr -> Map.get(cipher_map, chr, chr) end)
    |> to_string()
    |> String.graphemes()
    |> Enum.chunk_every(5)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher_map = cipher(:decode)

    String.downcase(cipher)
    |> String.to_charlist()
    |> Enum.filter(&char_allowed?/1)
    |> Enum.map(fn chr -> Map.get(cipher_map, chr, chr) end)
    |> to_string()
  end

  @spec cipher(:encode | :decode) :: Map
  defp cipher(:encode) do
    Enum.zip(?a..?z, ?z..?a//-1)
    |> Map.new()
  end

  defp cipher(:decode) do
    Enum.zip(?z..?a//-1, ?a..?z)
    |> Map.new()
  end

  @spec char_allowed?(char()) :: boolean()
  defp char_allowed?(chr) do
    (chr >= ?a and chr <= ?z) or (chr >= ?0 and chr <= ?9)
  end
end
