defmodule PigLatin do
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  def translate_word(word) do
    vowel_pattern = ~r/^(?<vowel>[aeiou]|xr|yt)(?<rest>\w+)/
    consonant_pattern = ~r/^(?<consonant>([^aeiou]?qu|[^aeiou]+))(?<rest>[aeiouy]\w*)/

    cond do
      Regex.match?(vowel_pattern, word) ->
        %{"vowel" => v, "rest" => r} = Regex.named_captures(vowel_pattern, word)
        v <> r <> "ay"

      Regex.match?(consonant_pattern, word) ->
        %{"consonant" => c, "rest" => r} = Regex.named_captures(consonant_pattern, word)
        r <> c <> "ay"

      true ->
        word
    end
  end
end
