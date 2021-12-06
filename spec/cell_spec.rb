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



end
