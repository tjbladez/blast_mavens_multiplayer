class SolidTile

  def initialize(x,y)
    @x, @y = x, y
    @x_range = (@x...@x+Processor::TileSize)
    @y_range = (@y...@y+Processor::TileSize)
  end

  def at?(x, y)
    @x_range.include?(x) && @y_range.include?(y)
  end
end