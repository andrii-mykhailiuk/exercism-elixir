defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    palette_bit_size(color_count, 0)
  end

  defp palette_bit_size(color_count, power) do
    if :math.pow(2, power) >= color_count do
      power
    else
      palette_bit_size(color_count, power + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bits = palette_bit_size(color_count)
    <<pixel_color_index::size(bits), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count), do: nil
  def get_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    <<value::size(bits), _rest::bitstring>> = picture
    value
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>
  def drop_first_pixel(picture, color_count) do
    bits = palette_bit_size(color_count)
    <<_value::size(bits), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
