class Game
  attr_accessor :board, :p1, :p2

  def initialize(board = nil, player1 = nil, player2 = nil)
    @board = board
    @p1 = player1
    @p2 = player2
  end

  def play
    board.print
  end
end
