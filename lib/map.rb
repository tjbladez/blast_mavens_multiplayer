class Map
  def initialize(path)
    @path   = path
    @t_size = Processor::TileSize
    @set    = Gosu::Image.load_tiles(Processor.window, 'resources/images/tileset.png', @t_size, @t_size, true)
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

  def legend
    {
      '.'  => 0,
      'x'  => 1,
      '-'  => 1,
      '|'  => 1,
      '/'  => 1,
      '\\' => 1,
      '<'  => 1,
      '>'  => 1
      }
  end
end
