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
@direction = "UP"
@cave_height = 8
@top = 5
@bottom
@col
@speed = 0.25

def reset_grid
  @grid = Array.new(@numRows) { Array.new(@numColumns) }
  @display_grid = Array.new(@numColumns) { Array.new(@numRows)}
end

def set_direction
  if (@bottom > 15 || @top > 10) 
    @direction = "UP"
  elsif (@top < 2 )
    @direction = "DOWN"
  end
end

def set_top_and_bottom
  @top = @col.cave_top
  @bottom = @col.cave_bottom
end

def set_grid
  #binding.pry
  @col = Column.new(@top, @cave_height, @direction)
  set_top_and_bottom

  @player_y = @top + 2

  @col.draw
  #binding.pry
  for i in 0..@numRows-1
    #set_direction

    @col = Column.new(@top, @cave_height , @direction)
    set_direction
    set_top_and_bottom
  
    @col.draw
    @grid[i] = @col.column
    
  end 
  #binding.pry;
end

def print_grid
  @grid[@player_x][@player_y] = @player
  @display_grid = @grid.transpose()
  for i in 0..@numColumns-1
    for j in 0..@numRows-1
      print"#{@display_grid[i][j]}"
    end 
    puts
  end 
  puts "Score: #{@score}".magenta
  puts "#{@direction}" 
  puts "Top: #{@top} Bottom: #{@bottom}"
end

def scroll
  #binding.pry
  @grid.pop
  set_top_and_bottom
  @col = Column.new(@top, @cave_height, @direction)
  set_top_and_bottom
  
  @col.draw
  @grid.unshift(@col.column)

  puts `clear`
  move_player_down
  print_grid
  set_direction
end

def check_for_crash
  if (@grid[@player_x][@player_y] == " ".bg_green)
    #binding.pry
    puts "You crashed! - GAME OVER!".red
    puts "Your score was: #{@score}".magenta
    exec 'stty sane'
    exit
    #abort
    return true
  else
    @score = @score + 1
    return false
  end
end

def move_player_up
  @player_y = @player_y - 2
  check_for_crash
end

def move_player_down
  @player_y = @player_y + 1
  check_for_crash
end

reset_grid
set_grid
puts
puts
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

  end
  
  sleep @speed

  scroll
end