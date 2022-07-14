class Player
  def initialize(name, color)
    @name = "Player #{name}"
    @color = color
    @move = nil
  end

  attr_reader :color
end