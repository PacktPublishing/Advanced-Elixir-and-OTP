defmodule Deck do
  use GenServer

  @deck_size Application.get_env(:deck, :size)

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def take_card() do
    GenServer.call(__MODULE__, {:take_card})
  end

  def init(_) do
    {:ok, Enum.shuffle(1..@deck_size)}
  end

  def handle_call({:take_card}, _from, [card|deck]) do
    {:reply, card, deck}
  end
end
