require 'io/console'
require 'io/wait'
require 'pry-byebug'

def reset_grid
  @grid = Array.new(20, ".").map{|row| Array.new(40, ".")}
end

key_moves = {"e" => "up", "d" => "down", "o" => "left", "p" => "right", "q" => "quit", "c" => "clear" }

@bugs_and_scores = {"*" => 10, "#" =>5, "?" => -5, ";" => -10, "." => 0, "@" => 0, "X" => 100, "~" => 0, "0" => 0} 

@score = 0
@snake = '@'
@snake_extender="0"
@snake_length = 1
@snake_squares = []
@square_to_reset

def add_bug bug 
  @grid[rand(1..18)][rand(1..38)] = bug
end

def add_bugs
  5.times do
    add_bug "*"
    add_bug "#"
    add_bug "?"
    add_bug ";"
  end
  add_bug "X"
  #add_bug @snake
  add_bug @snake_extender
end

def set_score
  c = @grid[@x][@y]
  @score = @score + @bugs_and_scores[c]
end

def print_matrix
  @grid.each do |row|
    print row.join(" ")
    puts
  end
  puts "Score: #{@score} Snake Length: #{@snake_length}"
  #puts "x : #{@x} y: #{@y}"
end

def game_over?
  puts "You crashed and died - GAME OVER!"
  return false
end

def game_over_cannibal?
  puts "You ate yourself! - GAME OVER!"
  return false
end

def reset_old_square
  @grid[@square_to_reset["x"]][@square_to_reset["y"]] = "."
end

def set_current_square
  sq = { "x" => @x, "y" => @y}
  @snake_squares << sq

  if @grid[@x][@y] == @snake_extender
    @snake_length = @snake_length + 1
    add_bug @snake_extender
    @grid[@x][@y] = @snake
  else
    @square_to_reset = @snake_squares.shift
    @grid[@x][@y] = @snake 
    #@grid[@x][@y] = @snake 
  end
end

#def set_snake_squares
#  @snake_squares.each do |square|
#    print "#{square["x"]} , #{square["y"]}"
# end
#end

def make_move
  #if @grid[@x][@y] == @snake
  #  return game_over_cannibal?
  #end
  set_score
  set_current_square
  reset_old_square
end

def move_up
  if @x == 0
    game_over?
  elsif @x > 0
    @x = @x - 1
    make_move
  end
end

def move_down
  if @x == 19
    game_over?
  elsif @x < 19
    @x = @x + 1
    make_move
  end
end

def move_left
  if @y == 0
    game_over?
  elsif @y > 0
    @y = @y - 1
    make_move
  end
end

def move_right
  if @y == 39
    game_over?
  elsif @y < 39
    @y = @y + 1
    make_move
  end
end

def move_snake? direction
  case direction
    when 'up'
      move_up
    when 'down'
      move_down
    when 'left'
      move_left
    when 'right'
      move_right
    when 'clear'
      reset_grid
      @grid[@x][@y]= @snake
  end
end

@x = 10
@y = 10

reset_grid

sq = { "x" => @x, "y" => @y}
@snake_squares << sq
@grid[@x][@y] = @snake


puts `clear`
add_bugs
print_matrix

term = `stty -g`
`stty raw -echo cbreak`
@direction = ''
loop do
  `clear`
  if STDIN.ready?
    command = STDIN.getc
    if command == 'q' 
      break
    end
    @direction = command
  end
  if key_moves.has_key?(command)
    @direction = command
  end

  if move_snake?(key_moves[@direction]) == false
    break
  end

  sleep 0.2
  puts `clear`
  print_matrix
end

