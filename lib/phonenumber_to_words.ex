defmodule PhonenumberToWords do
  @moduledoc """
  Provides a function `convert/1` to find the available words for the Phonenumber.
  """

  use GenServer

###-----------------------------------------------------
### API
###----------------------------------------------------

  @doc """
  Start the server and register it locally with module name
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc """
  Converts the given phonenumber to dictionary words.

  ## Parameters

      -number: Postive integer with 10 digits and should not contain 0 and 1

  ## Examples

      iex> PhonenumberToWords.convert(6686787825)
      [
        ["onto", "struck"],
        ["noun", "struck"],
        ["nouns", "usual"],
        ["nouns", "truck"],
        ["motor", "usual"],
        ["motor", "truck"],
        "motortruck"
      ]

      iex> PhonenumberToWords.convert(6686787815)
      "Invalid Phonenumber"

      iex> PhonenumberToWords.convert(123)
      "Invalid Phonenumber"

      iex> PhonenumberToWords.convert("asdfghj123")
      "Invalid Phonenumber"
  """
  @spec convert(any()) :: binary() | list()
  def convert(phonenumber) when is_integer(phonenumber) do
    phonenumber_str = Utils.to_str(phonenumber)

    case validate_str(phonenumber_str) do
      :valid ->
        GenServer.call(PhonenumberToWords, phonenumber_str)
      :invalid ->
        "Invalid Phonenumber"
    end
  end

  def convert(_) do
    "Invalid Phonenumber"
  end

###-----------------------------------------------------
### Gen Server Callbacks
###----------------------------------------------------

  @impl true
  def init(_opts) do
    file_path = Application.get_env(:phonenumber_to_words, :dictionary_file_path)
    {:ok, bin} = File.read(file_path)

    dictionary_words = 
      for word <- String.split(bin, "\n"), do: String.downcase(word)

    words_list = 
      List.foldl(dictionary_words, %{}, fn(word, acc) -> 
        assign_num_to_word(word, acc)
      end)

    {:ok, %{words: words_list}}
  end
  
  @impl true
  def handle_call(phonenumber, _from, %{words: words_list} = state) do

    number_split_list =  for number <- Enum.to_list(3..7),
      do: String.split_at(phonenumber, number)

    words = Enum.concat(for number_strs <- number_split_list,
      do: get_words(number_strs, words_list))

    result = words ++ Map.get(words_list, phonenumber, [])
    {:reply, result, state}

  end

###-----------------------------------------------------
### Internal Functions
###----------------------------------------------------

# @doc """
# assigns numberstring to the dictionary word and adds to accumlater

# ## Examples
#     iex> PhonenumberToWords.assign_num_to_word("unjust", %{})
#     %{"865878" => ["unjust"]}
# """
  defp assign_num_to_word(word, acc) do
    num_str = 
      Enum.join for char <- String.codepoints(word), do: Utils.to_number_str(char)

    case Map.get(acc, num_str) do
      nil ->
        Map.put_new(acc, num_str, [word])
      list ->
        Map.put(acc, num_str, [word | list])
    end
  end

  defp validate_str(phonenumber) do
    case String.length(phonenumber) === 10 do
      true ->
        case :re.run(phonenumber, "[0-1]", [:global]) do
          :nomatch -> :valid
          _ -> :invalid
        end
      false -> :invalid
    end
  end

  defp get_words({number_str1, number_str2}, words_list) do
    case [Map.get(words_list, number_str1), Map.get(words_list, number_str2)] do
      [list1, list2] when list1 != [] and list1 != nil and list2 != [] and list2 != nil ->
        for item1 <- list1, item2 <- list2, do: [item1, item2]
      _list ->
        []
    end
  end

end