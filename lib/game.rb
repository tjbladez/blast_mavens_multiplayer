class Game
  def initialize(window, opts={})
    @window      = window
    @players_hit = {:player_0 => [], :player_1 => []}
    @finish_game = false
    @song        = Gosu::Song.new(@window, BLAST_SND_PATH + 'battle.mp3')
    @song.volume = 0.3
    @song.play(true)
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
      @song.stop
      Processor.game_over(@players_hit)
    end
  end

  def map
    @map ||= Map.new(BLAST_MAP_PATH + 'basic.txt')
  end

  def button_down(id)
    Processor.close     if id == Gosu::KbEscape
    @song.volume -= 0.1 if id == Gosu::KbNumpadSubtract
    @song.volume += 0.1 if id == Gosu::KbNumpadAdd
  end

private
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