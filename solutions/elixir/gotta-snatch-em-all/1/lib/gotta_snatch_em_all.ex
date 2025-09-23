defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    cond do
      MapSet.member?(collection, your_card) and not MapSet.member?(collection, their_card) ->
        {true, MapSet.symmetric_difference(collection, MapSet.new([your_card, their_card]))}

      not MapSet.member?(collection, your_card) and not MapSet.member?(collection, their_card) ->
        {false, MapSet.put(collection, their_card)}

      MapSet.member?(collection, your_card) and MapSet.member?(collection, their_card) ->
        {false, MapSet.new([their_card])}

      true ->
        {false, collection}
    end
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards
    |> MapSet.new()
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection)
    |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []

  def boring_cards([h | t]) do
    Enum.reduce(t, h, fn col, acc ->
      MapSet.intersection(acc, col)
    end)
    |> MapSet.to_list
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0
  def total_cards([h | t]) do
    Enum.reduce(t, h, fn col, acc ->
      MapSet.union(acc, col)
    end)
    |> MapSet.size
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    {shinies, others} = MapSet.split_with(collection, &String.starts_with?(&1, "Shiny"))
    {MapSet.to_list(shinies), MapSet.to_list(others)}
  end
end
