defmodule DeckTest do
  use ExUnit.Case
  doctest Deck

  test "greets the world" do
    assert Deck.hello() == :world
  end
end
