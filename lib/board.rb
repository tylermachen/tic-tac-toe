class Board
  attr_accessor :spaces, :size

  def initialize(size = 3)
    @size = size
    @spaces = {
      a1: @a1 = ' ', a2: @a2 = ' ', a3: @a3 = ' ',
      b1: @b1 = ' ', b2: @b2 = ' ', b3: @b3 = ' ',
      c1: @c1 = ' ', c2: @c2 = ' ', c3: @c3 = ' '
    }
  end

  def display
    puts """
        1   2   3
      *---+---+---*
    a | #{spaces[:a1]} | #{spaces[:a2]} | #{spaces[:a3]} |
      +---+---+---+
    b | #{spaces[:b1]} | #{spaces[:b2]} | #{spaces[:b3]} |
      +---+---+---+
    c | #{spaces[:c1]} | #{spaces[:c2]} | #{spaces[:c3]} |
      *---+---+---*
    """
  end

  def reset
    @spaces.each { |k, v| @spaces[k] = ' ' }
  end

  def available_spaces
    @spaces.select { |k, v| k if v == ' ' }.keys
  end

  def winning_combos
    [[spaces[:a1], spaces[:a2], spaces[:a3]],
    [spaces[:b1], spaces[:b2], spaces[:b3]],
    [spaces[:c1], spaces[:c2], spaces[:c3]],
    [spaces[:a1], spaces[:b1], spaces[:c1]],
    [spaces[:a2], spaces[:b2], spaces[:c2]],
    [spaces[:a3], spaces[:b3], spaces[:c3]],
    [spaces[:a1], spaces[:b2], spaces[:c3]],
    [spaces[:c1], spaces[:b2], spaces[:a3]]]
  end
end
