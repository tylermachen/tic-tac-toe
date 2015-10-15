class Game
  PROMPT = '> '
  attr_accessor :board, :p1, :p2

  def initialize(board = nil, player1 = nil, player2 = nil)
    @board = board
    @p1 = player1
    @p2 = player2
  end

  def play
    intro
    board.print
    move(p1)
    board.print
  end

  def intro
    puts 'Welcome to Tic-Tac-Toe'
  end

  def valid_move?(space)
    board.spaces[space].nil?
  end

  def get_input
    print PROMPT
    gets.chomp.downcase
  end

  def exit_game
    puts 'Goodbye.'
    exit
  end

  def move(player)
    puts "Please choose an empty space on the game board (e.g. type \'a1\' to place your piece in the upper-left-hand corner)."
    input = get_input
    if valid_move?(input)
      board.spaces[input.to_sym] = player.piece
    else
      move
    end
  end

  def play_again?
    puts 'Would you like to play again? (yes/no)'
    input = get_input
    case input
      when 'yes' then play
      when 'no'  then exit_game
      else exit_game
    end
  end
end
