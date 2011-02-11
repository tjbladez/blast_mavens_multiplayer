require 'solid_tile'
require 'window'
require 'map'
require 'bomb'
require 'player'

# Processor is responsible to keep overall configuration knowledge, state
# transitions and keeping track of windows
class Processor
  Screen = [1024, 768, false]
  TileSize = 48
  class << self
    attr_reader :window
    attr_accessor :players

    def new
      @players = []
      @window = Window.new
      2.times { @players << Player.new }
      @window.show
    end

    def has_at_least_one_player?
      !players.empty?
    end

    def allow_multiplayer?
      true
    end

  end
end