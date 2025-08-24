defmodule NameBadge do
  def print(id, name, nil), do: printer({id, name, "OWNER"})
  def print(id, name, department) do
    printer({id, name, department})
  end

  defp printer({id, name, department}) do
    department = String.upcase(department)
    if is_nil(id) do
      IO.inspect("#{name} - #{department}")
    else
      IO.inspect("[#{id}] - #{name} - #{department}")
    end
  end
end
