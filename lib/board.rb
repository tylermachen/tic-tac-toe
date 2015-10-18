class Board
  attr_accessor :spaces, :size

  def initialize(size = 3)
    @size = size
    @spaces = build
  end

  # build board based on chosen size
  def build
    board = []
    range_start = 1
    range_end = size
    board << (range_start..range_end).to_a
    2.upto(size) do |i|
      range_start = range_end + 1
      range_end = size * i
      board << (range_start..range_end).to_a
    end
    board
  end

  def display
    puts "\n"
    spaces.each.with_index do |row, row_index|
      puts " ---" * size
      row.each.with_index(1) do |space, space_index|
        if space_index == size
          if space.to_i < 10
            puts "| #{space} |"
          else
            puts "| #{space}|"
          end
        else
          if space.to_i < 10
            print "| #{space} "
          else
            print "| #{space}"
          end
        end
      end
    end
    puts " ---" * size
    puts "\n"
  end

  def reset
    start_index = 0
    spaces.map! do |row|
      row.map!.with_index(start_index) do |space, index|
        space = index
        start_index += 1
      end
    end
  end

  def available_spaces
    spaces.map do |row|
      row.select do |space|
        space != 'X' && space != 'O'
      end
    end
  end

  # call each winning method below to check if there has been a winner and return winning token
  def winning_token
    token = false
    r1 = horizontal_win?
    r2 = vertical_win?
    r3 = left_top_diagonal_win?
    r4 = left_bottom_diagonal_win?
    case
      when r1 then token = r1
      when r2 then token = r2
      when r3 then token = r3
      when r4 then token = r4
    end
    token
  end

  # iterate over all horizontal spaces checking for winner based on board size
  def horizontal_win?
    winner = false
    spaces.each do |row|
      winner = token_match?(row)
      break if winner
    end
    winner
  end

  # iterate over all vertical spaces checking for winner based on board size
  def vertical_win?
    winner = false
    arr = []
    size.times do |i|
      spaces.each { |row| arr << row[i] }
      winner = token_match?(arr)
      break if winner
      arr = []
    end
    winner
  end

  # iterate over array and check spaces from upper-left-hand corner to lower-right-hand based on board size
  def left_top_diagonal_win?
    arr = []
    size.times { |i| arr << spaces[i][i] }
    token_match?(arr)
  end

  # iterate over array and check spaces from lower-left-hand corner to upper-right-hand based on board size
  def left_bottom_diagonal_win?
    arr = []
    size.times { |i| arr << spaces[spaces.length - (1 + i)][i] }
    token_match?(arr)
  end

  # iterate over array of spaces and see if they are all X's or O's (have a winner)
  def token_match?(array)
    winner = false
    if array.all? { |space| space == 'X' }
      winner = array[0]
    elsif array.all? { |space| space == 'O' }
      winner = array[0]
    end
    winner
  end
end
