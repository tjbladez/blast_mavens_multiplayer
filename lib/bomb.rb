class Bomb
  include Tileable

  attr_accessor :time_counter, :solid
  def initialize(x,y)
    register!(x, y)
    @t_size       = Processor::TileSize
    @sprites      = Gosu::Image.load_tiles(Processor.game_window, "resources/images/dynamite.png", @t_size, @t_size, false)
    @time_counter = 80
    @sprite_index = 0
    @solid        = false
  end

  def draw
    @sprites[@sprite_index].draw(top_x, top_y, 1)
    update
  end

  def update
    @time_counter -= 1
    @sprite_index += 1 if @time_counter % 20 == 0
    @sprite_index = 3 if @sprite_index > 3
  end

  def solid_at?(x, y)
    @solid && at?(x, y)
  end
end