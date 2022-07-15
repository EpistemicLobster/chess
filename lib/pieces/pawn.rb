require 'pry-byebug'

# Creates a chess pawn
class Pawn
  def initialize(color)
    @color = color
    @utf = color == 'w' ? 9817 : 9823
    @move_types = nil
    @moves = []
  end

  attr_accessor :color, :utf, :moves, :move_types

  BLACK = { norm: [[1, 0], [2, 0]], capture: [[1, 1], [1, -1]] }.freeze
  WHITE = { norm: [[-1, 0], [-2, 0]], capture: [[-1, -1], [-1, 1]] }.freeze

  def generate_moves(origin, atlas)
    # binding.pry unless atlas[[5, 2]][:piece].nil? && color == 'b'
    @move_types = hereditary_moves(origin)
    @moves = norm_moves(origin, atlas)
    capture_moves(@move_types[:capture], origin, atlas)
    self
  end

  # identifies correct move_types for position and color
  def hereditary_moves(origin)
    white = WHITE.dup
    black = BLACK.dup
    case @utf
    when 9817
      origin[0] == 6 ? white : white[:norm].pop
      white
    when 9823
      origin[0] == 1 ? black : black[:norm].pop
      black
    end
  end

  # adds valid normal moves
  def norm_moves(origin, atlas)
    # binding.pry unless atlas[[4, 0]][:piece].nil? && color == 'b'
    norm = []
    @move_types[:norm].each do |move|
      curr = [origin[0] + move[0], origin[1] + move[1]]
      # binding.pry if curr == [3, 5]
      norm << curr unless atlas[curr].key?(:piece)
    end
    norm
  end

  # adds valid capture moves
  def capture_moves(capture, origin, atlas)
    capture.each do |move|
      # binding.pry unless atlas[[4, 0]][:piece].nil? && color == 'b'
      curr = [origin[0] + move[0], origin[1] + move[1]]
      if curr.all? { |coor| coor.between?(0, 7) }
        if atlas.dig(curr, :piece).nil?
          move
        elsif atlas.dig(curr, :piece).color != color
          @moves << curr
        end
      end
    end
  end
end
