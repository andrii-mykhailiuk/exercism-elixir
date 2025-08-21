defmodule Secrets do
  def secret_add(secret) do
    # Please implement the secret_add/1 function
    fn adder -> secret + adder end
  end

  def secret_subtract(secret) do
    # Please implement the secret_subtract/1 function
    fn substractor -> substractor - secret end
  end

  def secret_multiply(secret) do
    # Please implement the secret_multiply/1 function
    fn multiplyer -> secret * multiplyer end
  end

  def secret_divide(secret) do
    # Please implement the secret_divide/1 function
    fn divider -> div(divider, secret) end
  end

  def secret_and(secret) do
    # Please implement the secret_and/1 function
    fn ander -> Bitwise.band(ander, secret) end
  end

  def secret_xor(secret) do
    # Please implement the secret_xor/1 function
    fn xorer -> Bitwise.bxor(xorer, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    # Please implement the secret_combine/2 function
    fn combiner ->
      first = secret_function1.(combiner)
      secret_function2.(first)
    end
  end
end
