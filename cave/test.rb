require 'pry-byebug'
require './string'
require './column'
require 'io/console'
require 'io/wait'

@numRows = 20
@numColumns = 40

@player = " ".bg_red
@player_x = 10
@player_y = 10
@score = 0

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

  col = Column.new(5,5)
  col.draw
  for j in 0..@numRows-1
    #fill_in_column(j)
    col = Column.new(col.cave_top, 5)
    col.draw
    @grid[j] = col.column
  end
  
  
end

def fill_in_column column
  col = Column.new(5,5)
  col.draw
  for i in 0..@numRows-1  
    @grid[i][column] = col.column[i]
  end
end

def print_grid
  #binding.pry

  @grid[@player_x][@player_y] = @player
    for i in 0..@numRows-1
      for j in 0..@numColumns-1
        #binding.pry;
        print"#{@grid[i][j]}"
        #puts "#{i}:#{j}"
      end 
      puts

    end 
    puts "Score: #{@score}".magenta
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
  col = Column.new(5,5)
  col.draw
  @grid.unshift(col.column)
  puts `clear`
  move_player_down
  print_grid
end

def crashed
  if (@grid[@player_x][@player_y] == " ".bg_green)
    puts "You crashed!"
    return true
  else
    @score = @score + 1
    return false
  end
end

def move_player_up
  @player_y = @player_y - 2
  #puts "#{@player_y}"
end

def move_player_down
  @player_y = @player_y + 1
  #puts "#{@player_y}"
end

reset_grid
set_grid
#print_grid
puts
puts
#@grid[1][2] = "X"

#caveColumn(0,3)

print_grid

  term = `stty -g`
  `stty raw -echo cbreak`

  loop do
    `clear`
    if STDIN.ready?
      command = STDIN.getc
      if command == 'q' 
        break
      end
      if command == ' '
        move_player_up
      end
    end
    
    if crashed == true
      system "stty -raw echo"
      break
    end
    
    sleep 0.25
    scroll
    #sleep @speed
    #puts `clear`
    #print_matrix
    
  end

#
#loop do
#  sleep 0.25
#  scroll
#end
