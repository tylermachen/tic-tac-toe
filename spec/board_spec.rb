require_relative '../lib/board'
require_relative 'spec_helper.rb'

describe 'Board' do
  before(:each) do
    @board = Board.new
  end

  it 'Builds itself based on a 3x3 grid when instantiated' do
    expect(@board.spaces.flatten.length).to eq(9)
  end

  it 'Can update it\'s board size' do
    @board.size = 5
    @board.spaces = @board.build
    expect(@board.spaces.flatten.length).to eq(25)
  end

  it 'Can reset itself' do
    @board.spaces = [['X','O',3],[4,5,'X'],['O','O','X']]
    @board.reset
    expect(@board.spaces).to eq([[1,2,3],[4,5,6],[7,8,9]])
  end

  it 'Knows which spaces it has left' do
    @board.spaces = [['X','O',3],[4,5,'X'],['O','O','X']]
    expect(@board.available_spaces).to eq([[3],[4,5],[]])
  end

  it 'Knows if it has a horizontal win combination' do
    @board.spaces = [['O',2,3],['X','O','X'],['O','O','O']]
    expect(@board.horizontal_win?).to eq('O')
  end

  it 'Knows if it does not have a horizontal win combination' do
    @board.spaces = [['O',2,3],['X','O','X'],['O','X','O']]
    expect(@board.horizontal_win?).to eq(false)
  end

  it 'Knows if it has a vertical win combination' do
    @board.spaces = [['X',2,3],['X','O','X'],['X','X','O']]
    expect(@board.vertical_win?).to eq('X')
  end

  it 'Knows if it does not have a vertical win combination' do
    @board.spaces = [['O',2,3],['X','O','X'],['O','X','O']]
    expect(@board.vertical_win?).to eq(false)
  end

  it 'Knows if it has a left-top-diagonal win combination' do
    @board.spaces = [['O',2,3],['X','O','X'],['X','O','O']]
    expect(@board.left_top_diagonal_win?).to eq('O')
  end

  it 'Knows if it does not have a left-top-diagonal win combination' do
    @board.spaces = [['O',2,3],['X','O','X'],['O','X','X']]
    expect(@board.left_top_diagonal_win?).to eq(false)
  end

  it 'Knows if it has a left-bottom-diagonal win combination' do
    @board.spaces = [['O',2,'X'],[4,'X','X'],['X','O','X']]
    expect(@board.left_bottom_diagonal_win?).to eq('X')
  end

  it 'Knows if it does not have a left-bottom-diagonal win combination' do
    @board.spaces = [['O',2,3],['X','O','X'],['O','X','X']]
    expect(@board.left_bottom_diagonal_win?).to eq(false)
  end
end
