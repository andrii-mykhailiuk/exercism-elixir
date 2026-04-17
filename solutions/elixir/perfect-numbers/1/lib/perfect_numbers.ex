defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1 do
    {:error, "Classification is only possible for natural numbers."}
  end

  def classify(number) do
    sum = calculate_divisors_sum(number)

    cond do
      sum == number -> {:ok, :perfect}
      sum > number -> {:ok, :abundant}
      true -> {:ok, :deficient}
    end
  end

  @spec calculate_divisors_sum(number :: integer) :: integer()
  def calculate_divisors_sum(1), do: 0

  def calculate_divisors_sum(number) do
    limit = floor(:math.sqrt(number))

    if limit < 2 do
      1
    else
      2..limit
      |> Stream.flat_map(fn num ->
        if rem(number, num) == 0 do
          Enum.uniq([num, div(number, num)])
        else
          []
        end
      end)
      |> Enum.sum()
      |> Kernel.+(1)
    end
  end
end
