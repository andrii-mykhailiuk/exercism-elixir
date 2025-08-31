defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    # Enum.sort(inventory, &(&1[:price] <= &2[:price]))
    Enum.sort_by(inventory, & &1[:price])
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &is_nil(&1[:price]))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      do_update_names(item, old_word, new_word)
    end)
  end

  defp do_update_names(item, old_word, new_word) do
    if String.contains?(item[:name], old_word) do
      %{item | name: String.replace(item[:name], old_word, new_word)}
    else
      item
    end
  end

  def increase_quantity(item, count) do
    updated =
      Enum.into(item[:quantity_by_size], %{}, fn {size, qty} ->
        {size, qty + count}
      end)
    %{item | quantity_by_size: updated}
  end

  def total_quantity(item) do
    Enum.sum(Map.values(item[:quantity_by_size]))
  end
end
