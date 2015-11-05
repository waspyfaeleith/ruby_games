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
        @grid[x][y]= '.'
        x = x - 1
       @grid[x][y]= '@'
      end
    when 'd'
      if x < 39
        @grid[x][y]= '.'
        x = x + 1
        @grid[x][y]= '@'
      end
    when 'p'
      if y < 39
        @grid[x][y]= '.'
        y = y + 1
        @grid[x][y]= '@'
      end
    when 'o'
      if y >= 0
        @grid[x][y]= '.'
        y = y- 1
        @grid[x][y]= '@'
      end
    when  'c'
      reset_grid
      @grid[x][y]= '@'
  end
  puts `clear`
  print_matrix
  c = STDIN.getch
end