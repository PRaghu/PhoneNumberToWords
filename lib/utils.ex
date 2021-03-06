defmodule Utils do
  @moduledoc """
  Utility Functions
  """

  @doc """
  Converts character to number string

  ## Parameter

      -ch: character (lowercase alphabets)

  ## Example

      iex>Utils.to_number_str("a")
      "2"
  """
  @spec to_number_str(binary()) :: binary()
  def to_number_str(ch) when ch == "a" or ch == "b" or ch == "c", do: "2"
  def to_number_str(ch) when ch == "d" or ch == "e" or ch == "f", do: "3"
  def to_number_str(ch) when ch == "g" or ch == "h" or ch == "i", do: "4"
  def to_number_str(ch) when ch == "j" or ch == "k" or ch == "l", do: "5"
  def to_number_str(ch) when ch == "m" or ch == "n" or ch == "o", do: "6"
  def to_number_str(ch) when ch == "p" or ch == "q" or ch == "r" or ch == "s", do: "7"
  def to_number_str(ch) when ch == "t" or ch == "u" or ch == "v", do: "8"
  def to_number_str(ch) when ch == "w" or ch == "x" or ch == "y" or ch == "z", do: "9"

  @doc """
  Converts integer value to string

  ## Parameter
       -value: Integer

  ## Example

       iex>Utils.to_str(6645)
       "6645"
  """
  @spec to_str(integer()) :: binary()
  def to_str(value) when is_integer(value), do: Integer.to_string(value)
  
end

