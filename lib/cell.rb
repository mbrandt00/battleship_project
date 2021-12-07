class Cell
  attr_reader :coordinate, :cell_status, :ship

  def initialize (coordinate)
    @coordinate = coordinate
    @ship = ship
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
    if @ship.health == @ship.length
      false
    else
      true
    end
  end
end
