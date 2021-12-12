require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'


class BattleShip
  def initialize()
  end

  def main_menu
    puts 'Welcome to BATTLESHIP'
    puts "Enter 'p' to play. Enter 'q' to quit."
    input = gets.chomp
    if input.eql? 'p'
      puts 'What dimensions would you like the board to be? Enter a number'
      puts 'rows: '
      rows = gets.chomp.to_i
      puts 'columns: '
      columns = gets.chomp.to_i
      board = Board.new(rows, columns)
      board.render()


    elsif input == 'q'
      puts 'goodbye'
    #else
    #  puts "Enter 'p' to play. Enter 'q' to quit."
    end
  end



end

game = BattleShip.new()
game.main_menu
