# PhonenumberToWords

****PhonenumberToWords**** application provides a solution to find the words available from the phone number

## Quick Setup and Start
Make sure you have installed Erlang 21.3, Elixir v1.18 and above on your machine
Then

```
git clone https://github.com/PRaghu/PhonenumberToWords.git
cd PhonenumberToWords
mix deps.get
mix compile
```

### Start

To run Elixir terminal use command ```iex -S mix```
then try below examples

****EXAMPLES****
```
iex> PhonenumberToWords.convert(2282668687)
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

iex> PhonenumberToWords.convert(2282668681)
"Invalid Phonenumber"

iex> :timer.tc(fn -> PhonenumberToWords.convert(6686787825) end)
{93,
 [
   ["onto", "struck"],
   ["noun", "struck"],
   ["nouns", "usual"],
   ["nouns", "truck"],
   ["motor", "usual"],
   ["motor", "truck"],
   "motortruck"
 ]}

 It took around 93 microseconds to execute the function
```

### TOOLS
*Coverage*
```mix test --cover```

```
Cover compiling modules ...
......
Finished in 0.06 seconds
4 doctests, 2 tests, 0 failures
Randomized with seed 378813
Generating cover results ...
Percentage | Module
-----------|--------------------------
   100.00% | PhonenumberToWords
   100.00% | Utils
   100.00% | PhonenumberToWords.Application
-----------|--------------------------
   100.00% | Total
```

*Dialyzer*

``` mix dialyzer```
For the first time it takes some time because of *PLT files*

```
Compiling 3 files (.ex)
Generated phonenumber_to_words app
Finding suitable PLTs
Checking PLT...
[:benchee, :benchee_html, :benchee_json, :compiler, :deep_merge, :earmark, :elixir, :ex_doc, :jason, :kernel, :logger, :makeup, :makeup_elixir, :nimble_parsec, :stdlib]
PLT is up to date!
No :ignore_warnings opt specified in mix.exs and default does not exist.
Starting Dialyzer
[
  check_plt: false,
  init_plt: '',
  files_rec: ['your ebin files location'],
  warnings: [:unknown]
]
Total errors: 0, Skipped: 0, Unnecessary Skips: 0
done in 0m1.42s
done (passed successfully)
```

*Benchmark*
```mix run benchmark/phonenumber_to_words.exs ```

```
Inputs:
    input 1 = 123,
    input 2 = 6686787825,
    input 3 = 2282668687,
    input 4 = "8ae75896775"

##### With input input 1 #####
Name            ips        average  deviation         median         99th %
words      845.73 K        1.18 μs  ±3169.53%        0.96 μs        1.41 μs

##### With input input 2 #####
Name            ips        average  deviation         median         99th %
words       21.11 K       47.37 μs   ±164.61%       33.55 μs      132.16 μs

##### With input input 3 #####
Name            ips        average  deviation         median         99th %
words       21.97 K       45.52 μs   ±140.75%       32.84 μs      128.57 μs

##### With input input 4 #####
Name            ips        average  deviation         median         99th %
words        5.39 M      185.44 ns  ±7668.41%         124 ns         236 ns
```

```For more details check the folder /benchmark/output/ directory```



