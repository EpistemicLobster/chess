# creates parent class for generic chess piece
class GenericPiece
  def initialize(color)
    @color = color
    @utf = determine_utf
    @moves = []
  end

  attr_reader :color, :utf, :moves

  UTF = { 'Rook' => [9814, 9820], 'Knight' => [9816, 9822], 
          'Bishop' => [9815, 9821], 'Queen' => [9813, 9819],
          'King' => [9812, 9818], 'Pawn' => [9817, 9823] }.freeze

  def determine_utf
    @color == 'white' ? UTF[self.class.to_s][0] : UTF[self.class.to_s][1]
  end

  def calculate_position(origin, move)
    [origin[0] + move[0], origin[1] + move[1]]
  end

  def generate_moves(origin, atlas)
    @moves = []
    determine_standard_moves(origin, atlas)
    determine_capture_moves(origin, atlas)
  end

  def determine_standard_moves(origin, _atlas)
    self.class::MOVES.each do |move|
      curr = calculate_position(origin, move)
      @moves << curr if curr.all? { |coor| coor.between?(0, 7) }
    end
  end

  def determine_capture_moves(_origin, atlas)
    @moves.keep_if do |move|
      if atlas.dig(move, :piece).nil?
        true
      else
        atlas.dig(move, :piece).color != color
      end
    end
  end
end
