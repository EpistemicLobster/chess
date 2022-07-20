require 'pry-byebug'
require 'yaml'

# interaction with saved_games
module Database
  # set environment to reduce clutter # create directory unless it exists
  def set_environment
    Dir.chdir('saved_games')
  end

  def save
    list = Dir.glob('saved_games/*.yaml')
    choice = confirm(choose_save)
    name = create_name
    File.open(name, 'w') { |file| file.write(YAML.dump(self)) }
    File.delete(list[choice - 1]) if choice > 1
    puts "File '#{name}' successfully saved!"
  end

  def show_saves
    puts ' ::Save Menu::'
    save_list = Dir.glob('saved_games/*.yaml')
    save_list.each_with_index do |e, i|
      file = File.basename(e, '.yaml')
      puts "#{i + 1}. #{file}"
    end
  end

  def choose_save
    show_saves
    save_count = [*1..Dir.glob('saved_games/*.yaml').size]
    print msg = 'Please enter a number from the list shown: '
    choice = verify_input(msg) do |input|
      break input if save_count.include?(input.to_i)
    end
  end

  def create_name
    "saved_games/#{Time.new.strftime('%b_%d_at_%H%M')}.yaml"
  end

  def verify_input(string)
    loop do
      input = gets.chomp
      yield(input)
      show_saves
      print "\nERROR: Invalid entry. \n#{string}"
    end
  end

  def confirm(choice)
    return choice.to_i unless choice > '1'

    print msg = "Confirm overwriting slot #{choice}, type 'Y' or 'N': "
    answer = verify_input(msg) do |input|
      break input.upcase if input.to_s.match(/Y||N/i)
    end
    answer == 'Y' ? choice.to_i : confirm(choose_save)
  end

  def load_game
    input = choose_save
    list = Dir.glob('saved_games/*.yaml')
    # load_count = [*1..list.size]
    from_yaml(list[input.to_i - 1])
  end

  def from_yaml(file)
    File.open(file, 'r') do |loaded|
      YAML.load(loaded,
                aliases: true,
                permitted_classes: [Sample, Player, Symbol,
                                    Bishop, King, Knight,
                                    Queen, Rook, Board, Pawn])
    end
  end
end
