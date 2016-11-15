require ('./string')

class Column
  attr_accessor :cave_top, :cave_bottom, :column, :column_height, :direction

  def initialize (prev_cave_top, cave_height, direction)
    @column_height = 20
    
    diff = direction == "UP" ? 1 : -1
    @cave_top = prev_cave_top +  diff

      #@cave_top = prev_cave_top + rand(-1..1)
    #@cave_bottom = @column_height - 5 #rand(5..10)
    @cave_bottom = @column_height - 5

    @column = []
  end

  def draw 
    #puts @cave_top
    for i in 0..@column_height-1
      @column[i] = " ".bg_green

    end
    for j in @cave_top..@cave_bottom
      @column[j] = " "#.bg_blue
    end
  end


end