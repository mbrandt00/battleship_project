class Cell
  attr_reader :coordinate
  attr_accessor :ship, :cell_state, :cell_fired_on

  def initialize (coordinate)
    @coordinate = coordinate
    @ship = ship
    @cell_state = '.'
    @cell_fired_on = false 
  end

  def ship
    @ship
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @cell_fired_on
  end

  def fire_upon
    @cell_fired_on = true
    if !empty?
      @ship.hit
    end
  end



  def render
    if empty? && fired_upon?
      @cell_state = 'M'
    elsif empty? == false && fired_upon? && @ship.sunk != true
      @cell_state == 'H'
    elsif sunk?
      @cell_state == 'X'
    end
  end
end
