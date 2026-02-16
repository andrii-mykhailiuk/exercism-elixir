defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{RemoteControlCar.new() | nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery}) do
    case battery do
      0 -> "Battery empty"
      _ -> "Battery at #{battery}%"
    end
  end

  def drive(
        %RemoteControlCar{battery_percentage: battery, distance_driven_in_meters: distance} =
          remote_car
      ) do
    case battery do
      0 ->
        remote_car

      _ ->
        %RemoteControlCar{
          remote_car
          | battery_percentage: battery - 1,
            distance_driven_in_meters: distance + 20
        }
    end
  end
end
