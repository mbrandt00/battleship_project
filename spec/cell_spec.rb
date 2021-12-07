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
    xit 'will return true if there is a ship on it' do
    # fill in once we have #place_ship method.
    end
  end

    it 'will return boolean if cell is empty' do
      expect(@cell.empty?).to be(true)
    end 


end
