require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

#contains additional information methods/constants
module Reference
  SET = { 0 => ['b', [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]],
          1 => ['b', [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]],
          6 => ['w', [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]],
          7 => ['w', [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]] }.freeze

  # For board.rb piece creation
  PIECE = { Rook: Rook, Knight: Knight, Bishop: Bishop,
            King: King, Queen: Queen, Pawn: Pawn }.freeze




  MOVES = { Bishop => [[1, 1], [-1, 1], [-1,-1], [1, -1]],
            Rook => [[1, 0], [0, 1], [-1, 0], [0, -1]],
            Queen => [[1, 1], [-1, 1], [-1, -1], [1, -1], [1, 0], [0, 1], [-1, 0], [0, -1]]
  }.freeze
end