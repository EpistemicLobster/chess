# saves and loads game functions
require 'pry-byebug'
require 'yaml'
require_relative 'player'
module Database
  # after save_game? yes ==> 
  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    # Dir.chdir('saved_games')
    list = Dir.glob('saved_games/*.yaml')
    slot = choose_save - 1
    time = Time.new.strftime('%b_%d_at_%H%M')
    name = list[slot].include?('<new_save>') ? "#{time}.yaml" : File.basename(list[slot])
    File.open("saved_games/#{name}", 'w') { |f| f.write(YAML.dump(self)) }
    # File.open("saved_games/#{name}", 'w') { |f| f.puts YAML.dump(self) }
    puts 'File successfully saved!'
  end

  def load_game
    show_saves
    print msg = 'please enter a game to load: '
    list = Dir.glob('saved_games/*.yaml')
    input = verify_input(msg) do |input|
      break input.to_i - 1 if input.match?(/[0-9]/) && list[input.to_i - 1]
    end
    saved = File.open(list[input], 'r') { |f| YAML.load(f) }
    p saved
    saved.close
  end

  def to_yaml
    YAML.dump(  {
      'board' => @board,
      'player_one' => @player_one,
      'player_two' => @player_two,
      'current_player' => @current_player,
      'check' => @check,
      'check_mate' => @check_mate
    } )
  end

  def from_yaml(string)
    data = YAML.load string
    p data
  end

  def show_saves
    list = Dir.glob('saved_games/*.yaml')
    File.open('<new_save>.yaml', 'w') unless File.exist? '<new_save>.yaml'
    # return puts '0. <new save>' if list.empty?

    list.each_with_index do |e, i|
      file = File.basename(e, '.yaml')
      puts "#{i + 1}. #{file}"
    end
  end

  def choose_save
    # Dir.chdir('saved_games')
    show_saves
    list = Dir.glob('saved_games/*.yaml')
    print msg = "\nPlease enter a number to choose a slot to save: "
    verify_input(msg) do |inp|
      return confirm(inp) if inp.match?(/[0-9]/) && !list[inp.to_i - 1].nil?
    end
  end

  def confirm(slot)
    list = Dir.glob('saved_games/*.yaml')
    unless list[slot.to_i - 1].include?('<new_save>')
      print message = "Confirm overwriting slot #{slot} (y/n): "
      # result = ->(a) { a.downcase == 'y' ? slot.to_i : choose_save}
      # verify_input(message) { |a| return result.call(a) if a.match?(/y||n/i) }
      result = verify_input(message) { |a| break a if a.match?(/y||n/i) }
      return choose_save if result.downcase == 'n'
    end
    slot.to_i
  end

  def verify_input(string)
    loop do
      input = gets.chomp
      yield(input)
      show_saves
      print "\nERROR: Invalid entry. \n#{string}"
    end
  end

end

class Sample
  include Database
  def initialize
    @board = { a: 'alligator', b: 'butterfly', c: 'cheetah' }
    @player_one = Player.new(1, 'white')
    @player_two = Player.new(2, 'black')
    @current_player = @player_one
    @check = 'peanut'
    @check_mate = 'black'
  end

  attr_reader :check

end

x = Sample.new
x = x.load_game
p x