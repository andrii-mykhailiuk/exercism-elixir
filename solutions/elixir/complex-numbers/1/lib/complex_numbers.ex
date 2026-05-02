defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({real, _imaginary}) do
    real
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_real, imaginary}) do
    imaginary
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) do
    {a_re, a_im} = to_complex(a)
    {b_re, b_im} = to_complex(b)

    {a_re * b_re + a_im * b_im * -1, a_re * b_im + b_re * a_im}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) do
    {a_re, a_im} = to_complex(a)
    {b_re, b_im} = to_complex(b)

    {a_re + b_re, a_im + b_im}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) do
    {a_re, a_im} = to_complex(a)
    {b_re, b_im} = to_complex(b)

    {a_re - b_re, a_im - b_im}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b) do
    {a_re, a_im} = to_complex(a)
    {b_re, b_im} = to_complex(b)

    # Знаменник: c^2 + d^2
    denominator = b_re * b_re + b_im * b_im

    # Новий чисельник (реальна частина): (ac + bd) / denominator
    new_re = (a_re * b_re + a_im * b_im) / denominator

    # Новий чисельник (уявна частина): (bc - ad) / denominator
    new_im = (a_im * b_re - a_re * b_im) / denominator

    {new_re, new_im}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs(a) do
    {a_re, a_im} = to_complex(a)
    :math.sqrt(Integer.pow(a_re, 2) + Integer.pow(a_im, 2))
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({re, im}) do
    {re, im * -1}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({re, im}) do
    exp_re = :math.exp(re)

    {exp_re * :math.cos(im), exp_re * :math.sin(im)}
  end

  @spec to_complex(num :: complex | number) :: complex
  defp to_complex({re, im}), do: {re, im}

  defp to_complex(num) when is_number(num) do
    {num, 0}
  end
end
