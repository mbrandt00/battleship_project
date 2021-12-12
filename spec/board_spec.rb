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

  it 'will print letters' do
    expect(@board.cells_hash["A1"]).to be_instance_of(Cell)
  end

  it 'is an instance of Board' do
    expect(@board).to be_instance_of(Board)
  end

  it 'has a method #cells that will add expected cells ' do
    expect(@board.cells_hash.keys.length).to eq(@board.rows * @board.columns)
  end

  it 'will test for a valid coordinate' do
    expect(@board.valid_coordinate?('A1')).to be(true)
    expect(@board.valid_coordinate?('F7')).to be(false)
  end

  describe 'consecutive?' do
    it 'will detect if array is consecutive' do
      expect(@board.consecutive?(['A1', 'A2', 'A3'])).to be(true)
      expect(@board.consecutive?(['A1', 'A3', 'A2'])).to be(false)
      expect(@board.consecutive?(['B1', 'A2', 'A3'])).to be(false)
    end

    it 'will make sure coordinates are consecutive for vertical' do
      expect(@board.consecutive?(['A1', 'B1', 'C1'])).to be(true)
    end

    it 'will make sure coordinates are consecutive for vertical in reverse' do
      expect(@board.consecutive?(['C1', 'B1', 'A1'])).to be(true)
    end
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


    it 'will make sure ship is not placed diagonal' do
      expect(@board.valid_placement?(@cruiser, ['A1', 'B2', 'C3'])).to be(false)
      expect(@board.valid_placement?(@submarine, ['C2', 'D3'])).to be(false)
    end

    it 'will make sure vertical ship placements are valid' do
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)
    end
  end

  it 'will place a ship on a passed in array' do
    @board.place(@cruiser, ['A1', 'A2', 'A3'])
    expect(@board.cells_hash['A2'].ship).to eq(@cruiser)
  end

  it 'will evaluate if ship placements are overlapping' do
    @board.place(@cruiser, ["A1", "A2", "A3"])
    expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be(false)
  end


  describe 'render' do
    it 'have the number of keys of the hash be equal to the rows' do
      array = []
      rows_range = ("A"..(("A".ord)+ @board.rows - 1).chr)
      rows_range.each {|letter| array.push letter}
      @board.render
      expect(@board.cell_rendered_hash.keys).to eq(array)
    end
    it 'will print sunk ship' do
    @board.place(@submarine, ['A1', 'A2'])
    @board.cells_hash['A1'].fire_upon
    @board.cells_hash['A2'].fire_upon
    @board.render
    expect(@board.cell_rendered_hash['A']).to eq(['X ', 'X ', '. ', '. '])
    end
    it 'will print misses' do
      @board.place(@submarine, ['A1', 'A2'])
      @board.cells_hash['A3'].fire_upon
      @board.cells_hash['B4'].fire_upon
      @board.render(true)
      expect(@board.cell_rendered_hash['A']).to eq(['S ', 'S ', 'M ', '. '])
      expect(@board.cell_rendered_hash['B']).to eq(['. ', '. ', '. ', 'M '])
    end

    it 'will print hits' do
      @board.place(@submarine, ['A1', 'A2'])
      @board.cells_hash['A1'].fire_upon
      @board.cells_hash['B1'].fire_upon
      @board.render(true)
      expect(@board.cell_rendered_hash['A']).to eq(['H ', 'S ', '. ', '. '])
      expect(@board.cell_rendered_hash['B']).to eq(['M ', '. ', '. ', '. '])
    end
  end
end
