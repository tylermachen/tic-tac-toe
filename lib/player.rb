class Player
  attr_accessor :token, :wins, :losses, :draws, :character

  def initialize(token = nil)
    @token = token
    @wins = 0
    @losses = 0
    @draws = 0
  end
end
