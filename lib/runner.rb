require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'


class BattleShip
  attr_accessor :board, :comp_start
  def initialize()
    @board = board
    @comp_start = comp_start
  end

  def main_menu
    puts 'Welcome to BATTLESHIP'
    puts "Enter 'p' to play. Enter 'q' to quit."
    input = gets.chomp
    if input.capitalize.eql? 'P'
      puts 'Initializing Game!'
    elsif input.capitalize.eql? 'Q'
      puts 'goodbye'
      exit
    else
      main_menu()
    end
    #else
    #  puts "Enter 'p' to play. Enter 'q' to quit."
  end

  def place_custom_ships
    puts "How many ships would you like to play with on your #{@board.rows} by #{@board.columns} board?"
    ship_number = gets.chomp.to_i
    ship_number.times do |ship|
         puts "What would you like to call the #{ship + 1} ship?"
         ship_name = gets.chomp
         puts "How long would you like this ship to be?"
         ship_length = 0
         while ship_length <=0
           puts 'please enter a number for the length of the ship'
           ship_length = gets.to_i #if string of letters converts to 0
         end
         ship = Ship.new(ship_name, ship_length)
         @board.custom_ships_array << ship
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

  def render_both_boards
    puts "============= Computer's Board =============="
    @comp_board.render()
    puts " "
    puts "============= Your Board ================"
    board.render(true)
    place_custom_ships
  end

  def main_game()
    main_menu
    puts "Would you like to play classic battleship (4x4 grid) with 2 ships or a dynamic game with customizable ships and board sizes?"
    puts "Enter 'c' for classic, 'd' for dynamic"
    game_type = gets.chomp
    until (game_type.upcase == 'D' || game_type.upcase== 'C' ) do
      puts "Enter 'c' for classic, 'd' for dynamic"
      game_type = gets.chomp
    end
      if game_type.upcase.eql? 'D'
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
        @comp_board = @board.clone
        place_custom_ships
      elsif game_type.upcase.eql? 'C'
        @board = Board.new(4,4)
        @comp_board = @board.clone
        @board.render()
        puts "Where would you like to place your 3 cell cruiser? Enter coordinates (seperated by a space without quotes ie: A1 A2)"
        cruiser = Ship.new('cruiser', 3)
        coordinates = gets.chomp
        array_of_coordinates = coordinates.split(' ')
          until @board.valid_placement?(cruiser, array_of_coordinates) == true
            puts "Make sure coordinates are consecutive, valid, don't already contain another ship, and are the same length as your ship (in this case #{cruiser.length} cells)."
            coordinates = gets.chomp
            # array_of_coordinates = coordinates.upcase.split(' ')
            array_of_coordinates = coordinates.split(' ')
        end
      @board.place(cruiser, array_of_coordinates)
      @board.render(true)


      puts "Where would you like to place your 2 cell submarine? Enter coordinates (seperated by a space without quotes ie: A1 A2)"
      submarine = Ship.new('submarine', 2)
      coordinates = gets.chomp
      array_of_coordinates = coordinates.split(' ')
        until @board.valid_placement?(submarine, array_of_coordinates) == true
          puts "Make sure coordinates are consecutive, valid, don't already contain another ship, and are the same length as your ship (in this case #{cruiser.length} cells)."
          coordinates = gets.chomp
          # array_of_coordinates = coordinates.upcase.split(' ')
          array_of_coordinates = coordinates.split(' ')
      end
      @board.place(submarine, array_of_coordinates)
      @board.render(true)
    end
    render_both_boards
    #computer places ship
  end
end

game = BattleShip.new()
game.main_game
