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

  def print_to_screen(server) do
    GenServer.cast(server, :print_to_screen)
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

  def handle_cast(:print_to_screen, %{:board => board, :player => player} = state) do
    board_string = Board.print(board)
    IO.puts("#{board_string}\nNext player: #{player}")
    {:noreply, state}
  end

  defp next_player(:x), do: :o
  defp next_player(:o), do: :x
end
