# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {1, []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_next, regs} -> regs end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {next_id, regs} ->
      plot = %Plot{plot_id: next_id, registered_to: register_to}
      {plot, {next_id + 1, [plot | regs]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.get_and_update(pid, fn {next_id, regs} ->
      {:ok, {next_id, Enum.filter(regs, fn plot -> plot.plot_id != plot_id end)}}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {_next_id, regs} ->
      Enum.find(regs, fn plot -> plot.plot_id == plot_id end) ||
       {:not_found, "plot is unregistered"}
    end)
  end
end
