defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  # def abbreviate(string) do
  #   String.split(string, ~r/[\s-]+/, trim: true)
  #   |> Enum.reduce("", fn str, acc -> acc <> String.first(String.capitalize(str)) end)
  # end
  # def abbreviate(string) do
  #   Regex.scan(~r/\b\p{L}\p{M}*/, string)
  #   |> Enum.join()
  #   |> String.upcase()
  # end
  def abbreviate(string) do
    Regex.replace(~r/(?<!_)\B[a-zA-Z']+|[-\s,_]/, string, "")
    # |> Enum.join()
    |> String.trim()
    |> String.upcase()
  end
end
