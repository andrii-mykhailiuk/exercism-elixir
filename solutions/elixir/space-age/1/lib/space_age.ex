defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(:earth, seconds) do
    seconds_in_day = 60 * 60 * 24
    days_in_year = 365.25
    {:ok, seconds / seconds_in_day / days_in_year}
  end

  def age_on(:mercury, seconds) do
    mercury_coef = 0.2408467
    {:ok, earth_age} = age_on(:earth, seconds)
    {:ok, Float.round(earth_age / mercury_coef, 2)}
  end

  def age_on(:venus, seconds) do
    venus_coef = 0.61519726
    {:ok, earth_age} = age_on(:earth, seconds)
    {:ok, Float.round(earth_age / venus_coef, 2)}
  end

  def age_on(:mars, seconds) do
    mars_coef = 1.8808158
    {:ok, earth_age} = age_on(:earth, seconds)
    {:ok, Float.round(earth_age / mars_coef, 2)}
  end

  def age_on(:jupiter, seconds) do
    jupiter_coef = 11.862615
    {:ok, earth_age} = age_on(:earth, seconds)
    {:ok, Float.round(earth_age / jupiter_coef, 2)}
  end

  def age_on(:saturn, seconds) do
    saturn_coef = 29.447498
    {:ok, earth_age} = age_on(:earth, seconds)
    {:ok, Float.round(earth_age / saturn_coef, 2)}
  end

  def age_on(:uranus, seconds) do
    uranus_coef = 84.016846
    {:ok, earth_age} = age_on(:earth, seconds)
    {:ok, Float.round(earth_age / uranus_coef, 2)}
  end

  def age_on(:neptune, seconds) do
    neptune_coef = 164.79132
    {:ok, earth_age} = age_on(:earth, seconds)
    {:ok, Float.round(earth_age / neptune_coef, 2)}
  end

  def age_on(_, _seconds) do
    {:error, "not a planet"}
  end
end
