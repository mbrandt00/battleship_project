class Board

  attr_accessor :cells_hash, :rows, :columns, :rows_range, :cell_rendered_hash, :columns_range, :custom_ships_array


  def initialize(rows = 4, columns = 4)
    @cells_hash = cells_hash
    @rows = rows
    @columns = columns
    @cell_rendered_hash = cell_rendered_hash
    @cells_hash = cells_hash
    self.cells #initializes cells when instance is created
    @custom_ships_array = []
  end

  def cells
    @cells_hash = {}

    @rows_range = "A"..(("A".ord)+ @rows - 1).chr
    @columns_range = 1..@columns
    @rows_range.each do |letter|
      @columns_range.each do |number|

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

  def render_header
    header_row = (@columns_range).map {|number| number}
    array = []
    until array.length == header_row.length
      header_row.each do |number|
        if number < 10
          array.push (' ' + number.to_s + ' ')
        elsif number >= 10
          array.push(' ' + number.to_s + ' ')
        end
      end
    end
    array = array.join('')
    array = array.insert(0, "  ")
    return array
  end


  def render(argument = nil)
  @cell_rendered_hash = Hash.new {|h,k| h[k] = []} #reset hash
    @rows_range.each do |row|
      @cells_hash.each do |key, value|
        if key[0] == row
          if @cell_rendered_hash[row].length < 10
          @cell_rendered_hash[row] << (' ' + value.render(argument) + ' ') #3 character element
          elsif @cell_rendered_hash[row].length >= 10
            @cell_rendered_hash[row] << '  ' + (value.render(argument)) + ' ' #3 character element
          end
        end
      end
    end
    puts render_header
  @cell_rendered_hash.each {|k,v| puts "#{k} #{v.join('')}"}
  end
end
