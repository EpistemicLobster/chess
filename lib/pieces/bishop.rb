# Creates a bishop
class Bishop
  def initialize(location, color)
    @location = location
    @utf = color == 'w' ? 9815 : 9821
    @moves = []
    @children = []
  end
end