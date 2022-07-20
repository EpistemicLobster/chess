# Creates player 1 and player 2 objects
class Player
  def initialize(name, color)
    @name = "Player #{name}"
    @color = color
  end

  attr_reader :color, :name
end