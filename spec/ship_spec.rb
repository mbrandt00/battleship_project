require './lib/ship'


RSpec.describe Ship do
  it 'it is an instance of Ship' do
  cruiser = Ship.new("Cruiser", 3)
  expect(cruiser).to be_instance_of(Ship)
  end
end
