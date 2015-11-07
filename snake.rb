require 'io/console'
require 'io/wait'
require 'pry-byebug'

def reset_grid
  @grid = Array.new(20, ".").map{|row| Array.new(40, ".")}
end

key_moves = {"e" => "up", "d" => "down", "o" => "left", "p" => "right", "q" => "quit", "c" => "clear" }

@bugs_and_scores = {"*" => 10, "#" =>5, "?" => -5, ";" => -10, "." => 0, "@" => 0, "X" => 100} 

@score = 0
@snake = '~'

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
end

def set_score
  c = @grid[@x][@y]
  @score = @score + @bugs_and_scores[c]
end

def print_matrix
  @grid.each_with_index do |row, i|
    print row.join(" ")
    puts
  end
  puts "Score: #{@score}"
  puts "x : #{@x} y: #{@y}"
end

def game_over?
  puts "You crashed and died - GAME OVER!"
  return false
end

def reset_old_square
  @grid[@x][@y]= '.'
end

def set_current_square
  @grid[@x][@y]= @snake
end

def move_up
  if @x == 0
    game_over?
  elsif @x > 0
    reset_old_square
    @x = @x - 1
    set_score
    set_current_square
  end
end

def move_down
  if @x == 19
    game_over?
  elsif @x < 19
    reset_old_square
    @x = @x + 1
    set_score
    set_current_square
  end
end

def move_left
  if @y == 0
    game_over?
  elsif @y > 0
    reset_old_square
    @y = @y - 1
    set_score
    set_current_square
  end
end

def move_right
  if @y == 39
    game_over?
  elsif @y < 39
    reset_old_square
    @y = @y + 1
    set_score
    set_current_square
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

@grid[@x][@y]= @snake

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

