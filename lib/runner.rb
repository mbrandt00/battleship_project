# frozen_string_literal: true

require './lib/cell'
require './lib/ship'
require './lib/board'
# Battleship class permits choices and for a game to be played.
class BattleShip
  attr_accessor :board, :comp_board

  def initialize
    @board = board
    @comp_board = comp_board
  end

  def main_game
    main_menu
    game_type = gets.chomp
    until game_type.upcase == 'D' || game_type.upcase == 'C'
      puts "Enter 'c' for classic, 'd' for dynamic"
      game_type = gets.chomp
    end
    case game_type.upcase
    when 'D'
      dynamic_setup
    when 'C'
      classic_setup
      classic_computer_setup

    end
    place_computer_ships
    system('clear') # only works on macs
    render_both_boards # currently showing both computer ships
    turn until someone_won?
    end_game
    play_again = gets.upcase.chomp
    until %w[Y N].include?(play_again)
      puts 'Enter Y for yes or N for no'
      play_again = gets.upcase.chomp
    end
    case play_again
    when 'Y'
      system('clear')
      main_game
    when 'N'
      p 'Good Bye'
      exit
    end
  end

  def turn
    puts 'Please enter a single cell to fire upon (ex: A1 )'
    selected_cell = gets.upcase.chomp
    until @comp_board.valid_coordinate?(selected_cell) && @comp_board.cells_hash[selected_cell].fired_upon? == false
      puts "Please enter a valid cell which hasn't already been fired upon."
      selected_cell = gets.upcase.chomp
    end
    @comp_board.cells_hash[selected_cell].fire_upon

    random_computer_shot = @board.cells_hash.keys.sample(1).join # join converts ['A1'] -> 'A1'
    until @board.valid_coordinate?(random_computer_shot) && @board.cells_hash[random_computer_shot].fired_upon? == false # this is where it goes wrong
      random_computer_shot = @board.cells_hash.keys.sample(1).join
    end
    @board.cells_hash[random_computer_shot].fire_upon

    system('clear') # only works on macs.
    render_both_boards

    puts "#{selected_cell} was a miss" if @comp_board.cells_hash[selected_cell].cell_state == 'M'
    if @comp_board.cells_hash[selected_cell].cell_state == 'H'
      puts "#{selected_cell} was a hit on the #{@comp_board.cells_hash[selected_cell].ship.name}"
    end
    if @comp_board.cells_hash[selected_cell].cell_state == 'X'
      puts "You sunk their #{@comp_board.cells_hash[selected_cell].ship.name}"
    end
  end

  def end_game
    who_won?
    puts "============= Computer's Board =============="
    @comp_board.render(true) # for now
    puts ' '
    puts '============= Your Board ================'
    @board.render(true)
    p 'Would you like to play again? Y for yes or N for no'
  end

  def someone_won?
    computer_won = @board.custom_ships_array.all?(&:sunk?)
    person_won = @comp_board.custom_ships_array.all?(&:sunk?)
    (computer_won || person_won)
  end

  def who_won?
    computer_won = @board.custom_ships_array.all?(&:sunk?)
    person_won = @comp_board.custom_ships_array.all?(&:sunk?)
    if person_won && computer_won
      puts 'Incredible! A tie!'
    elsif computer_won
      puts 'The computer won!'
    elsif person_won
      puts 'Congratulations you won!'
    end
  end

  def dynamic_setup
    puts 'How many rows would you like for your battleship board?'
    rows = 0
    while rows.zero? || rows > 26
      puts "please enter a number for the board's rows between 0 and 26"
      rows = gets.to_i # if string of letters converts to 0
    end
    puts 'How many columns would you like for your battleship board?'
    columns = 0
    while columns.zero? || columns > 26
      puts "please enter a number for the board's columns between 0 and 26"
      columns = gets.to_i
    end
    @board = Board.new(rows, columns)
    @comp_board = Board.new(rows, columns)
    place_custom_ships
  end

  def classic_setup
    @board = Board.new(4, 4)
    @board.render
    cruiser = Ship.new('cruiser', 3)
    @board.custom_ships_array << cruiser
    puts 'Where would you like to place your 3 cell cruiser? Enter coordinates (seperated by a space without quotes ie: A1 A2 A3)'
    coordinates = gets.upcase.chomp
    array_of_coordinates = coordinates.split(' ')
    until @board.valid_placement?(cruiser, array_of_coordinates) == true
      puts "Make sure coordinates are consecutive, valid, don't already contain another ship, and are the same length as your ship (in this case #{cruiser.length} cells)."
      coordinates = gets.upcase.chomp
      array_of_coordinates = coordinates.split(' ')
    end
    @board.place(cruiser, array_of_coordinates)
    @board.render(true)
    puts 'Where would you like to place your 2 cell submarine? Enter coordinates (seperated by a space without quotes ie: A1 A2)'
    submarine = Ship.new('submarine', 2)
    @board.custom_ships_array << submarine
    coordinates = gets.upcase.chomp
    array_of_coordinates = coordinates.split(' ')
    until @board.valid_placement?(submarine, array_of_coordinates) == true
      puts "Make sure coordinates are consecutive, valid, don\'t already contain another ship, and are the same length as your ship (in this case #{submarine.length} cells)."
      coordinates = gets.upcase.chomp
      array_of_coordinates = coordinates.upcase.split(' ')
      array_of_coordinates = coordinates.split(' ')
    end
    @board.place(submarine, array_of_coordinates)
  end

  def classic_computer_setup
    @comp_board = Board.new
    comp_cruiser = Ship.new("computer's cruiser", 3)
    comp_submarine = Ship.new("computer's submarine", 2)
    @comp_board.custom_ships_array << comp_cruiser
    @comp_board.custom_ships_array << comp_submarine
  end

  def place_computer_ships
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
    puts 'Up to 4 total ships are allowed'
    ship_number = gets.chomp.to_i
    while ship_number <= 0 || ship_number > 4
      puts 'Please enter 1 - 4 of ships'
      ship_number = gets.chomp.to_i
    end
    @board.render(true)
    ship_number.times do |ship|
      puts "What would you like to call ship number #{ship + 1}?"
      ship_name = gets.chomp
      puts 'How long would you like this ship to be?'
      ship_length = gets.chomp.to_i
      until ship_length.positive? && (ship_length < @board.columns || ship_length < @board.rows)
        puts 'Please re - enter a number for the length of the ship which will fit on the board horizontally or vertically'
        ship_length = gets.to_i # if string of letters converts to 0
      end
      ship = Ship.new(ship_name, ship_length)
      comp_ship = Ship.new(ship_name, ship_length)
      @board.custom_ships_array << ship
      @comp_board.custom_ships_array << comp_ship
      puts 'Where would you like to place this ship? Enter coordinates (seperated by a space without quotes ie: A1 A2)'
      coordinates = gets.upcase.chomp
      array_of_coordinates = coordinates.split(' ')
      until @board.valid_placement?(ship, array_of_coordinates) == true
        puts "Make sure coordinates are consecutive, valid, don't already contain another ship, and is the same length as your ship"
        coordinates = gets.upcase.chomp
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
    case input.capitalize
    when 'P'
      puts 'Would you like to play classic battleship (a 4x4 grid with 2 set ships) or a dynamic game with customizable ships and board sizes?'
      puts "Enter 'c' for classic, 'd' for dynamic"
    when 'Q'
      puts 'goodbye'
      exit
    else
      main_menu
    end
  end

  def render_both_boards
    puts '============= Computer\'s Board =============='
    @comp_board.render
    puts ''
    puts '============= Your Board ================'
    @board.render(true)
  end
end

game = BattleShip.new
game.main_game
