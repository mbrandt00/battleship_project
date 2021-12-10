class Board
  attr_accessor :cells_hash, :rows, :columns

  def initialize(rows = 4, columns = 4)
    @cells_hash = cells_hash
    @rows = rows
    @columns = columns
  end

  def cells
    @cells_hash = {}
    rows_range = "A"..(("A".ord)+ @rows - 1).chr
    columns_range = 1..@columns
    rows_range.each do |letter|
      columns_range.each do |number|
      coordinate = letter + number.to_s
      @cells_hash[coordinate] = Cell.new(coordinate)
      end
    end
    return @cells_hash
  end

  def valid_coordinate?(coordinate)
    @cells_hash.keys.include?(coordinate)
  end

  def consecutive?(array_of_coordinates) #[‘B3’, ‘B4’, ‘B2’]
    coords = array_of_coordinates
      first_element_horizontal = coords[0][0] #letter
      first_element_vertical = coords[0][1] #number
      if coords.all? {|coordinate| first_element_horizontal == coordinate[0]} # consecutive row
        coords = coords.map {|coordinate| coordinate[1].to_i} # convertes [‘A3’, ‘A2’] -> [3,2] [3,4,2]
        sorted_array = coords.sort # converts [3,2] -> [2,3] [2,3,4]
        return (sorted_array.first..sorted_array.last).to_a == coords  #(2..4) = (2,3,4,5).to_a -> [2,3,4,5]
      elsif coords.all? {|coordinate| first_element_vertical == coordinate[1]} #vertical
        return (coords == coords.sort || coords == coords.sort.reverse)
      else
        false
      end
    end

  def valid_placement?(ship, array_of_coordinates)
    return false if ship.length != array_of_coordinates.length
    return false if array_of_coordinates.any? {|coordinate| !valid_coordinate?(coordinate)}
    return false if array_of_coordinates.any? {|coordinate| @cells_hash[coordinate].ship.class == Ship }
    return false if consecutive?(array_of_coordinates) == false
    return true  # if none of these fail, it is true.
  end

  def place(ship, array_of_coordinates)
    array = array_of_coordinates
    if valid_placement?(ship, array_of_coordinates)
      array.each {|coordinate| @cells_hash[coordinate].place_ship(ship)}
      return true
    else
      return false
    end
  end

  def render
    rows_range = "A"..(("A".ord)+ @rows - 1).chr
    columns_range = 1..@columns
    header_row = (columns_range).map{|number| number.to_s}
    return header_row
    # p columns_range.map {|number| number.to_s}
  end

end

# method that adds cells 4x4
# @cells_hash = {'A1' => Cell.new("A1"),
# 'A2' => Cell.new("A2"),
# 'A3' => Cell.new("A3"),
# 'A4' => Cell.new("A4"),
# 'B1' => Cell.new("B1"),
# 'B2' => Cell.new("B2"),
# 'B3' => Cell.new("B3"),
# 'B4' => Cell.new("B4"),
# 'C1' => Cell.new("C1"),
# 'C2' => Cell.new("C2"),
# 'C3' => Cell.new("C3"),
# 'C4' => Cell.new("C4"),
# 'D1' => Cell.new("D1"),
# 'D2' => Cell.new("D2"),
# 'D3' => Cell.new("D3"),
# 'D4' => Cell.new("D4") }
