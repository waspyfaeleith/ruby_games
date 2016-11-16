require ('./string')
require ('pry-byebug')

class Column
  attr_accessor :cave_top, :cave_bottom, :column, :column_height, :direction

  def initialize (prev_cave_top, cave_height, direction)
    #binding.pry 
    @column_height = 20

    diff = direction == "UP" ? -1 : 1
    if (rand(-1..1) == 0)
      diff = 0
    end
    @cave_top = prev_cave_top +  diff

    #@cave_top = prev_cave_top + rand(-1..1)
    #@cave_bottom = @column_height - 5 #rand(5..10)
    #@cave_bottom = @column_height - (cave_height - @cave_top) 
    #@column_height - 5
    @cave_bottom = @cave_top + cave_height

    @column = []
  end

  def draw
    #binding.pry 
    #puts @cave_top
    #if (inbounds?) 
      for i in 0..@column_height-1
        @column[i] = " ".bg_green
  
      end
      for j in @cave_top..@cave_bottom
        @column[j] = " "#.bg_blue
      end
    #end
  end

  def inbounds?
    if (@cave_top >= 5 && @cave_bottom <= 5)
      return true
    else
      return false
    end
  end


end