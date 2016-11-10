require 'io/console'
require 'io/wait'
require ('./string')
#require 'pry-byebug'

@numRows = 20
@numColumns = 60

def reset_grid
  @grid = Array.new(@numRows, " ").map{|row| Array.new(@numColumns, " ")}
end

@key_moves = {"e" => "up", "d" => "down", "o" => "left", "p" => "right", "q" => "quit", "c" => "clear" }

@bugs_and_scores = {"*".green => 10, "#".cyan =>5, "?".brown => -5, ";".magenta => -10, "." => 0, "@" => 0, "X".blue => 100, "~" => 0, "0" => 0,"O".red => 0, " " => 0, " ".bg_red => 0} 

@skill_levels = {"1" => 0.3, "2" => 0.2, "3" => 0.1, "4" => 0.05}

def reset
  @score = 0
  @snake = " ".bg_green
  @snake_extender=" ".bg_red
  @snake_length = 1
  @snake_squares = []
  @square_to_reset
  @previous_direction = ''
  @speed
end

def add_bug bug 
  squareX = rand(1..@numRows-3)
  squareY = rand(1..@numColumns-3)
  if @grid[squareX][squareY] != @snake
    @grid[squareX][squareY] = bug
  else
    add_bug bug
  end
end

def add_bugs
  5.times do
    add_bug "*".green
    add_bug "#".cyan
    add_bug "?".brown
    add_bug ";".magenta
  end
  add_bug "X".blue
  add_bug @snake_extender
end

def set_score
  c = @grid[@x][@y]
  @score = @score + @bugs_and_scores[c]
end

def print_matrix
  #binding.pry;
  @grid[0].each do|column|
    print " ".bg_gray
  end
  print "  ".bg_gray
  puts
  @grid.each do |row|
    print " ".bg_gray
    print row.join("")
    print " ".bg_gray
    puts
  end
  @grid[19].each do|column|
    print " ".bg_gray
  end
  print "  ".bg_gray
  puts
  puts "Score: #{@score} Snake Length: #{@snake_length}"
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
  @grid[@square_to_reset["x"]][@square_to_reset["y"]] = " "
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
  end
end

def make_move
  if @grid[@x][@y] == @snake && @snake_length > 1
    return game_over_cannibal?
  end
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
  if @x == (@numRows - 1)
    game_over?
  elsif @x < (@numRows - 1)
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
  if @y == (@numColumns - 1)
    game_over?
  elsif @y < (@numColumns - 1)
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

def welcome
  puts `clear`
  puts "              /^\\/^\\".green
  puts "            _|__|  ".green + "O".cyan + "|".green
  puts "   \\/".red + "     /~     \\_/ \\".green
  puts "    \\____".red + "|__________/  \\".green
  puts "        \\_______      \\".green
  puts "                `\\     \\                  \\".green
  puts "                  |     |                   \\".green
  puts "                 /      /                    \\   ".green
  puts "                /     /                       \\".green
  puts "              /      /                         \\\\".green
  puts "             /     /                            \\ \\".green
  puts "           /     /             _----_            \\  \\".green
  puts "          /     /           _-~      ~-_         |   |".green
  puts "         (      (        _-~    _--_    ~-_     _/   |".green
  puts "          \\      ~-____-~    _-~    ~-_    ~-_-~    /".green
  puts "            ~-_           _-~          ~-_       _-~".green
  puts "               ~--______-~                ~-___-~".green
  puts
  puts "Welcome to Ruby Snake"
  puts
  puts "Move your snake around the screen eating apples ('0's) in order to grow."
  puts
  puts "But beware of running into yourself or running off the screen "
  puts "as this will result in your instant death!"
  puts
  puts "Controls:"
  puts
  puts "\tUp\t-->\te"
  puts "\tDown\t-->\td"
  puts "\tLeft\t-->\to"
  puts "\tRight\t-->\tp"
  puts
  puts "\tQuit\t-->\tq"
  puts
end

def getSkillLevel
  loop do
    puts "Select your skill level:"
    puts 
    puts "\t1\t->\tEasy"
    puts "\t2\t->\tNormal"
    puts "\t3\t->\tHard"
    puts "\t4\t->\tWTF!"
    puts
  
    level = gets.chomp
    if @skill_levels.has_key?(level)
        @speed =  @skill_levels[level]
        break
    end
    puts "That is not a valid selection - please try again"
  end
end

def playNewGame?
  puts "Would you like to pla(y) another game, or (q)uit?"
    #binding.pry;""
    option = gets.chomp
    #binding.pry;""
    if option == 'y'
      return true
    elsif option == 'q'
      return false
    else
      return playNewGame?
    end
end

def newGame
  reset
  getSkillLevel
  puts `clear`
  playGame
end

def playGame
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
      @previous_direction = @direction
      @direction = command
    end
    if @key_moves.has_key?(command)
      @direction = command   
    end
    if move_snake?(@key_moves[@direction]) == false
      system "stty -raw echo"
      if playNewGame?
        newGame
      end
      break
    end

    sleep @speed
    puts `clear`
    print_matrix
  end
end

welcome
newGame
