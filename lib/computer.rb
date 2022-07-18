# Creates a computer player
class Computer  
  def initialize(color)
    @name = 'Computer'
    @color = color
  end

  def generate_move
    let = [*'a'..'h']
    num = [*'1'..'8']
    let.sample + num.sample + let.sample + num.sample
  end
end