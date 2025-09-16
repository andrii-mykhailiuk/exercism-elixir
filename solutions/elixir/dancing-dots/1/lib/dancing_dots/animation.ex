defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl true
  def handle_frame(dot, frame_number, _opts) do
    if rem(frame_number, 4) == 0 do
      %DancingDots.Dot{dot | opacity: dot.opacity / 2}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  @behaviour DancingDots.Animation

  @impl true
  def init(opts) when is_list(opts) do
    case Keyword.fetch(opts, :velocity) do
      {:ok, v} when is_number(v) ->
        {:ok, opts}

      {:ok, v} ->
        {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(v)}"}

      :error ->
        {:error, "The :velocity option is required, and its value must be a number. Got: nil"}
    end
  end

  @impl true
  def handle_frame(dot, frame_number, opts) do
    velocity = Keyword.fetch!(opts, :velocity)
    new_radius = dot.radius + (frame_number - 1) * velocity
    %DancingDots.Dot{dot | radius: new_radius}
  end
end
