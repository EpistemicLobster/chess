require 'pry-byebug'
require_relative 'board'
require_relative 'player'
require_relative 'modules/message'
require_relative 'modules/database1'
require_relative 'modules/menu'

# Implement General Game Loop
class Game
  # data base module for save game
  include Message
  include Menu
  include Database
  def initialize
    @board = Board.new
    @player_one = Player.new(1, 'white')
    @player_two = Player.new(2, 'black')
    @current_player = @player_one
    @check = false
    @check_mate = false
    @game_over = false
  end

  def welcome
    welcome_to_chess
    show_menu
  end

  def exit
    puts 'Would you like to save your game? '
    puts "Enter 'Y' to save or 'N' to exit: "
    input = gets.chomp
    input.upcase == 'y' ? save_game : message_goodbye
  end

  def main_loop
    @game_over = false
    loop do
      update_check_status
      break if @game_over

      player_in_check(@current_player) if @check == true
      make_move(play_or_exit)
      @current_player = @current_player == @player_one ? @player_two : @player_one
    end
  end

  def play_or_exit
    @board.display
    message_make_move(@current_player.name)
    input = gets.chomp
    return input unless input == 'exit'

    exit
  end

  def update_check_status
    @check = @board.check?(@current_player.color)
    @check_mate = @board.check_mate?(@current_player.color)
    if (@check && @check_mate) || (!@check && @check_mate)
      @game_over = true
    end
  end

  def make_move(input)
    move = verify(input)
    @board.make_move(move[0], move[1])
  end



  def notation(string)
    coor = string.chars
    l_hash = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
               'f' => 5, 'g' => 6, 'h' => 7 }
    [[8 - coor[1].to_i, l_hash[coor[0]]], [8 - coor[3].to_i, l_hash[coor[2]]]]
  end

  def verify(input)
    a = b = nil
    move = syntax_check(input)
    c = @current_player.color
    loop do
      a = notation(move)[0]
      b = notation(move)[1]
      break if @board.origin?(a, c) && @board.target?(a, b, c)

      move = syntax_check(gets.chomp)
    end
    [a, b]
  end

  # def verify(input)
  #   a = nil
  #   b = nil
  #   c = @current_player.color
  #   loop do
  #     move = syntax_check(gets.chomp)
  #     a = notation(move)[0]
  #     b = notation(move)[1]
  #     break if @board.origin?(a, c) && @board.target?(a, b, c)
  #   end
  #   [a, b]
  # end

  def syntax_check(move)
    until move.match?(/^[a-h][1-8][a-h][1-8]$/)
      puts "Input Error! \n" \
            "Use board notation to denote start & end positions.\n" \
            'Examples: a2b3, h4h3, c1c5... etc: '
      move = gets.chomp
    end
    move
  end
end
