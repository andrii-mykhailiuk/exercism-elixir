defmodule GuessingGame do
  def compare(_secret_number), do: "Make a guess"
  def compare(_secret_number, :no_guess), do: "Make a guess"
  def compare(secret_number, guess) do
    # Please implement the compare/2 function
    cond do
      secret_number == guess -> "Correct"
      secret_number - guess in [-1, 1] -> "So close"
      guess > secret_number -> "Too high"
      guess < secret_number -> "Too low"
    end
  end
end
