# Creates a knight
class Knight
  def initialize(location, color)
    @location = location
    @utf = color == 'w' ? 9816 : 9822
    @moves = []
    @children = []
  end
end