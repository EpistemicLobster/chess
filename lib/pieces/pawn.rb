require 'pry-byebug'

# Creates a chess pawn
class Pawn
  def initialize(color)
    @color = color
    @utf = color == 'white' ? 9817 : 9823
    @moves = []
  end

  attr_accessor :color, :utf, :moves, :move_types

  # change symbols to strings?
  MOVES = { 'black' => { first: [[1, 0], [2, 0]], norm: [[1, 0]],
                         capture: [[1, 1], [1, -1]] },
            'white' => { first: [[-1, 0], [-2, 0]], norm: [[-1, 0]],
                         capture: [[-1, -1], [-1, 1]] } }.freeze

  def generate_moves(origin, atlas)
    move_list = determine_move_list(origin)
    sum_move = proc { |x, y| [x[0] + y[0], x[1] + y[1]] }
    @moves = add_standard_moves(move_list, sum_move, origin, atlas)
    add_capture_moves(sum_move, origin, atlas)
  end

  def determine_move_list(origin)
    # identifies whether piece is at starting row
    # binding.pry
    if [6, 1].include?(origin[0])
      MOVES.dig(@color, :first).dup
    else
      MOVES.dig(@color, :norm).dup
    end
  end

  # adds valid normal moves
  def add_standard_moves(move_list, sum_move, origin, atlas)
    norm = []
    move_list.each do |move|
      curr = sum_move.call(origin, move)
      norm << curr unless atlas[curr].key?(:piece)
    end
    norm
  end

  # adds valid capture moves
  def add_capture_moves(sum_move, origin, atlas)
    MOVES.dig(@color, :capture).each do |move|
      curr = sum_move.call(origin, move)
      @moves << curr if curr.all? { |coor| coor.between?(0, 7) } &&
                        atlas.dig(curr, :piece) &&
                        atlas.dig(curr, :piece).color != color
    end
  end
end
