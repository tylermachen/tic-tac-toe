class Board
  attr_accessor :spaces, :size

  def initialize(size = 3)
    @size = size
    @spaces = build
  end

  def build
    [[1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]]
  end

  def display
    puts """
    *---+---+---*
    | #{spaces[0][0]} | #{spaces[0][1]} | #{spaces[0][2]} |
    +---+---+---+
    | #{spaces[1][0]} | #{spaces[1][1]} | #{spaces[1][2]} |
    +---+---+---+
    | #{spaces[2][0]} | #{spaces[2][1]} | #{spaces[2][2]} |
    *---+---+---*
    """
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

  def winning_combos
    # [[spaces[:a1], spaces[:a2], spaces[:a3]],
    # [spaces[:b1], spaces[:b2], spaces[:b3]],
    # [spaces[:c1], spaces[:c2], spaces[:c3]],
    # [spaces[:a1], spaces[:b1], spaces[:c1]],
    # [spaces[:a2], spaces[:b2], spaces[:c2]],
    # [spaces[:a3], spaces[:b3], spaces[:c3]],
    # [spaces[:a1], spaces[:b2], spaces[:c3]],
    # [spaces[:c1], spaces[:b2], spaces[:a3]]]
  end
end
