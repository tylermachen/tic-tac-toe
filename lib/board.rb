class Board
  attr_accessor :spaces

  def initialize
    @spaces = {
      a1: @a1 = ' ', a2: @a2 = ' ', a3: @a3 = ' ',
      b1: @b1 = ' ', b2: @b2 = ' ', b3: @b3 = ' ',
      c1: @c1 = ' ', c2: @c2 = ' ', c3: @c3 = ' '
    }
  end

  def print
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
end
