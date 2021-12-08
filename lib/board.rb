class Board
  def initialize()
  end

  def cells # method that adds cells 4x4
    {'A1' => Cell.new("A1"),
    'A2' => Cell.new("A2"),
    'A3' => Cell.new("A3"),
    'A4' => Cell.new("A4"),
    'B1' => Cell.new("B1"),
    'B2' => Cell.new("B2"),
    'B3' => Cell.new("B3"),
    'B4' => Cell.new("B4"),
    'C1' => Cell.new("C1"),
    'C2' => Cell.new("C2"),
    'C3' => Cell.new("C3"),
    'C4' => Cell.new("C4"),
    'D1' => Cell.new("D1"),
    'D2' => Cell.new("D2"),
    'D3' => Cell.new("D3"),
    'D4' => Cell.new("D4") }
  end

  def valid_coordinate?(coordinate)
    cells.any? {|key, value| key == coordinate}
  end

  def consecutive?(array_of_coordinates)
    first_element = array_of_coordinates[0][0]
    if array_of_coordinates.all? {|coordinate| first_element == coordinate[0]} #horizontal check
      array_of_coordinates.map! {|coordinate| coordinate[1].to_i}
      sorted_array = array_of_coordinates.sort
      return (sorted_array.first..sorted_array.last).to_a == array_of_coordinates
    # elsif #vertical check?
    else
      false
    end
  end



  def valid_placement?(ship, array_of_coordinates)
    if ( array_of_coordinates.all? { |coordinate| self.valid_coordinate?(coordinate) } &&
      ship.length <= array_of_coordinates.length &&
    consecutive?(array_of_coordinates))
      true
    else
      false
    end
  end

end
