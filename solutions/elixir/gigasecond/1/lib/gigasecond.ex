defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, ndt} = NaiveDateTime.new(year, month, day, hours, minutes, seconds)

    ndt
    |> NaiveDateTime.add(Integer.pow(10, 9), :second)
    |> then(&{Date.to_erl(&1), Time.to_erl(&1)})
  end
end
