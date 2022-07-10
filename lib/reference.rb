require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

#contains additional information methods/constants
module Reference
  SET = { row_one: [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook],
          row_two: [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn],
          row_seven: [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn],
          row_eight: [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook] }
  def board_graphics(arr)
    arr = arr.map do |e|
      e.map do |f|
        if f[2].empty?
          f[1]
        else
          f[2][0].encode "UTF-8"
        end
      end
    end
  end

  puts <<~GUI
  a b c d e f g h
8 ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ 8
7 ♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟ 7
6 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 6
5 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 5
4 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 4
3 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 3
2 ♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙ 2
1 ♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ 1
  a b c d e f g h
GUI
end