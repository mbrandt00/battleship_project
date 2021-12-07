class Cell
  attr_reader :coordinate, :cell_status

  def initialize (coordinate)
    @coordinate = coordinate
    @ship = @ship
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


end
