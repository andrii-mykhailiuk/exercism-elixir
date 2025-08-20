defmodule FreelancerRates do
  @working_hours_a_day 8
  @billable_days 22

  def daily_rate(hourly_rate) do
    # Please implement the daily_rate/1 function
    hourly_rate * @working_hours_a_day * 1.0
  end

  def apply_discount(before_discount, discount) do
    # Please implement the apply_discount/2 function
    before_discount * (1 - (discount / 100))
  end

  def monthly_rate(hourly_rate, discount) do
    # Please implement the monthly_rate/2 function
    ceil(apply_discount(daily_rate(hourly_rate) * @billable_days, discount))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    # Please implement the days_in_budget/3 function
    budget / daily_rate(apply_discount(hourly_rate, discount))
    |> Float.floor(1)
  end
end
