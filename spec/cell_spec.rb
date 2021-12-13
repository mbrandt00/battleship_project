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

    it 'cell being fired upon will lower health of ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false) # make sure it is initially not fired upon
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
      expect(@cell.ship.health).to eq(2)
    end

    describe 'render' do
      it "'is initialized to be '.'" do
        expect(@cell.render).to eq('.')
      end
      it "changes the status to miss if fired upon and cell does not contain ship" do
        @cell.fire_upon
        expect(@cell.empty?).to be(true) #passes
        expect(@cell.fired_upon?).to be(true)
        expect(@cell.render).to eq('M')
      end
      it 'will recognize a hit' do
        @cell.place_ship(@cruiser)
        @cell.fire_upon
        @cell.render
        expect(@cell.empty?).to eq(false)
        expect(@cruiser.sunk?).to eq(false)
        expect(@cell.render).to eq('H')
      end
      it 'will recognize where a ship is placed even if it has not been fired upon' do
        @cell.place_ship(@cruiser)

        expect(@cell.empty?).to eq(false)
        expect(@cell.render(true)).to eq('S')
      end
      it 'will recognize if a ship is sunk' do
        @cell.place_ship(@cruiser)
        @cell.fire_upon
        @cruiser.hit
        @cruiser.hit
        expect(@cell.empty?).to eq(false)
        expect(@cruiser.sunk?).to eq(true)
        expect(@cell.render). to eq('X')
      end

      it 'will take an argument to see if it should render ships' do
        @cell.place_ship(@cruiser)
        expect(@cell.render). to eq('.')
      end

    end



end
