require 'io/console'

def reset_grid
  @grid = Array.new(40, ".").map{|row| Array.new(40, ".")}
end

def print_matrix
  @grid.each_with_index do |row, i|
    print row.join(" ")
    puts
  end
end

x = 20
y = 20

reset_grid();
@grid[x][y]= '@'
print_matrix
c = STDIN.getch

while c != 'q' do
  case c
    when 'e'
      if x >= 0
        x = x - 1
       @grid[x][y]= '@'
      end
    when 'E'
      if x >= 0
        x = x - 1
      end
    when 'd'
      if x < 39
        x = x + 1
        @grid[x][y]= '@'
      end
    when 'D'
      if x < 39
        x = x + 1
      end
    when 'p'
      if y < 39
        y = y + 1
        @grid[x][y]= '@'
      end
    when 'P'
      if y < 39
        y = y + 1
      end
    when 'o'
      if y >= 0
        y = y- 1
        @grid[x][y]= '@'
      end
    when 'O'
      if y >= 0
        y = y - 1
      end
    when  'c'
      reset_grid
      @grid[x][y]= '@'
  end
  puts `clear`
  print_matrix
  c = STDIN.getch
end