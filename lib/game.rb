class Game
  PROMPT = '> '
  attr_accessor :board, :human, :computer

  def initialize(board = nil, human = nil, computer = nil)
    @board = board
    @human = human
    @computer = computer
  end

  def play
    intro
    choose_token
    board.reset
    board.display
    loop do
      human_move
      board.display

      if board.available_spaces.length <= 6
        game_over?
      end

      computer_move
      board.display

      if board.available_spaces.length <= 6
        game_over?
      end
    end
  end

  def intro
    puts 'Welcome to Tic-Tac-Toe'
  end

  def valid_move?(space)
    board.spaces[space.to_sym] == ' '
  end

  def get_input
    print PROMPT
    input = gets.chomp.downcase
    if input == 'q' || input == 'quit'
      exit_game
    end
    input
  end

  def exit_game
    puts 'Goodbye.'
    exit
  end

  def choose_token
    puts 'Would you like to be X\'s or O\'s? (type \'x\' or \'o\')'
    input = get_input

    if input == 'x'
      human.token = 'X'
      computer.token = 'O'
    elsif input == 'o'
      human.token = 'O'
      computer.token = 'X'
    else
      choose_token
    end

    puts "Sweet. You are #{human.token}'s"
    sleep(1)
  end

  def play_again?
    puts 'Would you like to play again? (yes/no)'
    input = get_input
    case input
      when 'yes' then play
      when 'no'  then exit_game
      else play_again?
    end
  end

  def human_move
    puts 'Please choose an empty space on the game board (e.g. type \'a1\' to place your piece in the upper-left-hand corner).'
    input = get_input
    if valid_move?(input)
      board.spaces[input.to_sym] = human.token
    else
      human_move
    end
  end

  def computer_move
    puts 'The computer is thinking...'
    sleep(1)
    space = board.available_spaces.sample
    if valid_move?(space)
      board.spaces[space.to_sym] = computer.token
    else
      computer_move
    end
  end

  def draw
    puts 'Tie!'
    play_again?
  end

  def human_win
    puts 'You win!'
    play_again?
  end

  def computer_win
    puts 'The computer wins :('
    play_again?
  end

  def game_over?
    human_win if winner == 1
    computer_win if winner == 2
    draw if board.available_spaces.length < 1
  end

  def winner
    # iterate over each set of possible combos checking to see if human or computer has achieved any
    board.winning_combos.each do |combo|
      if (combo[0] == human.token) && (combo[1] == human.token) && (combo[2] == human.token)
        # human wins
        return 1
      elsif (combo[0] == computer.token) && (combo[1] == computer.token) && (combo[2] == computer.token)
        # computer wins
        return 2
      end
    end
  end
end
