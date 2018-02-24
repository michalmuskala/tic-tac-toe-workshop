defmodule TicTacToe.Board do
  def new() do
    {
      :empty,:empty,:empty,
      :empty,:empty,:empty,
      :empty,:empty,:empty
    }
  end

  def move(board, x, y, player) when elem(board, x * 3 + y) == :empty do
    put_elem(board, x * 3 + y, player)
  end

  def move(_board, _, _, _) do
    :not_allowed
  end

  def find_winner({m,m,m,_,_,_,_,_,_}) when m != :empty, do: m
  def find_winner({_,_,_,m,m,m,_,_,_}) when m != :empty, do: m
  def find_winner({_,_,_,_,_,_,m,m,m}) when m != :empty, do: m
  def find_winner({m,_,_,m,_,_,m,_,_}) when m != :empty, do: m
  def find_winner({_,m,_,_,m,_,_,m,_}) when m != :empty, do: m
  def find_winner({_,_,m,_,_,m,_,_,m}) when m != :empty, do: m
  def find_winner({m,_,_,_,m,_,_,_,m}) when m != :empty, do: m
  def find_winner({_,_,m,_,m,_,m,_,_}) when m != :empty, do: m
  def find_winner({_,_,_,_,_,_,_,_,_}), do: :no_winner

  def print({x1,x2,x3,y1,y2,y3,z1,z2,z3}) do
    [
      print_field(x1), " | ", print_field(x2), " | ", print_field(x3), "\n",
      print_field(y1), " | ", print_field(y2), " | ", print_field(y3), "\n",
      print_field(z1), " | ", print_field(z2), " | ", print_field(z3)
    ]
  end

  defp print_field(:x), do: " x "
  defp print_field(:o), do: " o "
  defp print_field(:empty), do: "   "
end
