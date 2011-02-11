class Bomb
  attr_accessor :time_counter
  def initialize(x,y)
    @x, @y = x, y
    @t_size      = Processor::TileSize
    @sprites     = Gosu::Image.load_tiles(Processor.window, "resources/images/dyno.png", @t_size, @t_size, false)
    @x_range = (@x..@x+Processor::TileSize)
    @y_range = (@y..@y+Processor::TileSize)
    @time_counter = 60
  end

  def draw
    @sprites.first.draw(@x, @y, 1)
    update
  end

  def update
    @time_counter -= 1
  end

  def center
    @center ||= [@x + @t_size/2 , @y + @t_size/2]
  end

  def at?(x, y)
    @x_range.include?(x) && @y_range.include?(y)
  end
end