# Creates a bishop
class Bishop
  def initialize(location, color)
    @location = location
    @color = color
    @utf = color == 'w' ? 9815 : 9821
    @moves = []
  end

  attr_reader :location, :color, :utf
  attr_writer :moves

  MOVES = [[1, 1], [-1, 1], [-1, -1], [1, -1]].freeze

  def move_list
    MOVES
  end
  
end
