Dir[File.join(__dir__, "../lib", "*.rb")].each { |f| require f }
require 'pry'

Game.new(Board.new, Human.new, Computer.new).play
