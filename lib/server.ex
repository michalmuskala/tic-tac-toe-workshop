defmodule TicTacToe.Server do
  alias TicTacToe.Board

  require Logger

  def spawn() do
    spawn(fn -> loop(Board.new(), :x) end)
  end

  def call(pid, msg) do
    send(pid, {msg, self()})
    receive do
      reply -> reply
    end
  end

  defp loop(board, next_player) do
    receive do
      {{:move, x, y}, reply_to} ->
        new_board = handle_move(board, next_player, x, y, reply_to)
        loop(new_board, next_player(next_player))
      {:print, reply_to} ->
        handle_print(board, reply_to)
        loop(board, next_player)
      msg ->
        Logger.error("Unexpected message in process #{inspect self()}: #{inspect msg}")
    end
  end

  defp next_player(:x), do: :o
  defp next_player(:o), do: :x

  defp handle_print(board, reply_to) do
    send(reply_to, board)
  end

  defp handle_move(board, next_player, x, y, reply_to) do
    case Board.move(board, x, y, next_player) do
      :not_allowed ->
        send(reply_to, :not_allowed)
        board
      new_board ->
        send(reply_to, :ok)
        new_board
    end
  end
end
