class Bomb
  include Tileable

  attr_accessor :time_counter
  def initialize(x,y)
    # puts "registering x: #{x}, y: #{y}, top_x:#{top_x}, top_y:#{top_y}"
    register!(x, y)
    @t_size      = Processor::TileSize
    @sprites     = Gosu::Image.load_tiles(Processor.window, "resources/images/dyno.png", @t_size, @t_size, false)
    @time_counter = 60
  end

  def draw
    @sprites.first.draw(top_x, top_y, 1)
    update
  end

  def update
    @time_counter -= 1
  end
end