Dir[File.join(__dir__, "../lib", "*.rb")].each { |f| require f }
require 'pry'

Game.new(Board.new, Player.new(token = 'X'), Player.new(token = 'O')).play
