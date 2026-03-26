defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    do_verse()
    |> String.split(~r/\n\s*\n/)
    |> Enum.map(fn verse ->
       verse
       |> String.replace("\n", " ")
       |> String.replace(~r/\s+/, " ")
       |> String.trim()
       |> Kernel.<>("\n")
     end)
    |> Enum.slice((start - 1)..(stop - 1))
    |> Enum.join("")
  end

  @spec  do_verse() :: String.t()
  defp do_verse() do
    """
    This is the house that Jack built.

    This is the malt
    that lay in the house that Jack built.

    This is the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the dog
    that worried the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the cow with the crumpled horn
    that tossed the dog
    that worried the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the maiden all forlorn
    that milked the cow with the crumpled horn
    that tossed the dog
    that worried the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the man all tattered and torn
    that kissed the maiden all forlorn
    that milked the cow with the crumpled horn
    that tossed the dog
    that worried the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the priest all shaven and shorn
    that married the man all tattered and torn
    that kissed the maiden all forlorn
    that milked the cow with the crumpled horn
    that tossed the dog
    that worried the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the rooster that crowed in the morn
    that woke the priest all shaven and shorn
    that married the man all tattered and torn
    that kissed the maiden all forlorn
    that milked the cow with the crumpled horn
    that tossed the dog
    that worried the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the farmer sowing his corn
    that kept the rooster that crowed in the morn
    that woke the priest all shaven and shorn
    that married the man all tattered and torn
    that kissed the maiden all forlorn
    that milked the cow with the crumpled horn
    that tossed the dog
    that worried the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.

    This is the horse and the hound and the horn
    that belonged to the farmer sowing his corn
    that kept the rooster that crowed in the morn
    that woke the priest all shaven and shorn
    that married the man all tattered and torn
    that kissed the maiden all forlorn
    that milked the cow with the crumpled horn
    that tossed the dog
    that worried the cat
    that killed the rat
    that ate the malt
    that lay in the house that Jack built.
  """
  end
end
