class Player
  def initialize(name, color)
    @name = "Player #{name}"
    @color = color
  end

  attr_reader :color 
end