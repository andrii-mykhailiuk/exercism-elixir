defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @brackets %{
    "}" => "{",
    ")" => "(",
    "]" => "["
  }

  @opening_brackets Map.values(@brackets)

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes()
    |> Enum.filter(&Regex.match?(~r/[\(\)\{\}\[\]]/, &1))
    |> Enum.reduce_while([], &reducer/2)
    |> Kernel.==([])
  end

  defp reducer(char, stack) when char in @opening_brackets do
    {:cont, [char | stack]}
  end

  defp reducer(char, [head | tail]) when is_map_key(@brackets, char) do
    if Map.get(@brackets, char) == head do
      {:cont, tail}
    else
      {:halt, [:error]}
    end
  end

  defp reducer(_char, []) do
    {:halt, [:error]}
  end
end
