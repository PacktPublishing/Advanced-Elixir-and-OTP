defmodule Deck.Application do
  use Application

  def start(_type, _args) do
    Deck.Supervisor.start_link()
  end
end
