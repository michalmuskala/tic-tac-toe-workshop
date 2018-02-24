defmodule TicTacToe.GenServer do
  @behaviour GenServer

  alias TicTacToe.Board

  ## Public interface

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def move(server, x, y) do
    GenServer.call(server, {:move, x, y})
  end

  def print(server) do
    GenServer.call(server, :print)
  end

  ## GenServer implementation

  # => = >
  def init(_) do
    state = %{:board => Board.new(), :player => :x}
    {:ok, state}
  end

  def handle_call({:move, x, y}, _metadata, state) do
    %{:board => board, :player => player} = state
    case Board.move(board, x, y, player) do
      :not_allowed ->
        {:reply, :not_allowed, state}
      new_board ->
        new_state = %{:board => new_board, :player => next_player(player)}
        {:reply, :ok, new_state}
    end
  end

  def handle_call(:print, _metadata, state) do
    %{:board => board} = state
    {:reply, board, state}
  end

  defp next_player(:x), do: :o
  defp next_player(:o), do: :x
end
