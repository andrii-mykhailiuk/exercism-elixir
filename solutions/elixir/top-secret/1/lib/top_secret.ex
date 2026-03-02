defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)
    ast
  end

  def decode_secret_message_part({kind, _, [{:when, _, [{name, _, args}, _guard]}, _body]} = ast, acc)
      when kind in [:def, :defp] do
    arity = length(args || [])

    case arity do
      0 ->
        {ast, ["" | acc]}

      _ ->
        {left, _} = String.split_at(Atom.to_string(name), arity)
        {ast, [left | acc]}
    end
  end

  def decode_secret_message_part({:def, _, [{name, _, args}, _body]} = ast, acc) do
    arity = length(args || [])

    case arity do
      0 ->
        {ast, ["" | acc]}

      _ ->
        {left, _} = String.split_at(Atom.to_string(name), arity)
        {ast, [left | acc]}
    end
  end

  def decode_secret_message_part({:defp, _, [{name, _, args}, _body]} = ast, acc) do
    arity = length(args || [])

    case arity do
      0 ->
        {ast, ["" | acc]}

      _ ->
        {left, _} = String.split_at(Atom.to_string(name), arity)
        {ast, [left | acc]}
    end
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    funcs =
      case ast do
        {:defmodule, _, [_mod_name, [do: {:__block__, _, list}]]} -> list
        {:defmodule, _, [_mod_name, [do: single]]} -> [single]
        {:__block__, _, list} -> Enum.flat_map(list, &extract_module_body/1)
        _ -> []
      end
    funcs
    |> Enum.reduce([], fn ast, acc ->
      {_ast, new_acc} = decode_secret_message_part(ast, acc)
      new_acc
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

defp extract_module_body({:defmodule, _, [_mod, [do: {:__block__, _, body}]]}), do: body
defp extract_module_body({:defmodule, _, [_mod, [do: single]]}), do: [single]
defp extract_module_body(node), do: [node]

end
# "defp cat(x) when x > 0, do: nil"
