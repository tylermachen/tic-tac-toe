class Computer
  attr_reader :piece

  def initialize(piece = 'O')
    @piece = piece
  end
end
