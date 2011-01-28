class Player
  def initialize
    @x = @y = 0
    @t_size = Processor::TileSize
    @sprites = Gosu::Image.load_tiles(Processor.window, "resources/images/temp_char.png", @t_size, @t_size, false)
    @movement = {
      :left   => [-1, 0],
      :right  => [1, 0],
      :up     => [0, -1],
      :down   => [0, 1]
    }
  end

  def draw
    @sprites.first.draw(@x, @y, 1)
  end

  def update(direction)
    move_instruct = @movement[direction]
    if move_instruct
      inc_x, inc_y = *move_instruct
      4.times do |i|#speed
        @x += inc_x
        @y += inc_y
      end
    end
  end
end