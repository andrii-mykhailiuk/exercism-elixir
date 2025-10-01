defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_digits, input_base, _output_base) when input_base < 2 do
    {:error, "input base must be >= 2"}
  end

  def convert(_digits, _input_base, output_base) when output_base < 2 do
    {:error, "output base must be >= 2"}
  end

  def convert(digits, input_base, output_base) do
    if sanitize_input(digits, input_base) do
      convert_to_decimal(digits, input_base)
      |> convert_to_base(output_base)
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  @spec convert_to_decimal(list, integer) :: integer
  defp convert_to_decimal(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {dig, idx}, acc -> acc + Integer.pow(input_base, idx) * dig end)
  end

  @spec convert_to_base(integer, integer) :: list
  defp convert_to_base(0, _output_base), do: {:ok, [0]}

  defp convert_to_base(decimal_num, output_base) do
    converter(decimal_num, output_base, [])
  end

  @spec converter(integer, integer, list) :: {:ok, list}
  defp converter(0, _base, out_digits), do: {:ok, out_digits}

  defp converter(decimal_num, base, out_digits) do
    converter(div(decimal_num, base), base, [rem(decimal_num, base) | out_digits])
  end

  @spec sanitize_input(list, integer) :: boolean
  defp sanitize_input(digits, input_base) do
    Enum.all?(digits, fn dig -> dig >= 0 and dig < input_base end)
  end
end
