defmodule Username do

  def sanitize([]), do: []
  def sanitize([h | t]) do
    replacement =
      case h do
        _ when h in ?a..?z -> [h]
        ?_ -> [?_]
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        _ -> []
      end

    replacement ++ sanitize(t)
  end
end
