defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    digits =
      isbn
      |> String.replace("-", "")
      |> String.codepoints()

    if length(digits) == 10 do
      digits
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> Enum.map(&convert_char/1)
      |> Enum.reduce_while(0, fn
        {:ok, num}, acc -> {:cont, acc + num}
        {:error, _}, _acc -> {:halt, :error}
      end)
      |> case do
        :error -> false
        sum -> rem(sum, 11) == 0
      end
    else
      false
    end
  end

  @spec convert_char({String.t(), integer}) :: {:ok, integer()} | {:error, :invalid_digit}
  defp convert_char({"X", 1}), do: {:ok, 10}

  defp convert_char({char, idx}) do
    case Integer.parse(char) do
      {num, ""} -> {:ok, num * idx}
      :error -> {:error, :invalid_digit}
    end
  end
end
