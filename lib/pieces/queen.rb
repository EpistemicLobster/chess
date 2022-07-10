# Creates a queen
class Queen
  def initialize(location, color)
    @location = location
    @utf = color == 'w' ? 9813 : 9819
    @moves = []
    @children = []
  end

  attr_reader :utf
end