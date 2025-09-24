defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, ~r/[\s-]+/, trim: true)
    |> Enum.reduce("", fn str, acc -> acc <> String.first(String.capitalize(str)) end)
  end
end
