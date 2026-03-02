defmodule LogParser do
  @regex ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  @separator ~r/<[~=\*\-]*>/
  @end_of_line ~r/end-of-line\d+/i
  @tag_user_lines ~r/User\s+(\S+)/

  def valid_line?(line) do
    String.match?(line, @regex)
  end

  def split_line(line) do
    String.split(line, @separator)
  end

  def remove_artifacts(line) do
    String.replace(line, @end_of_line, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(@tag_user_lines, line) do
      [_, user] -> "[USER] #{user} " <> line
      _ -> line
    end
  end
end
