require 'pry-byebug'
require_relative 'modules/database1'
require_relative 'board'
require_relative 'player'


# sample class
class Sample
  include Database

  def initialize(color, truth)
    @color = color
    @truth = truth
    @board = Board.new
    @player = Player.new(1, 'white')
  end
end

sample = Sample.new('white', false)
sample.save
p sample.load_game
# sample.save_game
# binding.pry
# sample.load_game
# p sample = sample.load_game
# p sample.player.color
