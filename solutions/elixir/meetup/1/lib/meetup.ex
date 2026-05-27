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

  @day_of_week %{
    1 => :monday,
    2 => :tuesday,
    3 => :wednesday,
    4 => :thursday,
    5 => :friday,
    6 => :saturday,
    7 => :sunday
  }
  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  # def meetup(year, month, weekday, :last) do
  #   temp_date = Date.new(year, month, 1)
  #   last_day = Date.end_of_month(temp_date)
  #   Date.day_of_week(last_day)
  # end

  def meetup(year, month, weekday, schedule) do
    {:ok, start} = Date.new(year, month, 1)

    weekdays_list =
      Date.range(start, Date.end_of_month(start))
      |> Enum.group_by(fn date ->
        Map.get(@day_of_week, Date.day_of_week(date))
      end)
      |> Map.get(weekday)

    case schedule do
      :first -> hd(weekdays_list)
      :second -> Enum.at(weekdays_list, 1)
      :third -> Enum.at(weekdays_list, 2)
      :fourth -> Enum.at(weekdays_list, 3)
      :last -> List.last(weekdays_list)
      :teenth -> hd(Enum.filter(weekdays_list, fn date -> date.day in 13..19 end))
    end
  end
end
