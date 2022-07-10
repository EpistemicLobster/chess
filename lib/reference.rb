require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

#contains additional information methods/constants
module Reference
  SET = { 7 => ['b', [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]],
          6 => ['b', [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]],
          1 => ['w', [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]],
          0 => ['w', [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]] }

end