defmodule TicTacToe.Application do
  @behaviour Application

  def start(_type, _args) do
    TicTacToe.Supervisor.start_link()
  end

  def stop(_) do
    :ok
  end
end
