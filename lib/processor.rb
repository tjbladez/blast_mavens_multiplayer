require 'solid_tile'
require 'window'
require 'map'
require 'player'

# Processor is responsible to keep overall configuration knowledge, state
# transitions and keeping track of windows
class Processor
  Screen = [1024, 768, false]
  TileSize = 48
  class << self
    attr_reader :window
    def new
      @window = Window.new
      @window.show
    end
  end
end