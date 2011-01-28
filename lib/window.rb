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
  end

private
  def button_down(id)
    close if id == Gosu::KbEscape
  end
end