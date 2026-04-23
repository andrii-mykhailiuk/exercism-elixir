defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  # out of range functions
  def in_english(number) when number < 0, do: {:error, "number is out of range"}
  def in_english(number) when number >= 1_000_000_000_000, do: {:error, "number is out of range"}

  # functions for numbers and exceptions below 20
  def in_english(0), do: {:ok, "zero"}
  def in_english(1), do: {:ok, "one"}
  def in_english(2), do: {:ok, "two"}
  def in_english(3), do: {:ok, "three"}
  def in_english(4), do: {:ok, "four"}
  def in_english(5), do: {:ok, "five"}
  def in_english(6), do: {:ok, "six"}
  def in_english(7), do: {:ok, "seven"}
  def in_english(8), do: {:ok, "eight"}
  def in_english(9), do: {:ok, "nine"}
  def in_english(10), do: {:ok, "ten"}
  def in_english(11), do: {:ok, "eleven"}
  def in_english(12), do: {:ok, "twelve"}
  def in_english(13), do: {:ok, "thirteen"}
  def in_english(15), do: {:ok, "fifteen"}
  def in_english(18), do: {:ok, "eighteen"}

  # 2. Exceptions 20-90
  def in_english(20), do: {:ok, "twenty"}
  def in_english(30), do: {:ok, "thirty"}
  def in_english(40), do: {:ok, "forty"}
  def in_english(50), do: {:ok, "fifty"}
  def in_english(60), do: {:ok, "sixty"}
  def in_english(70), do: {:ok, "seventy"}
  def in_english(80), do: {:ok, "eighty"}
  def in_english(90), do: {:ok, "ninety"}

  # for the rest of number below 20
  def in_english(number) when number < 20 do
    number
    |> Integer.digits()
    |> then(fn [_, onces] -> in_english(onces) end)
    |> then(fn {:ok, repr} -> {:ok, repr <> "teen"} end)
  end

  def in_english(number) when number < 100 do
    t = div(number, 10) * 10
    o = rem(number, 10)
    {:ok, tens} = in_english(t)
    {:ok, ones} = in_english(o)
    {:ok, "#{tens}-#{ones}"}
  end

  def in_english(number) when number < 1_000, do: split(number, 100, "hundred")
  def in_english(number) when number < 1_000_000, do: split(number, 1_000, "thousand")
  def in_english(number) when number < 1_000_000_000, do: split(number, 1_000_000, "million")

  def in_english(number) when number < 1_000_000_000_000,
    do: split(number, 1_000_000_000, "billion")

  # helper function for DRY
  @spec split(pos_integer, pos_integer, String.t()) :: {:ok, String.t()}
  defp split(number, divisor, label) do
    q = div(number, divisor)
    r = rem(number, divisor)
    {:ok, name} = in_english(q)

    case in_english(r) do
      {:ok, "zero"} -> {:ok, "#{name} #{label}"}
      {:ok, rest} -> {:ok, "#{name} #{label} #{rest}"}
    end
  end
end
