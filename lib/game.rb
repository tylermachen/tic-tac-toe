class Game
  PROMPT = '> '
  attr_reader :board, :human, :computer

  def initialize(board = nil, human = nil, computer = nil)
    @board = board
    @human = human
    @computer = computer
  end

  def play
    intro
    choose_token
    choose_board_size
    board.reset
    board.display
    loop do
      human_move
      board.display

      # only check for winner if there have been enough turns for someone to win
      if board.available_spaces.flatten.length <= board.size ** 2 - board.size
        game_over?
      end

      computer_move
      board.display

      # only check for winner if there have been enough turns for someone to win
      if board.available_spaces.flatten.length <= board.size ** 2 - board.size
        game_over?
      end
    end
  end

  def intro
    puts 'Welcome to Tic-Tac-Toe'
  end

  def valid_move?(space)
    valid = false
    board.spaces.each do |row|
      valid = row.any? { |s| s == space.to_i }
      break if valid
    end
    valid
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
      puts "Sweet. You are #{human.token}'s"
      sleep(1)
    elsif input == 'o'
      human.token = 'O'
      computer.token = 'X'
      puts "Sweet. You are #{human.token}'s"
      sleep(1)
    else
      choose_token
    end
  end

  def choose_board_size
    puts 'What size board would you like? (e.g. enter \'3\' for a 3x3 board. Enter \'5\' for a 5x5 board and so on.)'
    input = get_input
    if (3..10).to_a.include?(input.to_i)
      board.size = input.to_i
      board.spaces = board.build
    else
      puts "Please choose a board size of 3 or greater."
      choose_board_size
    end
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
    puts 'Please choose an empty space on the game board (e.g. type \'1\' to place your piece in the upper-left-hand corner).'
    input = get_input
    if valid_move?(input)
      board.spaces.map! do |row|
        row.map! do |space|
          if input.to_i == space
            space = human.token
          else
            space
          end
        end
      end
    else
      human_move
    end
  end

  def computer_move
    puts 'The computer is thinking...'
    sleep(1)
    input = board.available_spaces.sample.sample
    if valid_move?(input)
      board.spaces.map! do |row|
        row.map! do |space|
          if input.to_i == space
            space = computer.token
          else
            space
          end
        end
      end
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
    winner = board.winning_token
    case winner
      when human.token then human_win
      when computer.token then computer_win
      else draw if board.available_spaces.flatten.length < 1
    end
  end
end
