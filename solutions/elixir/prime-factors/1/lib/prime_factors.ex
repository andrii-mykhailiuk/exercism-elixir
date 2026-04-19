defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """

  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors(number, 2, [])
  end

  @spec do_factors(pos_integer, pos_integer, [pos_integer]) :: [pos_integer]
  defp do_factors(1, _divisor, acc), do: Enum.reverse(acc)

  defp do_factors(number, divisor, acc) when rem(number, divisor) == 0 do
    do_factors(div(number, divisor), divisor, [divisor | acc])
  end

  defp do_factors(number, divisor, acc) when divisor * divisor > number do
    do_factors(1, divisor, [number | acc])
  end

  defp do_factors(number, divisor, acc) do
    do_factors(number, next_divisor(divisor), acc)
  end

  @spec next_divisor(pos_integer) :: pos_integer
  defp next_divisor(2), do: 3
  defp next_divisor(d), do: d + 2
end
