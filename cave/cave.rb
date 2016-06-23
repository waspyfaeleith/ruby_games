require 'pry-byebug'
require './string'
require './column'
require 'io/console'
require 'io/wait'

@numRows = 80
@numColumns = 20

#@player = ".".red
@player = '▪'.red
@player_x = 5
@player_y = 5
@score = 0

def reset_grid
  @grid = Array.new(@numRows) { Array.new(@numColumns) }
  @display_grid = Array.new(@numColumns) { Array.new(@numRows)}
end

def set_grid
  col = Column.new(3,5)
  #col = Column.new(10, 10)
  col.draw
  for i in 0..@numRows-1
    col = Column.new(col.cave_top, 5)
    col.draw
    @grid[i] = col.column
  end 
end

def rotate_grid
  #binding.pry
  for i in 0..@numColumns-1
    for j in 0..@numRows-1
      #puts "i: #{i} j:#{j}"
      @display_grid[i][j] = @grid[j][i]
    end
  end
end

def print_grid
  @grid[@player_x][@player_y] = @player
  #rotate_grid
  #binding.pry
  @display_grid = @grid.transpose()
  for i in 0..@numColumns-1
    for j in 0..@numRows-1
      #puts "i: #{i} j:#{j}"
      #print"#{@grid[i][j]}"
      print"#{@display_grid[i][j]}"
    end 
    puts
  end 
  puts "Score: #{@score}".magenta
  #puts "[#{@player_x}][#{@player_y}]"
  #puts "#{@grid[@player_x][@player_y]}"
  #puts "#{@grid[@player_x][@player_y+1]}"
end

def scroll
  #binding.pry;
  @grid.pop
  col = Column.new(3,5)
  col.draw
  @grid.unshift(col.column)
  puts `clear`
  move_player_down
  print_grid
end

def check_for_crash
  if (@grid[@player_x][@player_y] == " ".bg_green)
    #print_grid
    puts "You crashed! - GAME OVER!".red
    puts "Your score was: #{@score}".magenta
    abort
    return true
  else
    @score = @score + 1
    return false
  end
end

def move_player_up
  @player_y = @player_y - 2
  check_for_crash
  #puts "#{@player_y}"
end

def move_player_down
  @player_y = @player_y + 1
  check_for_crash
  #puts "#{@player_y}"
end

reset_grid
set_grid
puts
puts
#rotate_grid
print_grid

#main program
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
    #if crashed == true
    #  system "stty -raw echo"
    #  break
    #end
  end
  
  #if crashed == true
  #  system "stty -raw echo"
  #  break
  #end
  
  sleep 0.25

  scroll
  #if crashed == true
  #  system "stty -raw echo"
  #  break
  #end
end

#
#loop do
#  sleep 0.25
#  scroll
#end
