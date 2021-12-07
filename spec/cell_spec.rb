require './lib/cell'
require './lib/ship'


RSpec.describe Cell do
  before(:each) do
    @cruiser=Ship.new("cruiser", 3)
    @cell = Cell.new("B4")
  end

  it 'creates coordinate' do
    expect(@cell).to be_instance_of(Cell)
  end

  it 'reads coordinate of cell' do
    expect(@cell.coordinate).to eq("B4")
  end

  describe 'Ship' do
    it 'will return if there is a ship object on it' do
      expect(@cell.ship).to be(nil)
    end
    it 'will return false if there is a ship on it' do
    @cell.place_ship(@cruiser)
    expect(@cell.empty?).to be(false)
    end
  end

    it 'will return boolean if cell is empty' do
      expect(@cell.empty?).to be(true)
    end

    it 'will return ship object if placed in cell' do
      expect(@cell.place_ship(@cruiser)).to eq(@cruiser)
    end

    it 'will return if the ship has been fired upon' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false)
    end


end
