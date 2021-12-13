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
      puts "How many rows would you like for your battleship board?"
      rows = 0
      while rows <=0
        puts "please enter a number for the board's rows"
        rows = gets.to_i #if string of letters converts to 0
      end
      puts "How many columns would you like for your battleship board?"
      columns = 0
      while columns <= 0
        puts "please enter a number for the board's columns"
        columns = gets.to_i
      end
      @board = Board.new(rows, columns)
      @comp_board = @board.clone

      puts "============= Computer's Board =============="
      @comp_board.render()
      puts " "
      puts "============= Your Board ================"
      board.render()

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
      # puts "What would you like to call the #{ship + 1} ship?"
      puts "What would you like to call this ship?"
      ship_name = gets.chomp
      puts "How long would you like this ship to be?"
      ship_length = 0
        # while ship_length <=0
        while ship_length <=0 || (ship_length >= (@board.rows + 1) && ship_length >= (@board.columns + 1))
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
          puts "Make sure coordinates are consecutive, valid, don't already contain another ship, and are the same length as your ship"
          coordinates = gets.chomp
          # array_of_coordinates = coordinates.upcase.split(' ')
          array_of_coordinates = coordinates.split(' ')
        end
        @board.place(ship, array_of_coordinates)

        @comp_start = @comp_board.cells_hash.to_a.sample(1)
        binding.pry
        until (@comp_start[0][0][1].to_i + ship_length) <= @board.columns || ship_length <= ((("A".ord) + @rows -1) - (@comp_start[0][0][0].to_i))
          @comp_start = @comp_board.cells_hash.to_a.sample(1)
      binding.pry
        end
        @board.render(true)
      end
  end

  def main_game()
    main_menu
    place_custom_ships
    #computer places ship
  end
end

game = BattleShip.new()
game.main_game
