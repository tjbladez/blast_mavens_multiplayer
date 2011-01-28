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
    player.draw
  end

  def player
    @player ||= Player.new
  end

  def update
    direction = :left  if button_down? Gosu::Button::KbLeft
    direction = :right if button_down? Gosu::Button::KbRight
    direction = :up    if button_down? Gosu::Button::KbUp
    direction = :down  if button_down? Gosu::Button::KbDown
    player.update(direction)
  end
private
  def button_down(id)
    close if id == Gosu::KbEscape
  end
end