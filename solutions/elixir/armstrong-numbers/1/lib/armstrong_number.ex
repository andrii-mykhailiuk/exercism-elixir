defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    power = length(digits)
    Enum.reduce(digits, 0, fn dig, acc -> Integer.pow(dig, power) + acc end) == number
  end
end
