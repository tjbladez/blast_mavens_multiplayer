class SolidTile
  attr_accessor :x, :y, :x_range, :y_range

  def initialize(x,y)
    self.x, self.y = x, y
    self.x_range = (x..x+Processor::TileSize)
    self.y_range = (y..y+Processor::TileSize)
  end
end