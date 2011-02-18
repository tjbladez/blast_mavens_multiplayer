class Window < Gosu::Window
  def initialize
    super(*Processor::Screen)
    self.caption = "Bomber"
  end

  def map
    @map ||= Map.new('resources/maps/basic.txt')
  end

  def draw
    map.draw(0, 0) # no need for scrolling and positioning
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
        Processor.players[0].bombs.each do |bomb|
          bomb.time_counter = 1 if explosion.at?(bomb.top_x, bomb.top_y)
        end
        Processor.players[1].bombs.each do |bomb|
          bomb.time_counter = 1 if explosion.at?(bomb.top_x, bomb.top_y)
        end
        puts "PLAYER1 hit by PLAYER#{index+1} explosion" if explosion.at?(Processor.players[0].x, Processor.players[0].y)
        puts "PLAYER2 hit by PLAYER#{index+1} explosion" if explosion.at?(Processor.players[1].x, Processor.players[1].y)
      end
    end
  end

private
  def button_down(id)
    close if id == Gosu::KbEscape
  end
end