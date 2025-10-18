defmodule PigLatin do
  @vowels ~w(a e i o u)
  @pig_end "ay"
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  @spec translate_word(word :: String.t()) :: String.t()
  defp translate_word(word) do
    cond do
      starts_with_vowel_or_special?(word) ->
        word <> @pig_end

      starts_with_consonant_and_qu?(word) ->
        {prefix, rest} = split_before_qu(word)
        rest <> prefix <> @pig_end

      starts_with_consonant_and_y?(word) ->
        {prefix, rest} = split_before_y(word)
        rest <> prefix <> @pig_end

      true ->
        {prefix, rest} = split_leading_consonants(word)
        rest <> prefix <> @pig_end
    end
  end

  @spec starts_with_vowel_or_special?(word :: String.t()) :: boolean()
  defp starts_with_vowel_or_special?(<<first::utf8, second::utf8, _rest::binary>>)do
    pair = <<first::utf8, second::utf8>>
    single = <<first::utf8>>
    single in @vowels or pair in ["xr", "yt"]
  end
  defp starts_with_vowel_or_special?(_), do: false

  @spec starts_with_consonant_and_qu?(word :: String.t()) :: boolean()
  defp starts_with_consonant_and_qu?(word), do: String.contains?(String.downcase(word), "qu")

  @spec starts_with_consonant_and_y?(word :: String.t()) :: boolean()
  defp starts_with_consonant_and_y?(word), do: Regex.match?(~r/^[^aeiou]+y/, String.downcase(word))

  defp split_leading_consonants(word) do
    {consonants, rest} =
      word
      |> String.graphemes()
      |> Enum.split_while(&(&1 not in @vowels))

      {Enum.join(consonants), Enum.join(rest)}
  end

  @spec split_before_qu(word :: String.t()) :: tuple()
  defp split_before_qu(word) do
    case Regex.run(~r/^([^aeiou]*qu)(.*)$/i, word) do
      [_, prefix, rest] -> {prefix, rest}
      nil -> split_leading_consonants(word)
    end
  end

  @spec split_before_y(word :: String.t()) :: tuple()
  defp split_before_y(word) do
    [_, prefix, rest] = Regex.run(~r/^([^aeiou]+)(y.*$)/i, word)
    {prefix, rest}
  end
end
