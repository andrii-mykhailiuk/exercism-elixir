defmodule TakeANumberDeluxe do
  use GenServer

  # Client API
  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(args) do
    min = Keyword.get(args, :min_number)
    max = Keyword.get(args, :max_number)
    timeout = Keyword.get(args, :auto_shutdown_timeout, :infinity)

    case TakeANumberDeluxe.State.new(min, max, timeout) do
      {:ok, state} -> GenServer.start_link(TakeANumberDeluxe, state)
      {:error, reason} -> {:error, reason}
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_num)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks
  @impl GenServer
  def init(state) do
    {:ok, state, state.auto_shutdown_timeout}
  end

  @ipml GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @ipml GenServer
  def handle_call(:queue_new_num, _from, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, next_num, new_state} ->
        {:reply, {:ok, next_num}, new_state, new_state.auto_shutdown_timeout}

      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @ipml GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, new_state.auto_shutdown_timeout}
      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    case TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout) do
      {:ok, new_state} -> {:noreply, new_state, new_state.auto_shutdown_timeout}
      {:error, reason} -> {:noreply, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @ipml GenServer
  def handle_info(_unexpected, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
