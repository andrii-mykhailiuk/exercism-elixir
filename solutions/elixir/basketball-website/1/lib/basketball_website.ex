defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path_chunks = String.split(path, ".")
    do_extract_from_path(data, path_chunks)
  end

  defp do_extract_from_path(nil, _path), do: nil
  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(data, [h | t]) do
    do_extract_from_path(data["#{h}"], t)
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
