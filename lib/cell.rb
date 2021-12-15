class Cell
  attr_reader :coordinate
  attr_accessor :ship, :cell_state, :cell_fired_on

  def initialize (coordinate)
    @coordinate = coordinate
    @ship = nil
    @cell_fired_on = false
    @cell_state = '.'
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
  end

  def render(argument = nil)

    if empty? && fired_upon?
      @cell_state = 'M'
    elsif fired_upon? && !@ship.sunk?
      @cell_state = 'H'
    elsif fired_upon? && @ship.sunk?
      @cell_state = 'X'
    elsif !fired_upon? && !empty? && argument == true
      @cell_state = 'S'
    elsif empty? && !fired_upon?
      @cell_state = '.'
    end
    return @cell_state
  end

end
