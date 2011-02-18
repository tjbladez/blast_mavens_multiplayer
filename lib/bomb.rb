class Bomb
  include Tileable

  attr_accessor :time_counter
  def initialize(x,y)
    register!(x, y)
    @t_size       = Processor::TileSize
    @sprites      = Gosu::Image.load_tiles(Processor.window, "resources/images/dynoset.png", @t_size, @t_size, false)
    @time_counter = 60
    @sprite_index = 0
  end

  def draw
    @sprites[@sprite_index].draw(top_x, top_y, 1)
    update
  end

  def update
    @time_counter -= 1
    @sprite_index += 1 if @time_counter % 15 == 0
  end

end