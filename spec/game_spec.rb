require_relative '../lib/game'
require_relative 'spec_helper.rb'

describe 'Game' do
  before(:each) do
    @game = Game.new(Board.new, Player.new(token = 'X'), Player.new(token = 'O'))
  end

  describe '#choose_board_size' do
    before do
      def @game.get_input
        "4"
      end
    end
    it 'Allows player to choose board size' do
      @game.choose_board_size
      expect(@game.board.size).to eq(4)
    end
  end
end
