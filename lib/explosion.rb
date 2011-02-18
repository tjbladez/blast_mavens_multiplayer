class Explosion
  include Tileable
  attr_accessor :time_counter

  def initialize(x,y)
    register!(x, y)
    @t_size       = Processor::TileSize
    @sprites      = Gosu::Image.load_tiles(Processor.window, "resources/images/tempfire.png", @t_size, @t_size, false)
    @time_counter = 30
  end

  def draw
    @sprites.first.draw(top_x, top_y, 2)
    update
  end

  def update
    @time_counter -= 1
  end
end