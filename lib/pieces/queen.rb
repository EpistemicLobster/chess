# Creates a queen
class Queen
  def initialize(location, color)
    @location = location
    @color = color
    @utf = color == 'w' ? 9813 : 9819
    @moves = []
  end

  attr_reader :location, :color, :utf
  attr_writer :moves

  MOVES = [[1, 1], [-1, 1], [-1, -1], [1, -1], [1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def move_list
    MOVES
  end
  
end