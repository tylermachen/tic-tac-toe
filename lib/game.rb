class Game
  PROMPT = '> '
  SLEEP_DURATION = 1.5
  attr_reader :board, :human, :computer

  def initialize(board = nil, human = nil, computer = nil)
    @board = board
    @human = human
    @computer = computer
  end

  def play
    intro
    choose_character
    choose_token
    generate_opponent
    choose_board_size
    board.reset
    board.display
    loop do
      human_move
      board.display
      game_over? if game_can_be_won?
      computer_move
      board.display
      game_over? if game_can_be_won?
    end
  end

  private

  def intro
    puts """
            DONT OPEN|DEAD INSIDE
    *~---------------------------------~*
    | THE WALKING DEAD    @@@@          |
    | TIC-TAC-TOE        (¬º-°)¬        |
    |                                   |
    | v1.0              by Tyler Machen |
    *~---------------------------------~*
    Wins: #{human.wins}  Losses: #{human.losses}  Draws: #{human.draws}
    type \'quit\' at any time to exit the game
    """
  end

  def choose_character
    puts "Please choose a character (1-10):"
    count = 1
    Character::CHARACTER_QUOTE_HASH.each do |character, quote|
      puts "#{count}.) #{character}"
      count += 1
    end

    character_choice = get_input
    case character_choice
      when "1" then human.character = "Rick Grimes"
      when "2" then human.character = "Lori Grimes"
      when "3" then human.character = "Shane Walsh"
      when "4" then human.character = "Dale Horvath"
      when "5" then human.character = "Daryl Dixon"
      when "6" then human.character = "Glenn Rhee"
      when "7" then human.character = "Maggie Greene"
      when "8" then human.character = "Michonne"
      when "9" then human.character = "The Governor"
      when "10" then human.character = "Hershel Greene"
      else choose_character
    end

    puts "\nYou\'ve chosen #{human.character.upcase}:"
    # choose random character quote for display
    puts "\"" + Character::CHARACTER_QUOTE_HASH["#{human.character}"][rand(0..2)] + "\"\n\n"
    sleep(SLEEP_DURATION)
  end

  def choose_token
    puts "Would you like to be X\'s or O\'s? (type \'x\' or \'o\')"
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
  end

  def generate_opponent
    # pick a random zombie from the pack as the opponent
    Zombie::ZOMBIE_HASH.to_a.shuffle.each do |zombie, description|
      computer.character = zombie.upcase
      @zombie_description = description
      break
    end
    puts "\nYou are playing against a #{computer.character}:"
    puts "#{@zombie_description}"
    sleep(SLEEP_DURATION)
  end

  def choose_board_size
    puts "\nWhat size board would you like? (e.g. enter \'3\' for a 3x3 board. Enter \'5\' for a 5x5 board and so on.)"
    input = get_input
    if (3..10).to_a.include?(input.to_i)
      board.size = input.to_i
      board.spaces = board.build
      puts "\nYou are #{human.token}\'s and get to go first. Good luck."
      sleep(SLEEP_DURATION)
    else
      puts "\nPlease choose a board size of 3 or greater."
      choose_board_size
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
    puts "The #{computer.character} is planning it\'s next move..."
    sleep(SLEEP_DURATION)
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

  def game_over?
    winner = board.winning_token
    case winner
      when human.token then human_win
      when computer.token then computer_win
    end
    draw if board.available_spaces.flatten.length < 1
  end

  def game_over_message(hash)
    hash.each do |character, quote|
      if human.character.downcase == character.downcase
        end_quote = "\"#{quote.sample}\""
        return end_quote + "\n - " + character
      end
    end
  end

  def draw
    puts "You made it out alive...for now (TIE GAME!)."
    puts game_over_message(Character::DRAW_HASH)
    human.draws += 1
    play_again?
  end

  def human_win
    puts "You defeated the #{computer.character}! (YOU WIN!)"
    puts game_over_message(Character::CHARACTER_WIN_HASH)
    human.wins += 1
    play_again?
  end

  def computer_win
    puts "You failed and the #{computer.character} is enjoying your flesh. (YOU LOSE!)"
    puts game_over_message(Character::CHARACTER_LOSE_HASH)
    human.losses += 1
    play_again?
  end

  def play_again?
    puts "\nWould you like to play again? (yes / no)"
    input = get_input
    case input
      when 'yes' then play
      when 'no'  then exit_game
      else play_again?
    end
  end

  def get_input
    print PROMPT
    input = gets.chomp.downcase
    if input == 'q' || input == 'quit'
      exit_game
    end
    input
  end


  def valid_move?(space)
    valid = false
    board.spaces.each do |row|
      valid = row.any? { |s| s == space.to_i }
      break if valid
    end
    valid
  end

  def game_can_be_won?
    board.available_spaces.flatten.length <= board.size ** 2 - board.size
  end

  def exit_game
    puts "\nFarewell, my friend.\n\n"
    exit
  end
end
