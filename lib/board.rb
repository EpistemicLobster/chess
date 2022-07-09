# creates a chess board, with methods to display
class Board
  def initialize
    @reference = Array.new(8) { |o| Array.new(8) { |i| "#{o}, #{i}"}}
  end

  def display
    puts <<~GUI
      a b c d e f g h
    8 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 8
    7 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 7
    6 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 6
    5 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 5
    4 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 4
    3 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 3
    2 ♢ ♦ ♢ ♦ ♢ ♦ ♢ ♦ 2
    1 ♦ ♢ ♦ ♢ ♦ ♢ ♦ ♢ 1
      a b c d e f g h
    GUI
  end

  # human to computer chess notation
  def notation(letter, number)
    l_hash = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
               'f' => 5, 'g' => 6, 'h' => 7 }
    @reference[8 - number][l_hash[letter]]
  end
end

hello = Board.new
p hello.notation('d', 8)