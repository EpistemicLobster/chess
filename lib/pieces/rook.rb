# Creates a rook
class Rook
  def initialize(location, color)
    @location = location
    @color = color
    @utf = color == 'w' ? 9814 : 9820
    @moves = []
  end

  attr_reader :location, :utf, :color
  attr_writer :moves

  MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def move_list
    MOVES
  end
end
