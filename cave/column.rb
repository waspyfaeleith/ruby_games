require ('./string')

class Column
  attr_accessor :cave_top, :cave_bottom, :column, :column_height

  def initialize (prev_cave_top, cave_height)
    @column_height = 40
    @cave_top = prev_cave_top + rand(-1..2)
    @cave_bottom = @column_height - rand(10..20)
    @column = []
  end

  def draw 
    #puts @cave_top
    for i in 0..@column_height-1
      @column[i] = " ".bg_green
    end
    for j in @cave_top..@cave_bottom
      @column[j] = " ".bg_blue
    end
  end


end