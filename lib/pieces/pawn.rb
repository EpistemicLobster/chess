require 'pry-byebug'
require_relative 'generic_piece'
# Creates a chess pawn
class Pawn < GenericPiece
  def initialize(color)
    super
    @options = nil
  end
  # change symbols to strings?
  MOVES = { 'black' => { first: [[1, 0], [2, 0]], norm: [[1, 0]],
                         capture: [[1, 1], [1, -1]] },
            'white' => { first: [[-1, 0], [-2, 0]], norm: [[-1, 0]],
                         capture: [[-1, -1], [-1, 1]] } }.freeze

  def generate_moves(origin, atlas)
    determine_move_list(origin[0])
    super
  end

  def determine_move_list(origin)
    return @options = MOVES.dig(@color, :first).dup if [6, 1].include?(origin)

    @options = MOVES.dig(@color, :norm).dup
  end

  # adds valid normal moves
  def determine_standard_moves(origin, atlas)
    norm = []
    @options.each do |move|
      curr = calculate_position(origin, move)
      norm << curr unless atlas[curr].key?(:piece)
    end
    @moves = norm
  end

  # adds valid capture moves
  def determine_capture_moves(origin, atlas)
    MOVES.dig(@color, :capture).each do |move|
      curr = calculate_position(origin, move)
      @moves << curr if curr.all? { |coor| coor.between?(0, 7) } &&
                        atlas.dig(curr, :piece) &&
                        atlas.dig(curr, :piece).color != color
    end
  end
end
