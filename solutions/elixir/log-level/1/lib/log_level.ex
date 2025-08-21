defmodule LogLevel do
  def to_label(level, legacy?) do
    # Please implement the to_label/2 function
    cond do
      level == 0 and legacy? == true -> :unknown
      level == 0 and legacy? == false -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 and legacy? == true -> :unknown
      level == 5 and legacy? == false -> :fatal
      level > 5 or level < 0 -> :unknown
      true -> false
    end
  end

  def alert_recipient(level, legacy?) do
    # Please implement the alert_recipient/2 function
    err_code = to_label(level, legacy?)

    cond do
      err_code in [:error, :fatal] -> :ops
      err_code == :unknown and legacy? == true -> :dev1
      err_code == :unknown -> :dev2
      true -> false
    end
  end
end
