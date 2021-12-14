require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'


class BattleShip
  attr_accessor :board, :comp_board
  def initialize()
    @board = board
    @comp_board = comp_board
  end


  def main_game()
    main_menu
    game_type = gets.chomp
    until (game_type.upcase == 'D' || game_type.upcase== 'C' ) do
      puts "Enter 'c' for classic, 'd' for dynamic"
      game_type = gets.chomp
    end
      if game_type.upcase.eql? 'D'
        dynamic_setup
      elsif game_type.upcase.eql? 'C'
        classic_setup

    end

    place_computer_boards
    system('clear') # only works on macs
    render_both_boards #currently showing both computer ships
    until who_won?
      turn
    end
    end_game
  end

  def turn
    puts "Please enter a single cell to fire upon (ex: A1 )"
    selected_cell = gets.upcase.chomp
    until @comp_board.valid_coordinate?(selected_cell) && @comp_board.cells_hash[selected_cell].fired_upon? == false
      puts "Please enter a valid cell which hasn't already been fired upon."
      selected_cell = gets.upcase.chomp
    end
    # require 'pry';binding.pry
    @comp_board.cells_hash[selected_cell].fire_upon
    @comp_board.custom_ships_array.each do |ship|
      p ship.health
    end
    random_computer_shot = @board.cells_hash.keys.sample(1).join #join converts ['A1'] -> 'A1'
    while @board.cells_hash[random_computer_shot].fired_upon?
      random_computer_shot = @board.cells_hash.keys.sample(1).join
    end #join converts ['A1'] -> 'A1'
    @board.cells_hash[random_computer_shot].fire_upon #smart shot would go here.
    system('clear') #only works on macs.
    render_both_boards
  end




  def end_game
    puts "============= Computer's Board =============="
    @comp_board.render(true) #for now
    puts " "
    puts "============= Your Board ================"
    board.render(true)
  end


  def who_won?
    computer_won = @board.custom_ships_array.all? {|ship| ship.sunk?}
    person_won = @comp_board.custom_ships_array.all? {|ship| ship.sunk?}
    # if computer_won || person_won
    if person_won
      # comput er_won ? 'The computer was cheating with sonar and won' : 'Congratulations! You won!'
    p "I won"
    else
      false
    end
  end


  def dynamic_setup
    puts "How many rows would you like for your battleship board?"
    rows = 0
    while rows== 0 || rows > 26
      puts "please enter a number for the board's rows between 0 and 26"
      rows = gets.to_i #if string of letters converts to 0
    end
    puts "How many columns would you like for your battleship board?"
    columns = 0
    while columns== 0 || columns >26
      puts "please enter a number for the board's columns between 0 and 26"
      columns = gets.to_i
    end
    @board = Board.new(rows, columns)
    @comp_board = Board.new(rows, columns)
    place_custom_ships
  end

  def classic_setup
    @board = Board.new(4,4)
    @comp_board = Board.new()
    @board.render()
    # puts "Where would you like to place your 3 cell cruiser? Enter coordinates (seperated by a space without quotes ie: A1 A2)"
    cruiser = Ship.new('cruiser', 3)
    @comp_board.custom_ships_array << cruiser
    @board.custom_ships_array << cruiser
    # coordinates = gets.chomp
    coordinates = "A1 A2 A3"
    array_of_coordinates = coordinates.split(' ')
      until @board.valid_placement?(cruiser, array_of_coordinates) == true
        puts "Make sure coordinates are consecutive, valid, don't already contain another ship, and are the same length as your ship (in this case #{cruiser.length} cells)."
        coordinates = gets.chomp
        array_of_coordinates = coordinates.split(' ')
      end
    @board.place(cruiser, array_of_coordinates)
    @board.render(true)
    # puts "Where would you like to place your 2 cell submarine? Enter coordinates (seperated by a space without quotes ie: A1 A2)"
    submarine = Ship.new('submarine', 2)
    @comp_board.custom_ships_array << submarine
    @board.custom_ships_array << submarine
    # coordinates = gets.chomp
    coordinates = "D1 D2"
    array_of_coordinates = coordinates.split(' ')
      until @board.valid_placement?(submarine, array_of_coordinates) == true
        puts "Make sure coordinates are consecutive, valid, don't already contain another ship, and are the same length as your ship (in this case #{cruiser.length} cells)."
        coordinates = gets.chomp
        array_of_coordinates = coordinates.upcase.split(' ')
        array_of_coordinates = coordinates.split(' ')
      end
      @board.place(submarine, array_of_coordinates)
  end

  def place_computer_boards
    @comp_board.poss_ship_placements # computer ships
    @comp_board.custom_ships_array.each do |ship|
    random_sample = @comp_board.ship_placements[ship].sample(1).first
      while @comp_board.valid_placement?(ship, random_sample) == false
        random_sample = @comp_board.ship_placements[ship].sample(1).first
      end
    @comp_board.place(ship, random_sample)
    end
  end

  def place_custom_ships
    puts "How many ships would you like to play with on your #{@board.rows} by #{@board.columns} board?"
    puts "Up to 4 total ships are allowed"
    ship_number = gets.chomp.to_i
    while ship_number <= 0 || ship_number > 4
      puts "Please enter 1 - 4 of ships"
      ship_number = gets.chomp.to_i
    end
    ship_number.times do |ship|
         puts "What would you like to call ship number #{ship + 1}?"
         ship_name = gets.chomp
         puts "How long would you like this ship to be?"
         ship_length = 0
         while ship_length <=0
           puts 'please enter a number for the length of the ship'
           ship_length = gets.to_i #if string of letters converts to 0
         end
         ship = Ship.new(ship_name, ship_length)
         @board.custom_ships_array << ship
         @comp_board.custom_ships_array << ship
         puts "Where would you like to place this ship? Enter coordinates (seperated by a space without quotes ie: A1 A2)"
         coordinates = gets.chomp
         array_of_coordinates = coordinates.split(' ')
         until @board.valid_placement?(ship, array_of_coordinates) == true
           puts "Make sure coordinates are consecutive, valid, don't already contain another ship, and is the same length as your ship"
           coordinates = gets.chomp
           array_of_coordinates = coordinates.split(' ')
         end
      @board.place(ship, array_of_coordinates)
      @board.render(true)
    end
  end

  def main_menu
    puts 'Welcome to BATTLESHIP'
    puts "Enter 'p' to play. Enter 'q' to quit."
    input = gets.chomp
    if input.capitalize.eql? 'P'
      puts "Would you like to play classic battleship (a 4x4 grid with 2 set ships) or a dynamic game with customizable ships and board sizes?"
      puts "Enter 'c' for classic, 'd' for dynamic"
    elsif input.capitalize.eql? 'Q'
      puts 'goodbye'
      exit
    else
      main_menu()
    end
    #else
    #  puts "Enter 'p' to play. Enter 'q' to quit."
  end

  def render_both_boards
    puts "============= Computer's Board =============="
    @comp_board.render(true) #for now
    puts " "
    puts "============= Your Board ================"
    @board.render(true)
  end

end

game = BattleShip.new()
game.main_game

# -------- Current Bugs----------------------
# still to do modify ship_length to not exceed board limits
# not fire upon cell that is already fired upon
# sunk? needs fixing. If (2) is fixed it should resolve. Right now sunk? is true if health == 0
# clear for windows?

# --------Ideas-----------

# You sunk ship.name...
# play again?
# Smart computer?
