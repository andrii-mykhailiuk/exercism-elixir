defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    Integer.floor_div(score - 10, 2)
  end

  @spec ability :: pos_integer()
  def ability do
    Enum.map(1..4, fn _ -> :rand.uniform(6) end)
    |> Enum.sort()
    |> tl()
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    base = %__MODULE__{
      strength: ability(),
      dexterity: ability(),
      constitution: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability()
    }

    %{base | hitpoints: 10 + modifier(base.constitution)}
  end
end
