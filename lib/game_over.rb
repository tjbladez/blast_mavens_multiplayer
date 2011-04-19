class GameOver
  def initialize(window, death_toll)
    @window = window
    @font = Gosu::Font.new(@window, Gosu::default_font_name, 20)
    @death_toll = death_toll
  end

  def draw
    @font.draw('It is a draw, both players died', 200, 200, 1) if draw?
    @font.draw("Player 2 won. Player 1 was blown up by #{killer(:player_0)}", 200, 200, 1) if player_0_hit?
    @font.draw("Player 1 won. Player 2 was blown up by #{killer(:player_1)}", 200, 200, 1) if player_1_hit?
  end

  def button_down(id)
    Processor.close if id == Gosu::KbEscape
  end

  def update
    # do nothing
  end
private
  def draw?
    player_0_hit? && player_1_hit?
  end

  def player_0_hit?
    !@death_toll[:player_0].empty?
  end

  def player_1_hit?
    !@death_toll[:player_1].empty?
  end

  def killer(player)
    "Player #{@death_toll[player].first.to_s[-1..-1].to_i + 1}"
  end
end