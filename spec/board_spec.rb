require './lib/cell'
require './lib/ship'
require './lib/board'
require 'pry'


RSpec.describe Board do
  before(:each) do
    @cruiser=Ship.new("Cruiser", 3)
    @submarine = Ship.new('Submarine', 2)
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

  it 'will detect if array is consecutive' do
    expect(@board.consecutive?(['A1', 'A2', 'A3'])).to be(true)
    expect(@board.consecutive?(['A1', 'A3', 'A2'])).to be(false)
    expect(@board.consecutive?(['B1', 'A2', 'A3'])).to be(false)
  end

  describe 'placement' do
    it 'will test if ship can be placed with regard for consecutive elements' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'A2', 'A3'])).to be(true)
      expect(@board.valid_placement?(@cruiser, ['A2', 'A3', 'A1'])).to be(false)
    end

    it 'will make sure the cells are valid cells on the board' do
      expect(@board.valid_placement?(@cruiser, ['A3', 'A4', 'A5'])).to be(false)
      expect(@board.valid_placement?(@cruiser, ['A2', 'A3', 'A4'])).to be(true)
    end

    it 'will make sure ship will fit in array' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'A2'])).to be(false)
      expect(@board.valid_placement?(@submarine, ['A1', 'A2'])).to be(true)
    end

    it 'will make sure coordinates are consecutive for vertical' do
      # binding.pry
      expect(@board.consecutive?(['A1', 'B1', 'C1'])).to be(true)
    end

    it 'will make sure coordinates are consecutive for vertical in reverse' do
      # binding.pry
      expect(@board.consecutive?(['C1', 'B1', 'A1'])).to be(true)
    end

    it 'will make sure ship is not placed diagonal' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'B2', 'C3'])).to be(false)
      expect(@board.valid_placement?(@submarine, ['C2', 'D3'])).to be(false)
    end
  end







end
