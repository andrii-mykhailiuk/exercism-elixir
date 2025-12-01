defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    []
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    if Enum.any?(school, fn {_, names} -> MapSet.member?(names, name) end) do
      {:error, school}
    else
      updated_school =
        case List.keyfind(school, grade, 0) do
          {grade, names} ->
            List.keyreplace(school, grade, 0, {grade, MapSet.put(names, name)})

          nil ->
            [{grade, MapSet.new([name])} | school]
        end

      {:ok, updated_school}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    school
    |> List.keyfind(grade, 0, {grade, MapSet.new()})
    |> elem(1)
    |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.sort_by(fn {grade, names} -> grade end)
    |> Enum.flat_map(fn {_, names} -> Enum.sort(names) end)
  end
end
