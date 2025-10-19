defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    String.graphemes(rna)
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join/1)
    |> Enum.reduce_while([], fn codon, acc ->
      case of_codon(codon) do
        {:ok, "STOP"} ->
          {:halt, acc}

        {:ok, protein} ->
          {:cont, [protein | acc]}

        {:error, _} ->
          {:halt, {:error, "invalid RNA"}}
      end
    end)
    |> case do
      {:error, _} = error -> error
      proteins -> {:ok, Enum.reverse(proteins)}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(list(String.t())) :: {:ok, String.t()} | {:error, String.t()}
  @codon_map %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }
  def of_codon(codon) do
    case @codon_map[codon] do
      nil -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end
end
