defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @plants %{
    ?G => :grass,
    ?C => :clover,
    ?R => :radishes,
    ?V => :violets
  }

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ nil) do
    names = (student_names || default_names()) |> Enum.sort()
    IO.inspect(names)

    plants =
      info_string
      |> String.split("\n")
      |> Enum.map(&String.to_charlist/1)
      |> Enum.map(&Enum.chunk_every(&1, 2))
      |> Enum.zip()
      |> Enum.map(fn {row1, row2} ->
        (row1 ++ row2) |> Enum.map(&@plants[&1]) |> List.to_tuple()
      end)

    plants =
      plants ++ List.duplicate({}, max(0, length(names) - length(plants)))

    names
    |> Enum.zip(plants)
    |> Enum.into(%{})
  end

  @spec default_names() :: list()
  defp default_names() do
    [
      :alice,
      :bob,
      :charlie,
      :david,
      :eve,
      :fred,
      :ginny,
      :harriet,
      :ileana,
      :joseph,
      :kincaid,
      :larry
    ]
  end
end
