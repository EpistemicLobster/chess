# Creates a rook
class Rook
  def initialize(location, color)
    @location = location
    @utf = color == 'w' ? 9814 : 9820
    @moves = []
    @children = []
  end

  attr_reader :utf
end