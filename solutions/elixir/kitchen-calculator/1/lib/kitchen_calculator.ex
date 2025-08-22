defmodule KitchenCalculator do
  def get_volume({_volume, amount}) do
    # Please implement the get_volume/1 function
    amount
  end

  def to_milliliter({:cup, amount}), do: {:milliliter, amount * 240}
  def to_milliliter({:fluid_ounce, amount}), do: {:milliliter, amount * 30}
  def to_milliliter({:teaspoon, amount}), do: {:milliliter, amount * 5}
  def to_milliliter({:tablespoon, amount}), do: {:milliliter, amount * 15}
  def to_milliliter(volume_pair = {:milliliter, _}), do: volume_pair

  def from_milliliter(volume_pair, :cup), do: {:cup, elem(volume_pair, 1) / 240}
  def from_milliliter(volume_pair, :fluid_ounce), do: {:fluid_ounce, elem(volume_pair, 1) / 30}
  def from_milliliter(volume_pair, :teaspoon), do: {:teaspoon, elem(volume_pair, 1) / 5}
  def from_milliliter(volume_pair, :tablespoon), do: {:tablespoon, elem(volume_pair, 1) / 15}
  def from_milliliter(volume_pair, :milliliter), do: volume_pair

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
