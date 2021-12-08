require './lib/cell'
require './lib/ship'
require './lib/board'


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


end
