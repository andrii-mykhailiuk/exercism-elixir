defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    config = config_flags(flags, files)

    # Весь конвеєр тепер працює з потоком однакових списків: [filename, line_num, original_str]
    filtered_stream =
      files
      |> Stream.flat_map(fn file -> build_initial_stream(file, config) end)
      |> stream_filter(pattern, config)

    # Фінальне форматування результату
    format_output(filtered_stream, config)
  end

  # Крок 1: Будуємо початковий потік для ОДНОГО файлу
  defp build_initial_stream(file, %{with_numbers: with_numbers}) do
    filename = Path.basename(file)

    File.stream!(file)
    # Починаємо відлік рядків з 1, а не з 0
    |> Stream.with_index(1)
    |> Stream.map(fn {str, idx} ->
      line_num = if with_numbers, do: idx, else: nil
      [filename, line_num, str]
    end)
  end

  # Крок 2: Фільтрація потоку
  @spec stream_filter(Stream.t(), String.t(), map()) :: Stream.t()
  defp stream_filter(stream, pattern, config) do
    # Створюємо регулярку ОДИН раз, а не для кожного рядка
    regex = build_regex(pattern, config)

    # Визначаємо функцію перевірки залежно від прапорця інверсії (-v)
    check_fn = if config.invert, do: &(!&1), else: & &1

    Stream.filter(stream, fn [_filename, _line_num, str] ->
      # Порівнюємо за допомогою Regex, прапорець "i" всередині регулярки сам подбає про регістр!
      check_fn.(Regex.run(regex, str) != nil)
    end)
  end

  # Допоміжна функція: Створення правильної регулярки
  defp build_regex(pattern, config) do
    # Екрануємо спецсимволи в патерні, щоб grep не ламався від крапок чи знаків питання
    escaped_pattern = Regex.escape(pattern)

    # Модифікатор "i" робить регулярку регістронезалежною
    # Модифікатор "u" вмикає підтримку Unicode (для кирилиці)
    options = if config.insensitive, do: "iu", else: "u"

    if config.entire_line do
      # Рядок має точно збігатися від початку (^) до кінця ($), враховуючи можливий \n
      Regex.compile!("^#{escaped_pattern}\n?$", options)
    else
      Regex.compile!(escaped_pattern, options)
    end
  end

  # Крок 3: Фінальне форматування (Обробка -l та звичайного виводу)
  defp format_output(stream, %{only_filenames: true}) do
    # Якщо прапорець -l, нам треба повернути лише унікальні імена файлів, де є збіги
    stream
    |> Stream.map(fn [filename, _num, _str] -> "#{filename}\n" end)
    |> Stream.uniq()
    |> Enum.join()
  end

  defp format_output(stream, config) do
    stream
    |> Stream.map(fn [filename, line_num, str] ->
      trimmed_str = String.trim_trailing(str, "\n")

      prefix = ""
      prefix = if config.filename_needed, do: "#{prefix}#{filename}:", else: prefix
      prefix = if config.with_numbers, do: "#{prefix}#{line_num}:", else: prefix

      # Додаємо \n СУВОРО в кінець кожного сформованого рядка
      "#{prefix}#{trimmed_str}\n"
    end)
    # Склеюємо все в один рядок як є (без додавання зайвих символів між ними)
    |> Enum.join()
  end

  @spec config_flags([String.t()], [String.t()]) :: map()
  def config_flags(flags, files) do
    %{
      insensitive: "-i" in flags,
      invert: "-v" in flags,
      with_numbers: "-n" in flags,
      only_filenames: "-l" in flags,
      entire_line: "-x" in flags,
      filename_needed: length(files) > 1
    }
  end
end

# defmodule Grep do
#   @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
#   def grep(pattern, flags, files) do
#     config = config_flags(flags, files)

#     filtered_stream =
#     files
#     |> Stream.flat_map(&basic_stream_lines/1)
#     |> stream_with_line_numbers(config)
#     |> stream_case_insensitive(config)
#     |> stream_filter(pattern, config)

#     if length(files) > 1 do
#       filtered_stream
#       |> Stream.map(fn [filename, num_line, str] ->
#         "#{filename}:#{num_line}#{String.trim(str)}"
#       end)
#       |> Enum.join("\n")
#     else
#       filtered_stream
#       |> Stream.map(fn [filename, num_line, str] ->
#         "#{num_line}:#{String.trim(str)}"
#       end)
#       |> Stream.map(fn str ->
#         if String.starts_with?(str, ":") do
#           String.slice(str, 1..-1)
#         else
#           str
#         end
#       end)
#       |> Enum.join("\n")
#     end

#   end

#   @spec basic_stream_lines(String.t()) :: {Stream, String.t()}
#   defp basic_stream_lines(file) do

#     {File.stream!(file), Path.basename(file)}
#   end

#   @spec stream_with_line_numbers({Stream, String.t()}, map()) :: Stream
#   defp stream_with_line_numbers({stream, filename}, %{with_numbers: with_numbers}) do
#     if with_numbers do
#       stream
#       |> Stream.with_index()
#       |> Stream.map(fn {str, num} -> [filename, num, str] end)
#     else
#       stream
#       |> Stream.map(fn {str, _num} -> [filename, nil, str] end)
#     end
#   end

#   @spec stream_case_insensitive(Stream, map()) :: Stream
#   defp stream_case_insensitive(stream, %{insensitive: insensitive}) do
#     if insensitive do
#       stream
#       |> Stream.map(fn [filename, line_num, str] -> [filename, line_num, String.downcase(str)] end)
#     else
#       stream
#     end
#   end

#   @spec stream_filter(Stream, String.t(), map()) :: Stream
#   defp stream_filter(stream, patern, config) do
#     if Map.get(config, :insensitive) do
#       patern = String.downcase(patern)
#     end

#     pattern = pattern_entire_line(config, patern)

#       if Map.get(config, :invert) do
#         stream
#         |> Stream.filter(fn [filename, line_num, str] ->
#           !String.match?(str, patern)
#         end)
#       else
#         stream
#         |> Stream.filter(fn [filename, line_num, str] ->
#           String.match?(str, patern)
#         end)
#       end
#   end

#   @spec pattern_entire_line(config :: map(), pattern :: String.t()) :: String.t()
#   defp pattern_entire_line(%{entire_line: entire_line }, pattern) do
#     if entire_line do
#       ~r/^#{pattern}$/
#     else
#       ~r/\.*#{pattern}\.*/
#     end
#   end

#   @spec config_flags([String.t()], [String.t()]) :: map()
#   def config_flags(flags, files) do
#     %{
#     insensitive: "-i" in flags,
#     invert: "-v" in flags,
#     with_numbers: "-n" in flags,
#     only_filenames: "-l" in flags,
#     entire_line: "-x" in flags,
#     filename_needed: length(files) > 1
#   }
#   end
# end
