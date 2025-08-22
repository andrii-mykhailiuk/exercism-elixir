defmodule BirdCount do
  def today([]), do: nil
  def today(list) do
    List.first(list)
  end

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]) do
    # Please implement the increment_day_count/1 function
    [head + 1 | tail]
  end

  def has_day_without_birds?(list) do
    # Please implement the has_day_without_birds?/1 function
    0 in list
  end

  def total(list) do
    # Please implement the total/1 function
    Enum.sum(list)
  end

  def busy_days(list) do
    # Please implement the busy_days/1 function
    list
    |> Enum.count(fn x -> x >= 5 end)
  end
end
