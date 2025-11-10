defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @actions ["wink", "double blink", "close your eyes", "jump"]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    result =
      Integer.digits(code, 2)
      |> Enum.reverse()
      |> Enum.zip(@actions)
      |> Enum.flat_map(fn {bit, action} ->
        if bit == 1, do: [action], else: []
      end)

    if code >= 16, do: Enum.reverse(result), else: result
  end
end
