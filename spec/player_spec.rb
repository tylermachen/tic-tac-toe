require_relative '../lib/player'
require_relative 'spec_helper.rb'

describe 'Player' do
  before(:each) do
    @player = Player.new
  end

  it 'Can update character' do
    @player.character = 'Rick Grimes'
    expect(@player.character).to eq('Rick Grimes')
  end

  it 'Can update token' do
    @player.token = 'O'
    expect(@player.token).to eq('O')
  end

  it 'Can update wins' do
    @player.wins += 1
    expect(@player.wins).to eq(1)
  end

  it 'Can update losses' do
    @player.losses += 1
    expect(@player.losses).to eq(1)
  end

  it 'Can update draws' do
    @player.draws += 1
    expect(@player.draws).to eq(1)
  end
end
