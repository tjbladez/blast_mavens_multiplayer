class GameWindow < Gosu::Window
  def initialize
    super(*Processor::Screen)
    self.caption = "Bomber"
    @players_hit = {:player_0 => [], :player_1 => []}
    @finish_game = false
  end

  def map
    @map ||= Map.new('resources/maps/basic.txt')
  end

  def draw
    map.draw(0, 0)
    Processor.players.each do |player|
      player.draw
      player.bombs.each(&:draw)
      player.explosions.each(&:draw)
    end
  end

  def update
    Processor.players.each_with_index do |player, index|
      player.update
      player.explosions.each do |explosion|
        Processor.all_bombs.each do |bomb|
          bomb.time_counter = 1 if explosion.at?(bomb.top_x, bomb.top_y)
        end
        players_hit?(explosion, index)
      end
    end

    if @finish_game && Processor.players.map(&:explosions).flatten.empty?
      Processor.game_over(@players_hit)
      close
    end
  end

private
  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def players_hit?(explosion, index)
    Processor.players.each do |player|
      if explosion.at?(player.x, player.y)
        hit    = "player_#{player.index}".to_sym
        hit_by = "player_#{index}".to_sym
        @players_hit[hit] << hit_by unless @players_hit[hit].include?(hit_by)
        @finish_game = true
      end
    end
  end
end