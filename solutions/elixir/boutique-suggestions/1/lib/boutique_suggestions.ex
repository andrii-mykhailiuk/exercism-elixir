defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, opts \\ []) do
    max_price = Keyword.get(opts, :maximum_price, 100)

    for %{item_name: _} = t <- tops,
        %{item_name: _} = b <- bottoms,
        Map.get(t, :base_color) != Map.get(b, :base_color),
        (Map.get(t, :price, 0) + Map.get(b, :price, 0)) <= max_price do
      {t, b}
    end
  end
end
