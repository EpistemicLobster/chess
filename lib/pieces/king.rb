# Creates a king
class King
  def initialize(location, color)
    @location = location
    @utf = color == 'w' ? 9812 : 9818
    @moves = []
    @children = []
  end

  attr_reader :utf
end