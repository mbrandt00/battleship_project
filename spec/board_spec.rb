require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'


RSpec.describe Board do
  before(:each) do
    @cruiser=Ship.new("cruiser", 3)
    @board = Board.new()
    @board.cells
  end

  it 'is an instance of Board' do
    expect(@board).to be_instance_of(Board)
  end

  it 'has a method #cells that will add 16 cells ' do
    expect(@board.cells.keys.length).to eq(16)
  end

  it 'will test for a valid coordinate' do
    expect(@board.valid_coordinate?('A1')).to be(true)
    expect(@board.valid_coordinate?('F7')).to be(false) 
  end


end
