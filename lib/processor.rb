require 'tileable'
require 'solid_tile'
require 'menu_window'
require 'game_window'
require 'map'
require 'explosion'
require 'bomb'
require 'player'
require 'basic_brain'
require 'game_over_window'
# Processor is responsible to keep overall configuration knowledge, state
# transitions and keeping track of windows
class Processor
  Screen = [1024, 768, false]
  TileSize = 48
  Caption = "Blast Mavens: Multiplayer Beta v0.1.3"
  class << self
    attr_reader :game_window
    attr_accessor :players

    def new
      @players = []
      MenuWindow.new.show
    end

    def has_at_least_one_player?
      !players.empty?
    end

    def allow_multiplayer?
      true
    end

    def center_map
      @center_map ||={}.tap do |center_coords|
        (0...768).each_slice(48) do |coords_range|
          center_coords[coords_range[24]] = coords_range
        end
      end
    end

    def center_for(x, y)
      [center_for_coord(x), center_for_coord(y)]
    end

    def all_bombs
      players.map {|p| p.bombs}.flatten
    end

    def start_game
      @game_window = GameWindow.new
      2.times { @players << Player.new }
      @game_window.show
    end

    def game_over(death_toll)
      GameOverWindow.new(death_toll).show
    end

  private
    def center_for_coord(coord)
      center = center_map.detect{|center, coords| coords.include?(coord)}
      center && center.first
    end
  end
end