defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @day_of_week [
    :monday,
    :tuesday,
    :wednesday,
    :thursday,
    :friday,
    :saturday,
    :sunday
  ]
  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    start_date = first_day(year, month, schedule)
    first_week_day = find_first_weekday(start_date, weekday)
    find_target_date(first_week_day, schedule)
  end

  @spec first_day(pos_integer, pos_integer, schedule) :: Date.t()
  defp first_day(year, month, :teenth), do: Date.new!(year, month, 13)

  defp first_day(year, month, :last) do
    Date.new!(year, month, 1)
    |> Date.end_of_month()
    |> Date.shift(day: -6)
  end

  defp first_day(year, month, schedule), do: Date.new!(year, month, 1)

  @spec find_first_weekday(Date.t(), weekday) :: Date.t()
  def find_first_weekday(date, weekday) do
    target_day = Enum.find_index(@day_of_week, fn item -> item == weekday end) + 1
    first = Integer.mod(target_day - Date.day_of_week(date), 7)
    Date.shift(date, day: first)
  end

  @spec find_target_date(Date.t(), schedule) :: Date.t()
  def find_target_date(date, :first), do: date
  def find_target_date(date, :second), do: Date.shift(date, day: 7)
  def find_target_date(date, :third), do: Date.shift(date, day: 14)
  def find_target_date(date, :fourth), do: Date.shift(date, day: 21)
  def find_target_date(date, :last), do: date
  def find_target_date(date, :teenth), do: date
end
