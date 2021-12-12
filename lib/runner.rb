require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'


class BattleShip
  attr_accessor :board
  def initialize()
    @board = board
  end

  def main_menu
    puts 'Welcome to BATTLESHIP'
    puts "Enter 'p' to play. Enter 'q' to quit."
    input = gets.chomp
    if input.eql? 'p'
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
      board.render()


    elsif input == 'q'
      puts 'goodbye'
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

  def main_game()
    main_menu
    place_custom_ships
    #computer places ship
  end

end

game = BattleShip.new()
game.main_game
