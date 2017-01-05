require ('./string')
require ('pry-byebug')

class Column
  attr_accessor :cave_top, :cave_bottom, :column, :column_height#, :direction

  @@direction
  @@count

  def initialize (prev_cave_top, cave_height, direction)
    #binding.pry 
    @column_height = 20
    @@count = 0

    if (rand(-1..1) == 0)
      @@direction = 0
      @@count = 20
    end

    if @@count == 0
      @@direction = direction == "UP" ? -1 : 1
    else 
      @@count -= 1
    end
    
    @cave_top = prev_cave_top + @@direction

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