defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    date = NaiveDateTime.to_date(checkout_datetime)
    if before_noon?(checkout_datetime) do
      Date.add(date, 28)
    else
      Date.add(date, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    difference = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    if difference <= 0 do
      0
    else
      difference
    end
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_dt = datetime_from_string(checkout)
    return_dt   = datetime_from_string(return)

    planned_return_date = return_date(checkout_dt)
    late_days = days_late(planned_return_date, return_dt)

    if monday?(return_dt) do
      floor(late_days * rate * 0.5)
    else
      late_days * rate
    end
  end
end
