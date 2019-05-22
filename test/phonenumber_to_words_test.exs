defmodule PhonenumberToWordsTest do
  use ExUnit.Case
  doctest PhonenumberToWords

  test "Valid Input" do
    assert PhonenumberToWords.transform 2354689789 == "Words"
  end
  
  test "Invalid Input" do
  	assert PhonenumberToWords.transform "1457895446" == "Invalid Input"
  end

end
