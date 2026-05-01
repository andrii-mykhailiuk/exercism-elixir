defmodule Allergies do
  @allergens [
    "eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats"
  ]
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    flags
    |> Integer.digits(2)
    |> Enum.reverse()
    |> Enum.zip(@allergens)
    |> Enum.filter(fn {presence, _allergen} -> presence == 1 end)
    |> Enum.map(fn {_, allergen} -> allergen end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    list(flags)
    |> Enum.member?(item)
    # |> Enum.into(MapSet.new())
    # |> MapSet.member?(item)
  end
end
