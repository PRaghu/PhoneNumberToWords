defmodule PhonenumberToWordsTest do
  use ExUnit.Case
  doctest PhonenumberToWords

  test "Valid Phonenumber" do
    assert PhonenumberToWords.convert(6686787825) ==
      [
        ["onto", "struck"],
        ["noun", "struck"],
        ["nouns", "usual"],
        ["nouns", "truck"],
        ["motor", "usual"],
        ["motor", "truck"],
        "motortruck"
     ]
    assert PhonenumberToWords.convert(2282668687) ==
      [
        ["cat", "contour"],
        ["cat", "amounts"],
        ["bat", "contour"],
        ["bat", "amounts"],
        ["act", "contour"],
        ["act", "amounts"],
        ["acta", "mounts"],
        "catamounts"
      ]
    assert PhonenumberToWords.convert(8658786377) == 
      [
      	["unjust", "ness"], 
      	["unjust", "mess"], 
      	"unjustness"
      ]
    assert PhonenumberToWords.convert(2548683832) == []
  end
  
  test "Invalid Phonenumber" do
    assert PhonenumberToWords.convert("1457895446") == "Invalid Phonenumber"
    assert PhonenumberToWords.convert(1200800111)   == "Invalid Phonenumber"
    assert PhonenumberToWords.convert(2282)         == "Invalid Phonenumber"
  end

end
