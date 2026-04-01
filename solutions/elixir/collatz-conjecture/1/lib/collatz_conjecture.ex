defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(0), do: raise FunctionClauseError
  def calc(input), do: do_calc(input, 0)

  @spec do_calc(input :: pos_integer(), steps :: pos_integer()) :: non_neg_integer()
  defp do_calc(1, steps), do: steps
  defp do_calc(input, steps) when rem(input, 2) == 0 do
    do_calc(div(input, 2), steps + 1)
  end
  defp do_calc(input, steps) when rem(input, 2) == 1 do
    do_calc((input * 3 + 1), steps + 1)
  end
end
