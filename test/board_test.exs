defmodule TicTacToe.BoardTest do
  use ExUnit.Case, async: true

  alias TicTacToe.Board

  test "new returns empty board" do
    assert Board.new() == {
      {:empty, :empty, :empty},
      {:empty, :empty, :empty},
      {:empty, :empty, :empty}
    }
  end

  describe "move/4" do
    test "sets correct element" do
      board = Board.new()
      board = Board.move(board, 0, 0, :x)
      assert board == {
        {:x, :empty, :empty},
        {:empty, :empty, :empty},
        {:empty, :empty, :empty}
      }
    end

    test "does not allow overriding" do
      board = Board.new()
      board = Board.move(board, 0, 0, :x)
      assert Board.move(board, 0, 0, :o) == :not_allowed
    end
  end
end
