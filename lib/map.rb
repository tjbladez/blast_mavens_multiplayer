class Map
  attr_accessor :solid_tiles
  SOLID = [1, 2, 3, 4, 5, 10]

  def initialize(path)
    @path   = path
    @t_size = Processor::TileSize
    @set    = Gosu::Image.load_tiles(Processor.window, 'resources/images/tileset.png', @t_size, @t_size, true)
    register_solid_tiles
  end

  def draw(screen_x, screen_y)
    tiles.each_with_index do |row_array, y|
      row_array.each_with_index do |col, x|
        @set[col].draw(x * @t_size, y * @t_size, 0) #z-order is 0
      end
    end
  end

  def tiles
    @tiles ||= File.readlines(@path).inject([]) do |acc, line|
      tile = []
      line.strip.each_char do |char|
        tile << legend[char]
      end
      acc << tile
      acc
    end
  end

  def register_solid_tiles
    @solid_tiles = []
    tiles.each_with_index do |row, y|
      row.each_with_index do |col, x|
        @solid_tiles << SolidTile.new(x*@t_size, y*@t_size) if SOLID.include?(col)
      end
    end
  end

  def solid_at?(x,y)
    @solid_tiles.detect {|tile| tile.at?(x,y) } || x < 0 || y < 0
  end

  def legend
    {
      '.'  => 0,
      'x'  => 10,
      ']'  => 2,
      '-'  => 3,
      '='  => 1,
      '['  => 5,
      '/'  => 6,
      '\\' => 7,
      '<'  => 8,
      '>'  => 9
      }
  end
end
