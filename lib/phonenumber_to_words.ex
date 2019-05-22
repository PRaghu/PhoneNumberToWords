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
    {:ok, %{}}
  end
  
  @impl true
  def handle_call(number, _from, state) do
    :ok = Logger.info "Transform number to words: #{inspect(number)}"
    {:reply, "Words", state}
  end

end
