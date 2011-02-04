class Player
  def initialize
    @x = @y = 49
    @t_size = Processor::TileSize
    @sprites = Gosu::Image.load_tiles(Processor.window, "resources/images/temp_char.png", @t_size, @t_size, false)
    @movement = {
      :left   => [[-1, 0],[0, 0, 0, 43]],
      :right  => [[1, 0], [43, 0, 43, 43]],
      :up     => [[0, -1],[43, 0, 0, 0]],
      :down   => [[0, 1],[43, 43, 0, 43 ]]
    }
  end

  def draw
    @sprites.first.draw(@x, @y, 1)
  end

  def update(direction)
    move_instruct = @movement[direction]
    if move_instruct
      x_y = move_instruct.first
      inc_x, inc_y = x_y
      tar_x1, tar_y1, tar_x2, tar_y2 = *move_instruct.last
      4.times do |i|#speed
        if no_collision?(x_y + [tar_x1, tar_y1]) && no_collision?(x_y + [tar_x2, tar_y2])
          @x += inc_x
          @y += inc_y
        end
      end
    end
  end

  def no_collision?(target)
    !Processor.window.map.solid_at?(@x+target[0]+target[2], @y+target[1]+target[3])
  end
end