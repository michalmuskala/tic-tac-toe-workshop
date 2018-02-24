defmodule TicTacToe.Game do
  alias TicTacToe.{Game, Board}

  defstruct player: :x, board: Board.new()

  def new(), do: %Game{}

  def move(%Game{player: player, board: board} = game, x, y) do
    case Board.move(board, x, y, player) do
      :not_allowed ->
        {:not_allowed, game}

      new_board ->
        game = %{game | player: next_player(player), board: new_board}

        case Board.find_winner(new_board) do
          :no_winner ->
            {:ok, game}

          winner ->
            {:winner, winner, game}
        end
    end
  end

  def print(%Game{player: player, board: board}) do
    IO.puts ["Next player: #{player}\n", Board.print(board)]
  end

  defp next_player(:x), do: :o
  defp next_player(:o), do: :x
end
