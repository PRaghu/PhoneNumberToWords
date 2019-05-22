Benchee.run(%{
  "words" => fn input -> PhonenumberToWords.convert(input) end 
  },
  inputs: %{
    "input 1" => 123,
    "input 2" => 6686787825,
    "input 3" => 2282668687,
    "input 4" => "8ae75896775"
  },
  parallel: 4,
  time: 5,
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: "benchmark/output/phonenumber_to_words_inputs.html"}

  ]
)
