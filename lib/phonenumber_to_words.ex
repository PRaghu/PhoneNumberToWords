defmodule PhonenumberToWords do
  require Logger
  
  use GenServer

###-----------------------------------------------------
### API
###----------------------------------------------------

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: PhonenumberToWords)
  end

  @spec transform(Integer) :: String | List
  def transform(number) when is_integer(number) do
    GenServer.call(PhonenumberToWords, number)
  end

  def transform(_) do
    "Invalid Input"
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
        word_to_num_str(word, acc) 
      end)

    {:ok, %{words: words_list}}
  end
  
  @impl true
  def handle_call(number, _from, state) do
    :ok = Logger.info "Transform number to words: #{inspect(number)}"
    {:reply, "Words", state}
  end

###-----------------------------------------------------
### Internal Functions
###----------------------------------------------------

  def word_to_num_str(word, acc) do
    
    num_str = 
      Enum.join for char <- String.codepoints(word), do: Utils.to_number_str(char)
    
    case Map.get(acc, num_str) do
      nil ->
        Map.put_new(acc, num_str, [word])
      list ->
        Map.put(acc, num_str, [word | list])
    end
  end

end