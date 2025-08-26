defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end
  def filter([], _color), do: []
  def filter(cellar, color) do
    filter_by_color(cellar, color)
  end
  def filter(cellar, color, [year: year]) do
    cellar
    |> filter_by_color(color)
    |> filter_by_year(year)
  end
  def filter(cellar, color, [country: country]) do
    cellar
    |> filter_by_color(color)
    |> filter_by_country(country)
  end
  def filter(cellar, color, opts) when is_list(opts) do
    year = Keyword.get(opts, :year)
    country = Keyword.get(opts, :country)

    cellar
    |> filter_by_color(color)
    |> filter_by_year(year)
    |> filter_by_country(country)
  end

  defp filter_by_color(cellar, color),
    do: (for {^color, wine} <- cellar, do: wine)
  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
