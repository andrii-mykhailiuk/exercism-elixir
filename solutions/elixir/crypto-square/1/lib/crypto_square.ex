defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do
    normalized = normalize(str)

    if normalized == "" do
      ""
    else
      square_it(normalized)
      |> transform()
    end
  end

  @spec normalize(String.t()) :: String.t()
  def normalize(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")
  end

  @spec square_it(String.t()) :: [String.t()]
  def square_it(str) do
    str_len = String.length(str)
    cols = ceil(:math.sqrt(str_len))

    str
    |> to_charlist()
    |> Enum.chunk_every(cols, cols, List.duplicate(?\s, cols))
  end

  @spec transform([String.t()]) :: String.t()
  def transform(list) do
    list
    |> Enum.zip()
    |> Enum.map(fn tuple ->
      tuple
      |> Tuple.to_list()
      |> List.to_string()
    end)
    |> Enum.join(" ")
  end
end
