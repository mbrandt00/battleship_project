require './lib/ship'


RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end
  it 'it is an instance of Ship' do
  expect(@cruiser).to be_instance_of(Ship)
  end

  it 'has a name' do
    expect(@cruiser.name).to eq('Cruiser')
  end

  it 'has a length' do
    expect(@cruiser.length).to eq(3)
  end

  it 'has health' do
    expect(@cruiser.health).to eq(3)
  end

  it 'will return if ship is sunk' do
    expect(@cruiser.sunk?).to be(false)
  end 



end
