require 'pry-byebug'
require './string'
require './column'

@numRows = 20
@numColumns = 80

@player = " ".bg_red
@player_x = 10
@player_y = 40

def reset_grid
  #@grid = Array.new(@numColumns, ".").map{|row| Array.new(@numRows, ".")}
  @grid = Array.new(@numRows) { Array.new(@numColumns) }
end

def set_grid
#binding.pry;
  #for i in 0..@numRows-1
  #  for j in 0..@numColumns-1
  #    #binding.pry;
  #    @grid[i][j] = "."##{i}:#{j}"
  #    #puts "#{i}:#{j}"
  #  end 
  #end

  col = Column.new(3,5)
  col.draw
  for j in 0..@numRows-1
    #fill_in_column(j)
    col = Column.new(col.cave_top, 5)
    col.draw
    @grid[j] = col.column
  end
  
  
end

def fill_in_column column
  col = Column.new(3,5)
  col.draw
  for i in 0..@numRows-1  
    @grid[i][column] = col.column[i]
  end
end

def print_grid
  #binding.pry;
  @grid[@player_x][@player_y] = @player
    for i in 0..@numRows-1
      for j in 0..@numColumns-1
        #binding.pry;
        print"#{@grid[i][j]}"
        #puts "#{i}:#{j}"
      end 
      puts
    end 
  end

  def caveColumn (columnNum,prevCaveTop)
    caveHeight = 4#rand(8..11);
    @caveTop = prevCaveTop + rand(-1..1)
    @caveBottom = @caveTop + caveHeight
    for i in 0..@caveTop
      @grid[i][columnNum] = " ".bg_green
    end
    for j in @caveBottom..(@numRows-1)
      @grid[j][columnNum]= " ".bg_green
    end
  end

def scroll
  #binding.pry;
  @grid.pop
  col = Column.new(20,5)
  col.draw
  @grid.unshift(col.column)
  puts `clear`
  #set_grid
  print_grid
end

reset_grid
set_grid
#print_grid
puts
puts
#@grid[1][2] = "X"

#caveColumn(0,3)

print_grid

loop do
  sleep 0.5
  scroll
end
