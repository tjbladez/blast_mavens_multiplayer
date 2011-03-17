class GameOverWindow < Gosu::Window

  def initialize(death_toll)
    super(*Processor::Screen)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @death_toll = death_toll
  end

  def draw
    @death_toll.each do |killed, killer|
      @font.draw("#{killed} blowed up to pieces by the #{killer} bomb", 200, 200, 1) unless killer.empty?
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end